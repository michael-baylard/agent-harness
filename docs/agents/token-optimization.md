# Token optimization

> _Last updated: 2026-09-09_

Agents burn context on reads, grep, and shell output. These patterns reduce cost without hiding substance.

## Read policy

| Situation | Do |
|-----------|-----|
| File >2 KB, may re-read | Dedupe reads; quote line ranges not whole files |
| Wide search | `rg` / `fd` first; Read only hits |
| Verbose command output | Summarize or compress (>5 lines) |
| Repeat exploration | `/session-handoff` → fresh chat |

## Tool preference

```
Locate:  rg / fd / ast-grep  (not shell recursion)
Search:  Grep with head_limit
Read:    offset + limit for large files
Delegate: caveman-explore when 15+ path hits
```

Optional MCP: **sqz** ([github.com/aspect/sqz](https://github.com/aspect/sqz)) — compresses tool output in Cursor.

## MCP budget

≤6 servers per session. Disable scrape/DB MCPs when not needed.

## Subagent economics

| Task | Route |
|------|-------|
| Wide locate | `caveman-explore` (fast) |
| Schema / adversarial | thinking model |
| Parent reply | Synthesize tables — never paste raw dumps |

## Anti-patterns

- Auto-compact mid-task → quality drop; handoff instead
- Loading all skills bodies at session start
- Pasting full build logs into chat
- 200k single-chat for 5 unrelated tickets → `/parallel-work`
