# Concurrency and Systems — Practical Reference

> _Last updated: 2026-09-09_

A working guide for agents and engineers choosing concurrency primitives, runtimes, and language tiers. Signal over theory — enough to decide correctly, not enough to write a kernel.

---

## When to reach for Rust/C vs higher-level languages

| Signal | Stay in Python / TypeScript / Go | Reach for Rust or C |
|--------|----------------------------------|---------------------|
| Dominant cost is I/O wait (HTTP, DB, queues) | Yes — async or thread pool | Rarely — runtime overhead is noise |
| Hot loop over millions of items per second | No | Yes — SIMD, cache locality, zero-copy |
| Latency SLO under ~1 ms on commodity hardware | Unlikely without native extension | Yes |
| Memory budget is tight (embedded, edge, mobile daemon) | Risky — GC + interpreter overhead | Yes |
| Correctness under shared mutable state is hard to prove | Prefer message passing / immutability | Rust ownership catches data races at compile time |
| FFI boundary already exists (NumPy, PyO3, napi-rs) | Extend in Rust/C at the boundary only | Yes — thin native core, thick orchestration layer |
| Team ships weekly; no perf regression budget | Yes | Only with profiling evidence |

**Rule of thumb:** profile first. If ≥30% of wall time sits in a tight CPU loop or allocation churn, native code earns its complexity. If the flame graph is flat under `poll` / `read` / `await`, fix architecture before rewriting in Rust.

---

## Primitives: semaphores, mutexes, atomics

| Primitive | What it guards | Typical use | Pitfall |
|-----------|----------------|-------------|---------|
| **Mutex** | One writer (or one critical section) at a time | Shared struct, cache, connection pool slot | Lock ordering → deadlock; holding lock across I/O |
| **RwLock** | Many readers OR one writer | Read-heavy config, lookup tables | Writer starvation if readers never yield |
| **Semaphore** | N concurrent holders of a resource | DB connection cap, API rate limit, worker pool admission | Forgetting to `release` → permanent capacity loss |
| **Condvar** | Wait until condition true (paired with mutex) | Producer/consumer with backpressure | Spurious wakeups — always re-check condition in loop |
| **Atomic** | Single word, lock-free RMW | Counters, flags, lock-free queue head/tail | ABA problem on complex structures; false sharing on cache lines |

### When and why

- **Mutex** when multiple threads touch the same mutable object and the critical section is short (microseconds, not milliseconds).
- **Semaphore** when the scarce resource is *counted* (connections, disk handles, GPU slots) — not ownership of one blob.
- **Atomics** when one word suffices (refcount, shutdown flag, stats). Prefer `Acquire`/`Release` ordering over `SeqCst` unless you have a measured reason.

POSIX: `sem_init(3)` — counting semaphore API. Linux implements much of this on **futex** (`futex(2)`) — fast userspace path when uncontended, kernel wake when blocked. Read man pages when debugging mysterious wake latency.

---

## Async: futures, tokio, concurrent.futures

| Model | Mechanism | Best for | Weak at |
|-------|-----------|----------|---------|
| **async/await** | Cooperative tasks yield at `.await` | Many concurrent I/O-bound operations | CPU-bound work on the same executor |
| **Futures (Rust)** | Lazy until polled; zero-cost state machine | Composable pipelines, backpressure with streams | Debugging stack traces across `.await` |
| **Tokio** | Multi-thread work-stealing runtime + I/O driver | Production Rust network services | Blocking syscalls on async threads — use `spawn_blocking` |
| **concurrent.futures (Python)** | `ThreadPoolExecutor`, `ProcessPoolExecutor`, `asyncio` bridge | Scripts, batch jobs, mixed sync/async glue | GIL limits CPU parallelism in threads |

**Python:** `asyncio` for I/O; `ProcessPoolExecutor` for CPU; never block the event loop with sync I/O or heavy compute.

**Rust:** `tokio::spawn` for async tasks; `tokio::task::spawn_blocking` or `rayon` for CPU; `std::thread` when you need an OS thread with its own stack and no executor coupling.

**TypeScript:** async/await on a single-threaded event loop — same rule as Python: offload CPU to worker threads (`worker_threads`) or a native addon.

---

## Memory model (practical, not academic)

CPUs and compilers reorder instructions. Without rules, two threads can disagree on what "happened first."

| Concept | Plain meaning |
|---------|---------------|
| **Happens-before** | If A happens-before B, B sees all writes A made. |
| **Data race** | Two threads access same location, at least one write, no synchronization → undefined behavior (C/Rust) or subtle bugs (others). |
| **Release store** | Writes before it are visible to threads that later **Acquire** load the same atomic. |
| **Relaxed** | Atomic RMW without cross-thread ordering — counters only, no publishing pointers. |
| **SeqCst** | Global order — simple mental model, often slower; default in many languages. |

