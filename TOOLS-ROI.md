# Tools ROI catalog

> _Last updated: 2026-09-09_ · **Start here to understand what each asset does and when to use it.**

| Tier | Meaning |
|------|---------|
| **S** | Every session — highest leverage |
| **A** | Strong ROI when trigger matches |
| **B** | Situational / stack-specific |

---

## Rules (`.cursor/rules/`)

| Asset | Tier | What it does | When to invoke | Depends on |
|-------|:----:|--------------|----------------|------------|
| `agent-workflow.mdc` | S | Phase protocol + skill router | Always loaded | `HARNESS.md` |
| `caveman-signal.mdc` | S | Response format + delegation | Always loaded | subagents |
| `mcp-routing.mdc` | S | ≤6 MCP servers, profiles | External API/DB tasks | Cursor MCP settings |
| `subagent-arsenal.mdc` | A | Spawn vs main-thread matrix | Noisy search/review | cursor-agents/ |
| `fast-ops.mdc` | A | rg/fd/ast-grep policy | Code search globs | Rust CLIs installed |

**Install:** `pwsh -File install.ps1`

---

## Skills (`.cursor/skills/`)

| Skill | Slash | Tier | What it does | Token/context ROI | When |
|-------|-------|:----:|--------------|-------------------|------|
| `ask-harness` | `/ask-harness` | S | Routes to right workflow | Avoids wrong 50k-token detours | Unsure which skill |
| `sharpen-query` | `/sharpen-query` | S | Vague → verifiable prompt | Cuts rework loops | Fuzzy multi-file ask |
| `plan-before-code` | `/plan-before-code` | S | Written plan before edits | Prevents 3+ file thrash | Schema/API coupling |
| `session-handoff` | `/session-handoff` | S | Keep-list for fresh chat | Saves quality post-compact | Context full |
| `ship-check` | — | S | Pre-ship verification gates | Collapses model alpha | "Is it done?" |
| `parallel-work` | `/parallel-work` | A | Independent parallel briefs | Low context per chat vs one 200k session | 2+ unrelated tickets |
| `fast-ops` | — | A | rg/fd/ast-grep locate | 10× faster than shell recurse | Wide grep |
| `setup-harness` | `/setup-harness` | S | One-time repo onboarding | Avoids re-config every chat | New project |
| `research-rag` | — | B | Semantic search over embedded docs | Beats grep on 50+ MD files | Neon+Doppler wired |

---

## Subagents (`cursor-agents/`)

| Agent | Tier | What it does | When | Model tier |
|-------|:----:|--------------|------|------------|
| `caveman-explore` | S | Compressed locate output | 15+ path hits | fast |
| `caveman-review` | A | Severity-tagged diff review | PR audit | fast |
| `adversarial-verifier` | S | Skeptical ship gate | Pre-merge | fast/inherit |
| `verifier` | A | Acceptance criteria check | Post-implement | fast |
| `highspeed` | A | Small scoped execute | Quick fixes | fast |
| `md-plain-language` | A | Human-readable prose | Docs/UI copy | fast |
| `db-architect` | A | Schema/migration design | DB changes | thinking |

---

## Docs — harness ops (`docs/agents/`)

| Doc | Tier | What it covers |
|-----|:----:|----------------|
| `README.md` | S | Harness hub index |
| `coding-sloth-playbook.md` | S | Skills > subagents; verification philosophy |
| `industry-intel.md` | A | 2026 builder consensus (Theo, Primeagen, Matt Pocock) |
| `systems-performance.md` | A | Native CLIs, alpha distribution, when to use Rust |
| `skills-routing.md` | A | Native vs vendor invoke table |
| `cross-machine.md` | B | Mac + Windows sync after pull |
| `harness-tier-tracker.md` | B | S/A/B/C grade tracker template |
| `issue-tracker.md` | A | GitHub/local issue template |
| `domain.md` | A | ADR + CONTEXT layout |
| `triage-labels.md` | A | Label map for `/triage` |
| `skill-smells.md` | S | SKILL.md quality gates |
| `token-optimization.md` | A | Context cost reduction |

---

## Docs — research (`docs/research/`)

| Doc | Tier | What it covers |
|-----|:----:|----------------|
| `programming-ideologies.md` | S | Unix philosophy, context>model, skills as IP |
| `concurrency-and-systems.md` | A | Semaphores, futures, tokio, when Rust/C |
| `references.md` | S | Public packages/tools by ROI tier |
| `harness-landscape.md` | S | Matt Pocock, Vercel, T3, 99 comparison |

---

## RAG stack (optional — Neon + Doppler)

| Asset | Tier | What it does | Secrets (Doppler) |
|-------|:----:|--------------|-------------------|
| `docs/rag/README.md` | B | When/how to enable RAG | — |
| `docs/rag/neon-doppler-setup.md` | B | Wire Neon + Voyage | `DATABASE_URL`, `VOYAGE_API_KEY` |
| `migrations/001_harness_embeddings.sql` | B | pgvector schema | — |
| `config/rag.template.yaml` | B | Corpus config | — |
| `scripts/embed-markdown.py` | B | Idempotent MD ingest | same |
| `research-rag` skill | B | Agent query pattern | Neon MCP |
| Neon MCP | A | SQL + admin from Cursor | MCP config |

Not wired by default — run setup once per account.

---

## External tools (not in repo — install on machine)

| Tool | Tier | Lang | ROI | Replaces |
|------|:----:|------|-----|----------|
| [ripgrep](https://github.com/BurntSushi/ripgrep) | S | Rust | Fast repo search | grep -r, findstr |
| [fd](https://github.com/sharkdp/fd) | S | Rust | Fast file find | find, Get-ChildItem -Recurse |
| [ast-grep](https://ast-grep.github.io/) | A | Rust | AST-aware refactor search | fragile regex |
| [uv](https://github.com/astral-sh/uv) | A | Rust | Python env manager | pip + venv drift |
| [pnpm](https://pnpm.io/) | A | JS | Node monorepo deps | npm flat installs |
| [Tokio](https://tokio.rs/) | A | Rust | Async runtime | ad-hoc threads |
| [skills.sh](https://skills.sh) | S | — | Vendor engineering skills | reinventing workflows |

Full list: [`docs/research/references.md`](docs/research/references.md)

---

## Vendor skills (optional — `config/skills-vendor.yaml`)

| Pack | Tier | Skills | When |
|------|:----:|--------|------|
| Matt Pocock | S | to-spec, to-tickets, implement, tdd, code-review, diagnosing-bugs, … | Engineering SDLC |
| Vercel | A | deploy-to-vercel, vercel-optimize, vercel-react-best-practices | Next.js on Vercel |

Install via [skills.sh](https://skills.sh) — not bundled in this repo.

---

## Scripts in this repo

| Script | Tier | What it does | Required? |
|--------|:----:|--------------|:---------:|
| `install.ps1` | S | Sync rules + skills → `.cursor/` | Yes |
| `scripts/embed-markdown.py` | B | Embed markdown → Neon pgvector | Only if RAG enabled |

**Intentionally excluded:** product pipelines, blast-radius, domain swarm orchestrators.

---

## Adoption path (new project)

```
1. Clone agent-harness (or submodule)
2. pwsh -File install.ps1
3. Copy AGENTS.template.md → AGENTS.md (fill project sections)
4. Optional: vendor skills from skills-vendor.yaml
5. Point every new AI chat at HARNESS.md
```

**Estimated setup time:** 10 minutes. **ROI:** pays back on first multi-file task.
