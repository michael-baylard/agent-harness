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

## Deep docs

| Doc | Topic |
|-----|-------|
| [`docs/agents/README.md`](docs/agents/README.md) | Harness hub |
| [`docs/agents/coding-sloth-playbook.md`](docs/agents/coding-sloth-playbook.md) | Verification + skills philosophy |
| [`docs/agents/industry-intel.md`](docs/agents/industry-intel.md) | 2026 consensus (Theo, Primeagen, Matt Pocock) |
| [`docs/agents/systems-performance.md`](docs/agents/systems-performance.md) | Native CLIs, GPU policy, alpha distribution |
| [`docs/research/references.md`](docs/research/references.md) | Public packages & tools by ROI |
