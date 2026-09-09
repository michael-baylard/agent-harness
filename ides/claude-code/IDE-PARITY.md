# IDE parity — native vs adapted

> _Last updated: 2026-09-09_

**Can every IDE show a full harness kit (rules, skills, MCP profiles, subagents)?** Yes — with one honest caveat.

| Surface | Cursor | Other IDEs |
|---------|--------|------------|
| **Rules** | Native `.mdc` | Native or generated paths (see `config/ide-matrix.yaml`) |
| **Skills** | Native `.cursor/skills/` | `.agents/skills/` (open SKILL.md standard) + IDE-specific dirs |
| **MCP profiles** | `.cursor/mcp.json` + `config/mcp-profiles/` | Per-IDE MCP config templates + same profile YAML |
| **Subagents** | Native `.cursor/agents/` dispatch | **Adapted:** `delegates/*.md` briefs + `/parallel-work` skill (new chat / mode handoff) |

Only **Cursor** has a first-class subagent router. Every other IDE gets the same *workflow* via portable delegate briefs copied from `cursor-agents/` → `delegates/`. That counts as **full kit** on the matrix, not a missing column.

## Tiers

| Label | Meaning |
|-------|---------|
| **Full (native)** | Cursor — all four surfaces native; tested weekly in Klarix |
| **Full (kit)** | Harness ships generated adapter folder; every column native or adapted |

There are no per-IDE SKUs. Pro ($49 once) includes every adapter.

## Regenerate

```powershell
pwsh -File scripts/build-ides.ps1
pwsh -File scripts/verify-ides-parity.ps1
```

Matrix source: [`config/ide-matrix.yaml`](../config/ide-matrix.yaml) · Live page: [klarix.ai/harness/ides](https://klarix.ai/harness/ides)
