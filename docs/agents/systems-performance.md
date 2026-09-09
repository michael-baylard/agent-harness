# Systems & performance

> _Last updated: 2026-09-09_

Best practices for **agent-assisted development** — not "rewrite everything in Rust."

## Stack map (typical)

| Layer | Performance lever |
|-------|-------------------|
| Agent locate | **Rust CLIs** (`rg`, `fd`, `ast-grep`) |
| App logic | Match stack (TS, Python, Go, Rust) |
| Hot-path batch | Profile first; native only when measured |
| Agent inference | Cloud APIs — not local GPU by default |

## Native CLIs (adopted)

| Tool | Replaces | Install |
|------|----------|---------|
| `rg` | grep -r, findstr | winget / brew |
| `fd` | find, Get-ChildItem -Recurse | winget / brew |
| `ast-grep` | fragile regex refactors | winget / brew |

Skill: `fast-ops`. Full catalog: [`references.md`](../research/references.md).

## When to add Rust/C

| Trigger | Action |
|---------|--------|
| Profile shows hot loop >30s in interpreted code | Small Rust CLI or library |
| Correctness needs atomics/memory order | Rust or C with tests |
| Simple CRUD / UI | Stay high-level |

Deep dive: [`concurrency-and-systems.md`](../research/concurrency-and-systems.md)

## Alpha distribution (model outputs)

```
Plan (thinking model)
  → Research (cheap/fast breadth)
  → Pick or merge candidates
  → Implement (scoped diff)
  → ship-check (deterministic)
  → promote (human)
```

| Rule | Why |
|------|-----|
| Never merge unverified output on coupled surfaces | API ↔ client ↔ schema |
| Research ≠ implement | Separate chats |
| Deterministic gates beat re-prompting | build, test, lint |
| Max 3 adversarial loops | Then human |

## Swap matrix

| Avoid | Use instead |
|-------|-------------|
| Shell recursion search | `rg` / `fd` |
| Auto-compact continue | `/session-handoff` |
| 10+ MCP servers | One profile ≤6 |
| Copy-paste influencer rules | Audit **your** failures → rules |
