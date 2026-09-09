# Agent harness — start here

> _Last updated: 2026-09-09_ · **Any AI session should read this first.**

This repo is a **portable control plane** for Cursor (and similar agents). It encodes *how* to work, not *what* product to build.

## Phase protocol (mandatory)

| Phase | When | Action |
|-------|------|--------|
| **Sharpen** | Vague or multi-interpretation prompt | `/sharpen-query` |
| **Plan** | 3+ files, schema/API coupling, unfamiliar area | `/plan-before-code` — no code until approved |
| **Spec** | Multi-session feature | Vendor `/to-spec` → `/to-tickets` |
| **Execute** | One scoped ticket | Fresh chat → `/implement` |
| **Parallel** | 2+ independent tasks | `/parallel-work` → one chat per brief |
| **Verify** | Before done / push / PR | `ship-check` skill |
| **Handoff** | Context full or auto-compact | `/session-handoff` → **new chat** |

**Never continue after auto-compact.** Quality drops; start fresh with handoff doc.

## ROI catalog

Full table: [`TOOLS-ROI.md`](TOOLS-ROI.md)

## Session memory (for agents)

| Doc | Use |
|-----|-----|
| Klarix [`harness-session-log.md`](https://github.com/michael-baylard/klarix/blob/main/docs/agents/harness-session-log.md) | What shipped, when, which vertical |
| [`harness-vertical-backlog.md`](https://github.com/michael-baylard/klarix/blob/main/docs/agents/harness-vertical-backlog.md) | Open P0–P3 by lane |
| [`exploratory-thinking.md`](https://github.com/michael-baylard/klarix/blob/main/docs/agents/exploratory-thinking.md) | Cold start — ingest before ideate |

Append log: `python scripts/append-harness-session-log.py` (klarix repo).

## Model routing

Task → best model for cost: [`docs/models/MODEL-ROUTER.md`](docs/models/MODEL-ROUTER.md)  
Rule: `cursor-rules/model-routing.mdc`  
Local + CLI: [`docs/models/local-and-cli-harness.md`](docs/models/local-and-cli-harness.md)

| Tier | Meaning |
|------|---------|
| **S** | Use every session — high leverage, low token cost |
| **A** | Use when trigger matches — strong ROI |
| **B** | Situational — domain or stack specific |

## Skill router (quick)

| Situation | Invoke |
|-----------|--------|
| Unsure which workflow | `/ask-harness` |
| Fuzzy ask | `/sharpen-query` |
| Big multi-file change | `/plan-before-code` |
| End session cleanly | `/session-handoff` |
| Parallel independent tasks | `/parallel-work` |
| "Is this done?" | `ship-check` |
| Wide codebase search | `caveman-explore` subagent |
| Diff review | `caveman-review` subagent |

## Platform skills (Pro stack packs)

Optional domain packs in [`platform-skills/`](platform-skills/) — **23 skills** including Terraform, Docker, Next.js, Ollama, Agent CLI, LangGraph, dbt, and MCP-native Neon/Vercel/Stripe.

- Catalog: [`platform-skills/index.yaml`](platform-skills/index.yaml)
- Persona fit (enterprise vs startup vs indie): [`docs/platforms/persona-fit.md`](docs/platforms/persona-fit.md)
- Web hub: https://klarix.ai/harness/platforms
- CLI + local models: [`docs/models/local-and-cli-harness.md`](docs/models/local-and-cli-harness.md) · https://klarix.ai/harness/local-models

Merged into `.agents/skills/` (and `.cursor/skills/` on Cursor install) via `install.ps1` / `build-ides.ps1`.

## MCP policy

- **≤6 MCP servers** per session — enable only what the task needs.
- MCP for **external systems** (GitHub, DB, browser, APIs).
- **Not** for coding conventions — that's rules + skills.
- See `cursor-rules/mcp-routing.mdc`.

## Systems & performance stance

| Work | Tooling |
|------|---------|
| Repo search/locate | `rg`, `fd`, `ast-grep` (Rust CLIs) |
| Agent context | Compress verbose output; dedupe reads |
| Hot-path compute | Profile first; Rust/C only when measured |
| Concurrency | See [`docs/research/concurrency-and-systems.md`](docs/research/concurrency-and-systems.md) |
| Ideologies | See [`docs/research/programming-ideologies.md`](docs/research/programming-ideologies.md) |

## Consuming repo setup

1. Run `install.ps1` (or copy `cursor-rules/` + `cursor-skills/`).
2. Copy [`AGENTS.template.md`](AGENTS.template.md) → `AGENTS.md`; fill project-specific sections.
3. Optional: install vendor skills from [`config/skills-vendor.yaml`](config/skills-vendor.yaml).
4. Restart Cursor.

## Optional: research RAG (Neon + Doppler)

Not configured by default. When research docs exceed grep:

1. [`docs/rag/neon-doppler-setup.md`](docs/rag/neon-doppler-setup.md) — secrets + migration
2. `doppler run -- python scripts/embed-markdown.py --corpus research`
3. Skill `research-rag` + Neon MCP for semantic query

Requires: `DATABASE_URL`, `VOYAGE_API_KEY` in Doppler (or `.env.local`). **Pro license:** [`PRO.md`](PRO.md) · [klarix.ai/harness](https://klarix.ai/harness)

## Deep docs

| Doc | Topic |
|-----|-------|
| [`docs/agents/README.md`](docs/agents/README.md) | Harness hub |
| [`docs/research/harness-landscape.md`](docs/research/harness-landscape.md) | What other harness repos ship |
| [`docs/agents/coding-sloth-playbook.md`](docs/agents/coding-sloth-playbook.md) | Verification + skills philosophy |
| [`docs/agents/skill-smells.md`](docs/agents/skill-smells.md) | SKILL.md quality checklist |
| [`docs/agents/industry-intel.md`](docs/agents/industry-intel.md) | 2026 consensus (Theo, Primeagen, Matt Pocock) |
| [`docs/agents/systems-performance.md`](docs/agents/systems-performance.md) | Native CLIs, GPU policy, alpha distribution |
| [`docs/research/references.md`](docs/research/references.md) | Public packages & tools by ROI |
| [`docs/rag/README.md`](docs/rag/README.md) | Optional embeddings layer |
