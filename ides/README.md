# IDE adapters

> _Last updated: 2026-09-09_

One harness, many install paths. **Edit source in `cursor-rules/` and `cursor-skills/`** (Cursor canonical). Run `scripts/build-ides.ps1` to refresh generated `ides/cursor/` output. Other IDE folders document copy paths until full generation ships.

| Tier | IDEs | Meaning |
|------|------|---------|
| **Full** | Cursor | Tested weekly — rules, skills, MCP profiles, subagents |
| **Supported** | Claude Code, Windsurf | Native rules + skills + MCP; no subagent router |
| **Community** | Copilot, Cline, Roo, Continue, Zed, Junie | Documented paths; not in weekly CI |

Live matrix: [klarix.ai/harness/ides](https://klarix.ai/harness/ides)

## Install

```powershell
# Cursor (default)
pwsh -File install.ps1

# Target a specific adapter folder into your repo
pwsh -File install.ps1 -Ide claude-code
pwsh -File install.ps1 -Ide windsurf
```

Regenerate adapter stubs after editing rules/skills:

```powershell
pwsh -File scripts/build-ides.ps1
```