**Agent guidance:** if code shares mutable state across threads without mutex or atomic, flag it. In Rust, prefer types that encode the protocol (`Arc<Mutex<T>>`, channels). In C, document every shared field's lock or atomic discipline.

---

## Lock-free vs locked

| | Lock-free (atomics, CAS loops) | Locked (mutex) |
|--|-------------------------------|----------------|
| **Latency under low contention** | Often lower — no syscall | Fine for short sections |
| **Latency under high contention** | Retries, cache line bouncing | Predictable queue at mutex |
| **Complexity** | High — ABA, memory reclamation (epoch, hazard pointers) | Low |
| **Priority inversion** | Possible on some platforms | Mutex protocols vary |
| **When to choose** | Proven hot path, measured mutex cost | Default until profiling says otherwise |

**Default to locks.** Move to lock-free only with benchmarks showing mutex as top frame and a bounded, well-tested structure (queue, counter). Herb Sutter's "lock-free" articles stress: lock-free ≠ wait-free; you may still starve.

---

## OS threads vs green threads vs async tasks

| Kind | Scheduled by | Stack | Preempted? | Typical scale |
|------|--------------|-------|------------|---------------|
| **OS thread** | Kernel | MB (default) | Yes (time slice) | Hundreds–low thousands |
| **Green thread (coroutine)** | Runtime library | Small, pooled | Cooperative at yield points | Thousands–millions (language-dependent) |
| **Async task** | Executor (Tokio, asyncio) | State machine on heap | At `.await` only | Tens of thousands+ I/O-bound |

```
[ OS thread ] ── runs ──> [ executor ] ── polls ──> [ task task task ... ]
                              │
                              └── blocking pool (optional) for sync I/O / CPU
```

- **OS threads:** parallel CPU, isolation, blocking syscalls OK.
- **Green threads:** historical (early Go before netpoll, Ruby fibers) — know your runtime's current model.
- **Async tasks:** one thread can juggle many connections; **never** run long CPU work on the executor without offload.

Mixing models is normal: N OS threads each running an async executor (Tokio default).

---

## Agent guidance: native code vs Python/TypeScript

Suggest **staying high-level** when:

- Task is glue, CRUD, orchestration, LLM calls, file transforms under ~100 ms.
- Concurrency need is "many HTTP calls" — async + connection pool suffices.
- Correctness risk from manual memory exceeds perf gain.
- No profiler data; user asked for "make it faster" without a bottleneck.

Suggest **Rust/C (or a native extension)** when:

- User shows flame graph / `cProfile` / `perf` with hot native-eligible loop.
- Requirements include: deterministic latency, no GC pauses, `#![no_std]`, cross-language ABI stability.
- Shared-memory parallelism with strict safety requirements — Rust before raw C if greenfield.
- Building a long-lived daemon at high QPS where interpreter + GC overhead is measurable.

Suggest **concurrency primitive changes** (not language change) when:

- Overserialized work — increase parallelism with semaphore-bounded pool.
- Event loop blocked — move blocking call to thread pool.
- Thundering herd — add semaphore or single-flight around cache fill.

Always recommend: measure → identify dominant cost → smallest fix (algorithm > batching > native rewrite).

---

## Public references

| Topic | URL |
|-------|-----|
| Rust Book — Fearless Concurrency | https://doc.rust-lang.org/book/ch16-00-concurrency.html |
| Tokio tutorial (async Rust) | https://tokio.rs/tokio/tutorial |
| Herb Sutter — lock-free fundamentals | https://herbsutter.com/2014/01/13/gotw-95-solution-thread-safety-and-synchronization/ |
| Herb Sutter — atomic<> ordering | https://herbsutter.com/2014/11/25/thread-safety-and-atomic-types/ |
| Linux `sem_init(3)` | https://man7.org/linux/man-pages/man3/sem_init.3.html |
| Linux `futex(2)` | https://man7.org/linux/man-pages/man2/futex.2.html |
| Python `concurrent.futures` | https://docs.python.org/3/library/concurrent.futures.html |
| Python `asyncio` | https://docs.python.org/3/library/asyncio.html |

---

## Quick decision checklist

1. **I/O-bound?** → async + bounded concurrency (semaphore or pool limit).
2. **CPU-bound in Python/JS?** → process pool or native extension — not more threads (GIL/event loop).
3. **Shared mutable state?** → mutex or message passing; atomics only for metrics/flags.
4. **Still slow?** → profile, then consider Rust/C at the hot boundary — not a full rewrite by default.
5. **Ship safety over peak perf?** → locks, channels, structured concurrency; document invariants.
