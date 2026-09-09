# agent-harness

> _Last updated: 2026-09-09_ · **Free core (MIT)** · [**Pro $49**](https://klarix.ai/harness)

Portable **multi-IDE agent OS** for Codex, Antigravity, Amazon Q, OpenClaw, Cursor, and ten more editors. Rules, skills, subagents, model router, and research docs. Drop into any new project.

| | Free | [Pro](PRO.md) |
|---|:---:|:---:|
| Phase protocol + skills | yes | yes |
| TOOLS-ROI + research docs | yes | yes |
| Model router table | yes | + live cost catalog refresh |
| Neon RAG + embed script | no | yes |
| Stack packs + support | no | yes |

## Quick start

```powershell
# From your new repo root. Clone or submodule this repo, then:
pwsh -File path/to/agent-harness/install.ps1              # Cursor (default)
pwsh -File path/to/agent-harness/install.ps1 -Ide codex
pwsh -File path/to/agent-harness/install.ps1 -Ide claude-code
pwsh -File path/to/agent-harness/install.ps1 -Ide antigravity
pwsh -File path/to/agent-harness/install.ps1 -Ide amazon-q
pwsh -File path/to/agent-harness/install.ps1 -Ide openclaw
pwsh -File path/to/agent-harness/install.ps1 -Ide windsurf
pwsh -File path/to/agent-harness/install.ps1 -Ide cline   # full kit. See ides/README.md

# Or copy manually:
#   cursor-rules/*  →  .cursor/rules/
#   cursor-skills/* →  .cursor/skills/
#   cursor-agents/* →  ~/.cursor/agents/  (or project cursor-agents/)
```

## 14 supported IDEs

One repo, one Pro price. Run `install.ps1 -Ide <slug>` for your editor. Live matrix: [klarix.ai/harness/ides](https://klarix.ai/harness/ides).

| IDE | `install.ps1 -Ide` slug |
|-----|-------------------------|
| Cursor | `cursor` |
| OpenAI Codex CLI | `codex` |
| Claude Code | `claude-code` |
| Google Antigravity | `antigravity` |
| Gemini CLI | `gemini-cli` |
| Windsurf | `windsurf` |
| GitHub Copilot | `vscode-copilot` |
| Amazon Q Developer | `amazon-q` |
| OpenClaw | `openclaw` |
| Cline | `cline` |
| Roo Code | `roo` |
| Continue | `continue` |
| Zed | `zed` |
| JetBrains Junie | `jetbrains-junie` |

See [`ides/README.md`](ides/README.md) for adapter notes and parity checks.

Restart Cursor (or your IDE). Open **HARNESS.md**. Any AI should start there.

## What's inside

| Layer | Path | Purpose |
|-------|------|---------|
| **Entry** | [`HARNESS.md`](HARNESS.md) | AI onboarding: phase protocol, ROI catalog pointer |
| **ROI catalog** | [`TOOLS-ROI.md`](TOOLS-ROI.md) | Every asset ranked S/A/B with when-to-use |
| **Project template** | [`AGENTS.template.md`](AGENTS.template.md) | Copy → `AGENTS.md` in consuming repo |
| **Rules** | `cursor-rules/` | Always-on workflow + communication |
| **Skills** | `cursor-skills/` | Slash-invoked workflows (`/sharpen-query`, etc.) |
| **Subagents** | `cursor-agents/` | Delegate noisy search/review |
| **Docs** | `docs/agents/` · `docs/research/` | Harness ops + systems/concurrency ideologies |
| **Model router** | [`docs/models/MODEL-ROUTER.md`](docs/models/MODEL-ROUTER.md) | Task → best model for the cost |
| **Vendor manifest** | `config/skills-vendor.yaml` | Optional Matt Pocock + Vercel skills |
| **Pro / buy** | [`PRO.md`](PRO.md) · [klarix.ai/harness](https://klarix.ai/harness) | RAG, stacks, updates |

## Design principles

1. **Context > model**: rich repo-native files beat chasing frontier models.
2. **No product coupling**: no domain pipelines; optional generic scripts only.
3. **Curated, not dumped**: ~15 skills, not marketplace sprawl ([`docs/agents/skill-smells.md`](docs/agents/skill-smells.md)).
4. **Verify before ship**: deterministic gates collapse model alpha.
5. **Native when it matters**: Rust CLIs for locate; Rust/C for hot paths only ([`docs/research/concurrency-and-systems.md`](docs/research/concurrency-and-systems.md)).
6. **Optional RAG**: Neon + Doppler + Voyage for embedded research docs ([`docs/rag/README.md`](docs/rag/README.md)).

## New project checklist

1. `install.ps1` sync rules/skills
2. `/setup-harness` issue tracker, AGENTS.md, labels
3. Optional: vendor skills via `npx skills add mattpocock/skills`
4. Optional: RAG via [`docs/rag/neon-doppler-setup.md`](docs/rag/neon-doppler-setup.md)

## Optional vendor skills

```powershell
# After install.ps1. Curated third-party pack (Matt Pocock + Vercel)
npx skills experimental_install   # uses config/skills-vendor.yaml pattern
# Or follow https://skills.sh for manual install
```

## License

**Free core:** MIT ([`LICENSE`](LICENSE)). **Pro:** commercial. See [`PRO.md`](PRO.md).

Competitive rank: [`docs/research/competitive-rank.md`](docs/research/competitive-rank.md)
