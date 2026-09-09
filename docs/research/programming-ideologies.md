# Programming Ideologies for Agent Harnesses

> _Last updated: 2026-09-09_

Synthesis of public voices and design schools that shape how humans and agents should work together on code. These are **opinionated heuristics**, not laws — pick the axis that matches your constraint (time, risk, scale).

---

## Voice Map

| Voice | Core claim | Primary artifact | Best when |
|-------|-----------|------------------|-----------|
| [ThePrimeagen / 99](https://github.com/ThePrimeagen/99) | Augment the programmer; semantic search beats grep for architecture | Neovim plugin + `#rules` / `@files` context | You stay in the editor; exploration is the bottleneck |
| [Theo / t3.gg](https://github.com/pingdotgg/t3code) | Context and harness matter more than model choice | T3 Code control plane over provider CLIs | You run multiple agents (Codex, Claude, Cursor) and need one shell |
| [Matt Pocock / skills.sh](https://github.com/mattpocock/skills) | Encode process as skills; spec before code | `grill → to-spec → to-tickets → implement → code-review` | Multi-session work; you want deterministic handoffs |
| [Coding Sloth](https://codesloth.blog/) | Specific prompts, verification gates, fresh context per task | Skills router + test-first verification | Usage limits or quality drift as context grows |
| Unix philosophy | Small tools, text streams, compose | Pipelines, CLIs, `stdin`/`stdout` contracts | Automation, scripting, agent tool boundaries |
| Worse is Better | Ship 50–80% that spreads; refine later | Minimal viable interfaces | Greenfield adoption, platform competition |
| Local reasoning | Understand a unit without loading the world | Bounded modules, explicit deps | Large repos, agent context budgets |

---

## ThePrimeagen — 99: Augment, Don't Replace

99 treats the LLM as a **search and transform layer** inside Neovim, not a replacement for typing.

| Practice | Mechanism | Why it works |
|----------|-----------|--------------|
| Semantic search | Natural-language queries → quickfix list with notes | Faster than ripgrep for "where is auth handled?" class questions |
| `#rules` injection | Autocomplete SKILL.md / rule files into prompt | Domain context without pasting whole docs |
| `@files` scoping | Fuzzy file pick (respects `.gitignore`) | Narrows context; reduces hallucinated paths |
| Native completions | Built-in `#` / `@` completion (optional cmp/blink) | Less plugin ceremony; stays in flow |
| Worker / work items | Track feature; search for remaining gaps | Turns exploration into a checklist |

**Takeaway:** Prefer **information surfacing** (search, quickfix, notes) over blind codegen. The programmer keeps judgment; the harness surfaces signal.

Sources: [99 README](https://github.com/ThePrimeagen/99) · [Search workflow guide](https://mintlify.wiki/ThePrimeagen/99/guides/search-workflow)

---

## Theo — Context > Model, Harness as Control Plane

[T3 Code](https://github.com/pingdotgg/t3code) is explicitly **not** an agent engine. It is a **local server** that wraps provider harnesses (Codex, Claude Code, Cursor, Grok, OpenCode) and normalizes their events into one UI.

| Layer | Responsibility |
|-------|----------------|
| Provider CLI | Model loop, native tools, protocol quirks |
| Adapter | Translate provider stream → common events |
| Control plane | Projects, threads, permissions, diffs, terminals, git |
| Client | Web / desktop / mobile — same read model |

**Takeaway:** Model upgrades are cheap; **consistent context, approvals, and diffs** are expensive to rebuild. Invest in the shell around agents, not in yet another model wrapper.

Sources: [T3 Code AGENTS.md](https://github.com/pingdotgg/t3code/blob/main/AGENTS.md) · [Flavio Copes deep dive](https://flaviocopes.com/t3-code/)

---

## Matt Pocock — Skills as Executable Process

The [skills.sh](https://skills.sh) workflow encodes engineering process so agents follow the same path every time.

```
grill-with-docs → to-spec → to-tickets → implement → code-review
```

| Skill | Role |
|-------|------|
| `to-spec` | Synthesize conversation → published spec (no re-interview) |
| `to-tickets` | Vertical **tracer-bullet** slices with explicit blockers |
| `implement` | Build at pre-agreed **seams**; drives TDD internally |
| `code-review` | Parallel Standards + Spec axes |

Key ideas:

- **Seams** — stable test boundaries chosen *before* implementation; tests stay honest when internals move.
- **Tracer bullets** — each ticket cuts through schema → API → UI → tests; never "only the database layer."
- **Smart zone** — treat ~100–140k tokens as the reliable window; compress to spec and start fresh sessions for long work.
- **One ticket per context** — parallel agents only when blocking graph allows it.

Sources: [mattpocock/skills README](https://github.com/mattpocock/skills/blob/main/README.md) · [implement docs](https://github.com/mattpocock/skills/blob/main/docs/engineering/implement.md) · [5 skills essay](https://www.aihero.dev/5-agent-skills-i-use-every-day)

---

## Coding Sloth — Specificity, Verification, Parallelism

Public posts and long-form videos converge on **treating agents like junior engineers who never self-verify unless told**.

| Lever | Practice |
|-------|----------|
| Prompts | Surgical, explicit; forbid research tangents; say what *not* to do |
| Context | New session per task; don't carry 500k tokens of drift |
| Verification | Tests **before** implementation; linters/typecheck; browser/screenshot for UI |
| Skills router | Classify intent → announce path → load only matching workflow + references |
| Parallel workers | Git worktrees per agent; human gate before merge to main |
| Resumability | Progress files (`update_process.md`) for interrupted multi-step plans |

**Takeaway:** "Looks done" ≠ done. Verification turns agent output into engineering output.

Sources: [Scalable skills for agentic workflows](https://codesloth.blog/building-scalable-skills-for-agentic-workflows/) · [1000+ hours with Claude Code](https://moderncreator.app/2026-08-18-the-coding-sloth-i-ve-spent-1-000-hours-with-claude-code-here-s-what-actually-works) · [Automate workflows with Cursor](https://codesloth.blog/how-to-automate-engineering-workflows-with-cursor-ai-and-claude/)

---

## Unix Philosophy

Classic [Unix design rules](https://en.wikipedia.org/wiki/Unix_philosophy) (McIlroy, Pike, Thompson variants):

1. Do one thing well.
2. Expect output of one program to become input to another.
3. Design for composition early.
4. Prefer human-readable text streams.
5. Silence is golden — no news is good news.

**Agent harness mapping:** Tools should be **small, composable, stderr-quiet** CLIs with stable JSON/text output. Agents call `rg`, not bespoke search scripts. Pipelines beat monoliths.

---

## Worse is Better (New Jersey Style)

Richard Gabriel's [1989 essay](https://www.jwz.org/doc/worse-is-better.html) argues "worse" designs often **win adoption** because they optimize survival over elegance.

| Priority (Worse is Better) | Deprioritized |
|----------------------------|---------------|
| Implementation simplicity | Interface simplicity |
| Early delivery | Completeness |
| Portability | Absolute correctness |
| Spread / iteration | Consistency at all costs |

Gabriel's heuristic: **get half the right thing out**, let it spread like a virus, then improve to 90%. Gerald Weinberg's complementary frame — ["quality is value to some person"](https://en.wikipedia.org/wiki/Gerald_Weinberg) — reminds us "worse" is contextual, not an excuse for harm.

---

## Local Reasoning

[Local reasoning](https://aipatternbook.com/local-reasoning) = understand a function/module **without loading five other files**. Critical for humans *and* agents with finite context.

| Supports local reasoning | Erodes it |
|--------------------------|-----------|
| Explicit parameters over globals | Hidden singletons |
| Pure functions at core; IO at edges | Scattered side effects |
| Clear module ownership | "God" orchestrators |
| Short, focused units | Callback chains across layers |

**Reasoning radius** ([Syed Aslam](https://syedaslam.com/posts/the-local-reasoning-budget-of-a-codebase/)): count locations you must inspect to predict behavior. Every abstraction should *shrink* that radius or pay its cost deliberately.

---

## Simplicity vs Performance vs Correctness

No universal winner — pick by **constraint**:

| Constraint dominates | Prefer | Example |
|---------------------|--------|---------|
| Time-to-learn / time-to-ship | Simplicity | CLI flags over config DSL; defaults over options |
| User-facing latency / cost at scale | Performance | Index hot paths; batch I/O; cache with explicit invalidation |
| Money, safety, compliance | Correctness | Transactions, idempotency, formal tests at seams |
| Adoption / ecosystem | Worse is Better spread | Minimal API surface; migrate users later |
| Agent + human maintainability | Local reasoning | Bounded modules; explicit contracts |

**Decision matrix:**

| Question | Simplicity | Performance | Correctness |
|----------|------------|-------------|-------------|
| When wrong hurts users? | Low priority | Medium | **High** |
| When wrong only slows devs? | **High** | Medium | Medium |
| When bottleneck is ops cost? | Medium | **High** | Medium |
| When nobody uses it yet? | **High** | Defer | Defer |

**Rule of thumb:** Default to simplicity and local reasoning. Add performance where measured. Add correctness where failure is expensive or irreversible.

---

## Further Reading

| Topic | Link |
|-------|------|
| Agentic coding patterns | [aipatternbook.com](https://aipatternbook.com/) |
| Parallel agents + worktrees | [Superset parallel agents guide](https://superset.sh/blog/parallel-coding-agents-guide) |
| Technical debt vs quality | [Martin Fowler — Is High Quality Worth the Cost?](https://martinfowler.com/articles/is-quality-worth-cost.html) |
| Good-enough software | [Pragmatic Programmer — good enough](https://pragprog.com/titles/tpp20/) |
