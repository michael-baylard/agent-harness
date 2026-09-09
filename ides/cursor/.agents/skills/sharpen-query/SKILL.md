---
name: sharpen-query
description: Rewrites a vague user request into a specific, verifiable agent prompt with paths, success criteria, and scope bounds. Use when the ask is fuzzy or missing file targets. Do not use when paths and acceptance criteria are already clear.
disable-model-invocation: true
last_updated: 2026-09-09
---

# Sharpen query

Turn the user's message into a **single optimized prompt** they can paste back (or approve for execution). Based on [Coding Sloth — be stupidly specific](https://www.youtube.com/watch?v=YAsxyoTWFDA&t=877s).

## Process

1. **Infer intent** — one sentence goal.
2. **Locate surface** — grep `AGENTS.md` or README; max 3 anchor files.
3. **Bound scope** — explicit in/out; name files or globs.
4. **Success criteria** — verifiable commands (`pnpm build`, `cargo test`, lint).
5. **Model/route hint** — only if non-obvious.

Do **not** implement until user confirms (unless mid-task rewrite-only).

## Output template

```markdown
## Sharpened prompt

**Goal:** …

**Scope**
- In: `path/` — …
- Out: …

**Steps**
1. …

**Verify**
- [ ] `…`

**If multi-file:** run `/plan-before-code` first.
```

## Anti-patterns

| Vague input | Sharpen to |
|-------------|------------|
| "Fix the app" | Route + error + `src/...` path |
| "Optimize cursor" | Harness layer: skills, rules, MCP profile |
| "Make copy better" | File path + audience + lint gate |
