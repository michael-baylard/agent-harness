# Coding Sloth playbook → harness

> _Last updated: 2026-09-09_  
> Source: [1000+ Hours With Claude Code](https://www.youtube.com/watch?v=YAsxyoTWFDA)

Maps video advice → this harness.

## Tier summary

| Video tier | Topic | Harness equivalent |
|:----------:|-------|-------------------|
| S | Skills over subagents for workflows | `cursor-skills/` (~7 curated) |
| S | Verification before ship | `ship-check` · `adversarial-verifier` |
| S | Subagents when needed | `cursor-agents/` |
| A | MCPs for external systems only | `mcp-routing.mdc` · ≤6 profile |
| A | Plan before big edits | `/plan-before-code` |
| B | Manual compact / handoff | `/session-handoff` |
| C | Auto-compact mid-task | **Avoid** — new chat |

## Skills philosophy

> Do not spam skills. Stick to one group that matches your style.

- **Curated ~15–25** repo skills max
- **Vendor pack** optional: Matt Pocock + Vercel via `config/skills-vendor.yaml`
- **Router:** `agent-workflow.mdc` + `/ask-harness`

## Context & tokens

| Tip | Implementation |
|-----|----------------|
| Performance drops ~100k–200k tokens | Rotate chats |
| Be stupidly specific | `/sharpen-query` |
| `@` files not "read everything" | Plan + scoped reads |
| Auto-compact = quality drop | `/session-handoff` |

## Plan mode

1. Read ≤3 hub docs
2. Write plan to `.scratch/plans/`
3. User approves → **fresh** agent chat

Smart model plans; cheaper model implements.

## Parallel workers

Parent = coordinator; workers = isolated context + summary back.

Use `/parallel-work` — one brief per fresh chat. Parent synthesizes tables (`caveman-signal.mdc`).
