# Agent Harness

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Docs](https://img.shields.io/badge/site-klarix.ai%2Fharness-1c2a4a)](https://klarix.ai/harness)

**Portable workflow OS for AI coding agents.** One phase protocol, curated skills, model router, and 14-IDE installer — drop into any repo in minutes.

Make every coding agent follow the same workflow: **sharpen the ask → plan → ship with gates.**

Not a `.cursorrules` zip. Not domain pipeline code. The **process layer** your agents run inside.

---

## The problem

You bought good tools. Each agent still behaves like a different hire.

| Symptom | Root cause |
|---------|------------|
| Code before the ask is clear | No sharpen phase |
| Fifteen-file refactor with no approved plan | No plan gate |
| "Done" that fails build | No verify gate |
| Cursor vs Codex vs Claude Code drift | Config lives per IDE, not in git |
| Context window eaten by MCP sprawl | No server budget |
| 200 marketplace skills nobody names | Volume mistaken for capability |

**Context beats model.** A mid-tier model with the right harness outperforms a frontier model guessing.

---

## The solution

Agent Harness is a repo-native control plane:

1. **Sharpen** vague prompts into verifiable asks (`/sharpen-query`)
2. **Plan** before multi-file work (`/plan-before-code`)
3. **Execute** in fresh chats with scoped context
4. **Verify** before merge (`ship-check`, adversarial review hooks)
5. **Hand off** when context fills — never continue after auto-compact

Install once from this repo. Every supported IDE gets the same kit: rules, skills, MCP profiles, delegate briefs, platform skill stubs.

**Entry point for every AI session:** [`HARNESS.md`](HARNESS.md)

---

## ROI

| Path | Cost | What you get |
|------|-----:|--------------|
| DIY harness (Theo benchmark) | 12–16 senior hr ≈ **$1,200–2,400** @ $100/hr | Your conventions, unmaintained |
| Consultant agent-ops sprint | **$5,000–15,000** | Their conventions, unmaintained |
| **Free core (this repo)** | **$0** | Protocol, skills, subagents, router, installer |
| **[Pro Solo](https://klarix.ai/harness)** | **$49 once** | RAG, full stack packs, live cost catalog, quarterly refresh |
| **Team 5 / Team 15** | **$199 / $497 mo** | Licensed org rollout, 5 or 15 GitHub seats |

Pro at $49 vs a $1,200 DIY floor ≈ **25–50×** on time saved. Team 5 costs **less than one hour** of a senior engineer per month.

**Cursor Pro ($20/mo)** buys the IDE. **Agent Harness** buys the workflow. Complements, not substitutes.

Machine-readable summary: [klarix.ai/llms-harness.txt](https://klarix.ai/llms-harness.txt)

---

## Quick start

```powershell
git clone https://github.com/michael-baylard/agent-harness
cd your-project

# Install into your IDE (from agent-harness folder):
pwsh -File path/to/agent-harness/install.ps1 -Ide cursor
pwsh -File path/to/agent-harness/install.ps1 -Ide codex
pwsh -File path/to/agent-harness/install.ps1 -Ide claude-code
pwsh -File path/to/agent-harness/install.ps1 -Ide antigravity -Persona startup-tech
```

Copy [`AGENTS.template.md`](AGENTS.template.md) → `AGENTS.md` in your project. Restart your IDE. Point the agent at **`HARNESS.md`**.

Optional vendor pack (Matt Pocock + Vercel): see [`config/skills-vendor.yaml`](config/skills-vendor.yaml) · [skills.sh](https://skills.sh)

---

## Supported IDEs (14)

One repo, one Pro price. Live matrix: [klarix.ai/harness/ides](https://klarix.ai/harness/ides)

| IDE | `install.ps1 -Ide` |
|-----|-------------------|
| Cursor | `cursor` |
| OpenAI Codex CLI | `codex` |
| Claude Code | `claude-code` |
| Google Antigravity | `antigravity` |
| Gemini CLI | `gemini-cli` |
| Windsurf | `windsurf` |
| GitHub Copilot (VS Code) | `vscode-copilot` |
| Amazon Q Developer | `amazon-q` |
| OpenClaw | `openclaw` |
| Cline | `cline` |
| Roo Code | `roo` |
| Continue | `continue` |
| Zed | `zed` |
| JetBrains Junie | `jetbrains-junie` |

Adapter notes: [`ides/README.md`](ides/README.md)

---

## What's inside

| Layer | Path | Purpose |
|-------|------|---------|
| **AI entry** | [`HARNESS.md`](HARNESS.md) | Phase protocol, skill router, MCP policy |
| **ROI catalog** | [`TOOLS-ROI.md`](TOOLS-ROI.md) | Every asset ranked S/A/B — when to use |
| **Project template** | [`AGENTS.template.md`](AGENTS.template.md) | Copy → consuming repo `AGENTS.md` |
| **Rules** | `cursor-rules/` | Always-on workflow + communication |
| **Skills** | `cursor-skills/` | Slash workflows (`/sharpen-query`, `/plan-before-code`, …) |
| **Subagents** | `cursor-agents/` | Explore, review, verify — delegate noise |
| **Platform skills** | [`platform-skills/`](platform-skills/) | 23 stack stubs (full depth in Pro) |
| **Model router** | [`docs/models/MODEL-ROUTER.md`](docs/models/MODEL-ROUTER.md) | Task → best model for cost |
| **CLI + local LLMs** | [`docs/models/local-and-cli-harness.md`](docs/models/local-and-cli-harness.md) | Ollama, vLLM, Agent CLI ship gates |
| **Research** | `docs/agents/` · `docs/research/` | Industry intel, systems stance, landscape |

---

## Platform skills (23)

Terraform · AWS · Kubernetes · GitHub Actions · Docker · Next.js · Playwright · Databricks · Snowflake · dbt · BigQuery · Postgres · MLflow · Azure · Neon · Vercel · Stripe · Helm · FastAPI · LangGraph · Agent CLI · Ollama · vLLM

Public repo ships **routing stubs** (scope, triggers, guardrails). **Pro** adds full stack packs, RAG wiring, and quarterly depth.

Hub: [klarix.ai/harness/platforms](https://klarix.ai/harness/platforms) · Catalog: [`platform-skills/index.yaml`](platform-skills/index.yaml)

---

## Free vs Pro

| | Free (MIT) | [Pro](PRO.md) |
|---|:---:|:---:|
| Phase protocol + core skills | ✅ | ✅ |
| Subagents + TOOLS-ROI | ✅ | ✅ |
| Model router (summary) | ✅ | ✅ + live cost catalog |
| 14-IDE `install.ps1` | ✅ | ✅ |
| Platform skill stubs (23) | ✅ | ✅ |
| Full stack packs + RAG | — | ✅ |
| Quarterly refresh | — | ✅ |
| Email support | — | ✅ |
| **Price** | **$0** | **$49 once** · Team **$199 / $497 mo** |

**Buy Pro:** [klarix.ai/harness](https://klarix.ai/harness) → GitHub invite to `agent-harness-pro` within 24h.

---

## Design principles

1. **Context > model** — repo-native files beat chasing frontier models.
2. **Curated, not dumped** — ~15 core skills, not marketplace sprawl ([`skill-smells.md`](docs/agents/skill-smells.md)).
3. **Verify before ship** — deterministic gates collapse model variance.
4. **≤6 MCP servers** per session — conventions live in rules/skills, not MCP.
5. **Portable** — harness lives in git, not one vendor's settings pane.
6. **Plan before three files** — multi-file work gets an approved plan first.

Competitive rank vs other harness repos: [`docs/research/competitive-rank.md`](docs/research/competitive-rank.md)

---

## Links

| Resource | URL |
|----------|-----|
| Product + pricing | [klarix.ai/harness](https://klarix.ai/harness) |
| Platform skills | [klarix.ai/harness/platforms](https://klarix.ai/harness/platforms) |
| CLI + local models | [klarix.ai/harness/local-models](https://klarix.ai/harness/local-models) |
| llms-harness.txt | [klarix.ai/llms-harness.txt](https://klarix.ai/llms-harness.txt) |
| Session ship log (dogfood) | [klarix harness-session-log](https://github.com/michael-baylard/klarix/blob/main/docs/agents/harness-session-log.md) |

---

## License

**Free core:** MIT ([`LICENSE`](LICENSE)).

**Pro:** commercial — private repo `agent-harness-pro`. See [`PRO.md`](PRO.md) · [`PRO-LICENSE.md`](https://github.com/michael-baylard/agent-harness-pro/blob/main/PRO-LICENSE.md) (after invite).
