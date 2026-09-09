---
name: ship-check
description: Runs verification before marking work done. Use when user asks to ship, merge, verify, or confirm complete. Scoped — only agent-touched failures block ship.
last_updated: 2026-09-09
---

# Ship check

Run **before** claiming done or merge-ready. See `docs/VERIFICATION-CONTRACT.md`.

## Pre-gates

| Situation | Note |
|-----------|------|
| 3+ files without prior plan | Flag advisory; run gates anyway |
| New behavior in tested area | Prefer `/tdd` was used |
| Deploy touched | Confirm promote checklist |

## By stack (adapt to project)

| Stack | Typical gates |
|-------|---------------|
| **Node/TS** | `pnpm lint` · `pnpm build` · `pnpm test` |
| **Python** | `python -m py_compile <files>` · `pytest` if present |
| **Rust** | `cargo check` · `cargo test` · `cargo clippy` |
| **Go** | `go vet` · `go test ./...` |
| **Docs only** | Link check · spell if configured |

## Report format

| Gate | Result | Scope |
|------|--------|-------|
| lint | pass/fail/skipped | files |
| build/test | pass/fail/skipped | — |
| scoped claim | pass | agent vs pre-existing |

Then: **Ship** · **No ship** · **Pre-existing failures** (listed separately)

## Escalation

Non-trivial diffs → `adversarial-verifier` after gates. Max **3** loops.
