# AGENTS.md — {PROJECT_NAME}

> _Copy from agent-harness `AGENTS.template.md` · Fill sections below · Delete this line._

## What this repo is

| Field | Value |
|-------|-------|
| **Purpose** | … |
| **Stack** | e.g. Next.js + Postgres · Rust CLI · Python scripts |
| **Deploy** | e.g. Vercel · Railway · local only |

## Harness (portable)

This project uses [agent-harness](https://github.com/michael-baylard/agent-harness):

- **AI entry:** `HARNESS.md` (or symlink from harness)
- **ROI catalog:** `TOOLS-ROI.md`
- **Phase protocol:** Sharpen → Plan → Execute → Verify → Handoff

Re-sync after harness updates:

```powershell
pwsh -File path/to/agent-harness/install.ps1
```

## Before you edit

| Step | Action |
|------|--------|
| 1 | Read this file |
| 2 | Grep prior decisions in `docs/` or issues — don't redo work |
| 3 | Multi-file change → `/plan-before-code` |
| 4 | Unsure workflow → `/ask-harness` |

## Task → open first

| Intent | Path |
|--------|------|
| Architecture | `README.md` · `docs/architecture.md` |
| API / schema | `docs/api.md` · migrations |
| Agent harness | `HARNESS.md` · `TOOLS-ROI.md` |

## Commands

```powershell
# Fill per stack — examples:
# Node:  cd app; pnpm dev; pnpm build
# Rust:  cargo test; cargo clippy
# Python: pytest; python -m py_compile src/module.py
```

## Conventions

- **Naming:** kebab-case files · PascalCase React components · snake_case Python
- **Shell:** PowerShell 5.1 chains with `;` not `&&`
- **Search:** `rg` / `fd` / `ast-grep` — skill `fast-ops`
- **MCP:** ≤6 servers per session — see `.cursor/rules/mcp-routing.mdc`

## Boundaries

### Always

- Run verify commands before claiming done (`ship-check`)
- Scoped verify — only agent-touched failures block ship
- `/session-handoff` + new chat if context compacts

### Ask first

- Schema migrations · production deploys · deleting data

### Never

- Commit secrets (`.env`, tokens, keys)
- Push through auto-compact mid-task
- Install marketplace skill dumps

## Deep docs

- Harness: `docs/agents/` (from agent-harness)
- Research: `docs/research/` (concurrency, ideologies, references)
