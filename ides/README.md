# IDE adapters (full kit)

> _Last updated: 2026-09-09_

One harness, **full kit per IDE** — rules, skills, MCP profiles, and delegate briefs (adapted subagents). Only Cursor has native subagent dispatch; every other IDE gets the same workflow via `delegates/`.

| Tier | IDEs | Meaning |
|------|------|---------|
| **Full (native)** | Cursor | All surfaces native; tested weekly |
| **Full (kit)** | All others | Every column covered — native or adapted |

Source of truth: [`config/ide-matrix.yaml`](../config/ide-matrix.yaml) · Deep dive: [`docs/IDE-PARITY.md`](../docs/IDE-PARITY.md) · Live matrix: [klarix.ai/harness/ides](https://klarix.ai/harness/ides)

## Install

```powershell
pwsh -File install.ps1                              # Cursor
pwsh -File install.ps1 -Ide claude-code
pwsh -File install.ps1 -Ide windsurf
pwsh -File install.ps1 -Ide cline
pwsh -File install.ps1 -Ide vscode-copilot
# … roo, continue, zed, jetbrains-junie
```

## Regenerate + verify

```powershell
pwsh -File scripts/build-ides.ps1
pwsh -File scripts/verify-ides-parity.ps1   # CI runs this on PR
```

Edit canonical assets only: `cursor-rules/`, `cursor-skills/`, `cursor-agents/`, `config/mcp-profiles/`.
