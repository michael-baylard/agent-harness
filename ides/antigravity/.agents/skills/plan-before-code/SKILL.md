---
name: plan-before-code
description: Produces a written implementation plan before multi-file edits — files, risks, verification order. Use when 3+ files, API/schema coupling, or unfamiliar subsystem. Do not use for single-line typos.
disable-model-invocation: true
last_updated: 2026-09-09
---

# Plan before code

Cursor Plan mode companion. **No code edits in this skill** — plan only.

## When required

- API ↔ client ↔ docs coupling
- DB migration or schema change
- New public route or endpoint
- Refactor spanning 3+ files
- User marked task "big"

## Steps

1. Read ≤3 hub docs if unfamiliar (`AGENTS.md`, README, architecture doc).
2. Map **blast radius** — what imports/calls the primary file? (`rg`, dependency graph, or mental model).
3. **Draft plan** → `.scratch/plans/YYYY-MM-DD-<slug>.md`
4. **Stop** — user approves or starts **fresh execute chat** with plan attached.

## Plan template

```markdown
# Plan: <title>
> Date: ISO · Primary file: `path`

## Goal
…

## Coupling / blast radius
…

## Files to change
| File | Change |
|------|--------|

## Verification (order)
1. …

## Risks / rollback
…

## Execute chat prompt
(paste-ready for new agent session)
```

## After approval

Execute in **new chat**. `/session-handoff` if context fills — do not compact mid-execute.
