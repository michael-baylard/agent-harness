---
name: vercel
description: Vercel MCP — deploy, env vars, logs, and Next.js hosting ops. Use when deploying or debugging klarix.ai-style Vercel projects with Vercel MCP enabled.
last_updated: 2026-09-09
---

# Vercel (MCP-native)

## Official docs

| Topic | URL |
|-------|-----|
| Documentation | https://vercel.com/docs |
| Agent resources | https://vercel.com/docs/agent-resources |
| MCP | Enable Vercel plugin MCP in Cursor |

## Agent rules

1. **Deploy skill path** — use project `deploy-to-vercel` skill + promote checklist before production promote.
2. **Env vars** — server secrets never `NEXT_PUBLIC_*`; redeploy after env changes affecting build.
3. **Preview vs production** — confirm target environment before `deploy` or env writes.
4. **Pair with nextjs** — App Router caching and route changes affect deploy behavior.
5. **Profile** — enable in `web` or `ops` MCP profile only.

## Do not

- Force-push or skip ship-check because Vercel MCP is fast
- Invent Vercel API flags — Context7 or Vercel MCP docs first
