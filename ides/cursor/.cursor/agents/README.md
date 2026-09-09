# Subagent specs

Copy to Cursor agents directory or reference when configuring project subagents.

Sync: manual copy or your IDE's agent import. Not handled by `install.ps1` (rules/skills only).

| Agent | ROI | When |
|-------|:---:|------|
| `caveman-explore` | S | Wide locate, read-only |
| `caveman-review` | A | Diff/PR quick review |
| `adversarial-verifier` | S | Pre-ship skeptical gate |
| `verifier` | A | Lighter acceptance check |
| `highspeed` | A | Small scoped execute |
| `md-plain-language` | A | Human-facing prose |
| `db-architect` | A | Schema/migrations |
