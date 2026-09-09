---
name: parallel-work
description: Splits independent tasks into separate agent briefs for parallel fresh chats. Use when 2+ tickets don't share files or ordering. Do not use when tasks are tightly coupled — plan first.
disable-model-invocation: true
last_updated: 2026-09-09
---

# Parallel work

Run **independent tasks in parallel fresh chats** — not one bloated 200k-context session.

## When to use

- 2+ tickets with no `blocked_by` dependency
- Audit + implement split (research wave → implement wave)
- Multi-surface work (frontend + backend) with clear boundaries

## Process

1. **Sharpen each task** — `/sharpen-query` per ticket if vague.
2. **Write briefs** — one markdown block per task:

```markdown
# Brief: <title>
> Wave: N · Blocked by: none | ticket-id

## Goal
…

## Scope
- In: …
- Out: …

## Read first (≤3)
…

## Verify
- [ ] …
```

3. Save to `.scratch/briefs/YYYY-MM-DD-<slug>/` (gitignored in consuming repos).
4. **One fresh Cursor chat per brief** — parent synthesizes results in a coordinator chat.
5. **Verify each** before merge — scoped ship-check per brief.

## Anti-patterns

| Bad | Good |
|-----|------|
| One chat for 5 unrelated files | 5 briefs, 5 chats |
| Parallel edits same file | Serialize or split by layer |
| Skip verify per brief | Ship-check each before integrating |

## No orchestrator script required

This skill is **process-only**. YAML/swarm tooling is optional in consuming repos — briefs in markdown are enough.
