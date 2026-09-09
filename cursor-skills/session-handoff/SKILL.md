---
name: session-handoff
description: Summarizes the session into a keep-list for a fresh chat — decisions, paths, next steps. Use when context is heavy or auto-compact happened. Do not substitute for vendor /handoff when forking to another directory.
disable-model-invocation: true
last_updated: 2026-09-09
---

# Session handoff

Auto-compact drops quality ([Coding Sloth @ 15:01](https://www.youtube.com/watch?v=YAsxyoTWFDA&t=901s)). Run this handoff, then **new chat**.

## Process

1. **Decisions made** (not open options).
2. **Files touched** — one line each.
3. **Exact errors / output** still relevant (not whole logs).
4. **Next 1–3 actions** with verify commands.
5. **Do not carry forward** — failed attempts, tool noise.

Optional: `.scratch/handoffs/YYYY-MM-DD-HHMM-<slug>.md`

## Output template

```markdown
# Handoff — <slug>

## Decisions
- …

## State
| Item | Status |

## Files
- `path` — …

## Verify before continuing
- [ ] …

## Next chat prompt
(paste block)
```

## Rules

- Auto-compact mid-task → **stop and new chat**.
- Never handoff secrets — redact env values.
