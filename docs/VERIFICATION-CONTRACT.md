# Verification contract

> _Last updated: 2026-09-09_

Ordered gates before marking work **done**. Only **agent-touched** failures block ship; report pre-existing separately.

## Universal order

| # | Gate | Required when |
|---|------|---------------|
| 1 | Plan existed for 3+ file change | Multi-file edits |
| 2 | Lint / format on touched paths | Code change |
| 3 | Build / compile | Code change |
| 4 | Tests (if infra exists) | Behavior change |
| 5 | Manual smoke (if user-facing UI) | New routes/components |
| 6 | `adversarial-verifier` | Non-trivial diff |

## Stack examples

| Stack | Commands |
|-------|----------|
| TypeScript/Node | `pnpm lint` · `pnpm build` · `pnpm test` |
| Python | `python -m py_compile <files>` · `pytest` |
| Rust | `cargo check` · `cargo test` · `cargo clippy` |
| Go | `go vet ./...` · `go test ./...` |
| Docs only | Link check · no broken internal paths |

## Scoped claims rule

```
PASS agent scope  = failure in file/agent line agent touched
FAIL agent scope  = agent introduced regression
ADVISORY          = pre-existing failure outside diff
```

## Max loops

- **3** implement ↔ adversarial-verifier cycles → human review

## Skill

Run via `ship-check` skill before "done" / PR / merge language.
