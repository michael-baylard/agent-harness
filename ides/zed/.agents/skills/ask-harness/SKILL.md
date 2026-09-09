---
name: ask-harness
description: Routes the user to the right harness or vendor skill for the current situation. Use when unsure which slash skill, subagent, or workflow to invoke. Do not use when the task already names a skill or file path.
disable-model-invocation: true
last_updated: 2026-09-09
---

# Ask harness — skill router

Read `docs/agents/skills-routing.md` and `HARNESS.md`. Reply with **one recommended path**, not a menu.

## Main flows

| Starting point | Route |
|----------------|-------|
| "Is this done?" / before push | `ship-check` → `adversarial-verifier` if non-trivial |
| Bug, failing test | Vendor `/diagnosing-bugs` |
| "Where is X?" / wide search | `fast-ops` then `caveman-explore` if 15+ hits |
| Diff review | `caveman-review` · pre-merge → `/code-review` |
| Vague ask | `/sharpen-query` first |

## Build feature (multi-session)

1. `/sharpen-query` if fuzzy
2. `/plan-before-code` if 3+ files or API/schema coupling
3. Vendor `/grill-with-docs` → `.scratch/<feature>/CONTEXT.md`
4. Vendor `/to-spec` → issue tracker
5. Vendor `/to-tickets` → tracer issues
6. `/parallel-work` or `/implement` per ticket in **fresh chats**

## Phase boundary

Context full → `/session-handoff` → **new chat**. Never push through auto-compact.

## Output format

```markdown
**Route:** `/skill-name` (+ subagent if any)

**Why:** one sentence

**Read first:** ≤3 paths

**Do not use:** near-miss skill and why
```
