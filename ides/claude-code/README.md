# Claude Code adapter

Copy into your project root:

| Source | Destination |
|--------|-------------|
| `HARNESS.md` | `HARNESS.md` |
| `AGENTS.template.md` | `AGENTS.md` (rename) |
| `cursor-skills/*` | `.claude/skills/` (same SKILL.md format) |
| MCP profile YAML from docs | `.mcp.json` or `claude mcp add` |

Install: `pwsh -File ../../install.ps1 -Ide claude-code`
