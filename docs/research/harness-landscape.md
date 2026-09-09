# Harness landscape — what others ship (2026)

> _Last updated: 2026-09-09_ · Survey of public harness repos — patterns we adopt vs avoid.

## Comparison matrix

| Repo | Focus | Best ideas we took | Skip |
|------|-------|-------------------|------|
| [mattpocock/skills](https://github.com/mattpocock/skills) | Engineering SDLC skills | `docs/agents/` scaffold (issue-tracker, domain, triage-labels); spec→tickets→implement; setup-once flow | Dual CLAUDE.md/AGENTS.md confusion — we use AGENTS.md canonical |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | Vercel deploy/perf skills | Skill folder layout (`SKILL.md`, `scripts/`, `references/`); progressive disclosure | Massive inline AGENTS.md in skills |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | skills CLI | `npx skills add` install path; 70+ agent targets | `--all` marketplace dump |
| [pingdotgg/t3code](https://github.com/pingdotgg/t3code) | Harness control plane GUI | Context > model; parallel sessions; checkpoint/restore metaphor | Product-specific — we stay Cursor-native |
| [ThePrimeagen/99](https://github.com/ThePrimeagen/99) | Editor-native agent | Semantic search; `#` rules; native CLIs over shell loops | Neovim-specific wiring |
| [agentskills.io](https://agentskills.io) | Open spec | Progressive disclosure; name+description routing | — |
| [knods-io/parallel-agents-skill](https://github.com/knods-io/parallel-agents-skill) | Worktree isolation | Human merge gate after parallel workers | Heavy git worktree ceremony |
| [openai/codex](https://github.com/openai/codex) | Codex app-server | JSON-RPC agent protocol reference | Runtime, not harness docs |

## Patterns ranked by ROI

| Pattern | Source | Our implementation |
|---------|--------|-------------------|
| Phase protocol | Coding Sloth + Matt Pocock | `agent-workflow.mdc` |
| Curated skills (~15–25) | Hong et al. 2026 + Matt Pocock | `cursor-skills/` + vendor yaml |
| Progressive disclosure | agentskills.io | Skills load body on-demand; HARNESS.md stays thin |
| Setup once per repo | setup-matt-pocock-skills | `/setup-harness` skill |
| Verification contract | Coding Sloth | `ship-check` + VERIFICATION-CONTRACT |
| Native locate CLIs | Primeagen 99 | `fast-ops` |
| Optional RAG | Neon + Voyage pattern | `docs/rag/` (optional) |
| Parallel briefs | T3 + swarm variants | `/parallel-work` (process-only) |

## AGENTS.md philosophy (synthesized)

**Theo / T3:** Spend hours on harness once → shortest prompts forever.

**Matt Pocock:** `docs/agents/` is the config layer skills read at runtime — not hard-coded paths in SKILL.md.

**Vercel agent-skills:** Keep AGENTS.md thin; put depth in skills with `references/` subfolders.

**This repo:** `HARNESS.md` = AI entry · `AGENTS.template.md` = per-project · `TOOLS-ROI.md` = catalog.

## Install paths (vendor)

```powershell
# Matt Pocock engineering pack
npx skills@latest add mattpocock/skills

# Vercel deploy/optimize (if Next.js)
npx skills@latest add vercel-labs/agent-skills
```

Then run `/setup-harness` once per consuming repo.

## Refresh protocol

Quarterly: re-skim sources above · update this file · grep new repos on [skills.sh](https://skills.sh) · adjust `config/skills-vendor.yaml`.
