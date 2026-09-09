# Tracked Cursor rules

Sync to consuming repo:

```powershell
pwsh -File install.ps1
# or manually: cursor-rules/* → .cursor/rules/
```

Restart Cursor after sync.

| Rule | Always on | Purpose |
|------|:---------:|---------|
| `agent-workflow.mdc` | yes | Phase protocol + skill router |
| `caveman-signal.mdc` | yes | Response format + delegation |
| `mcp-routing.mdc` | yes | ≤6 MCP servers, profiles |
| `subagent-arsenal.mdc` | yes | When to spawn subagents |
| `fast-ops.mdc` | no | Rust CLI search policy |
