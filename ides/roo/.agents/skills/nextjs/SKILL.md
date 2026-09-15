---
name: nextjs
description: Next.js App Router — RSC, server actions, caching, and Vercel deployment patterns. Use when editing web/app/, layouts, route handlers, or next.config.
last_updated: 2026-09-09
---

# Next.js

## Official docs

| Topic | URL |
|-------|-----|
| App Router | https://nextjs.org/docs/app |
| Data fetching | https://nextjs.org/docs/app/building-your-application/data-fetching |
| Caching | https://nextjs.org/docs/app/building-your-application/caching |
| Route Handlers | https://nextjs.org/docs/app/building-your-application/routing/route-handlers |

## Agent rules

1. **App Router default** — prefer `app/` over `pages/` unless repo is Pages-only.
2. **Server vs client** — `'use client'` only when hooks, browser APIs, or event handlers require it.
3. **Caching** — read existing `revalidate`, `fetch` cache, and `unstable_cache` patterns before changing behavior.
4. **Metadata** — export `metadata` or `generateMetadata` on public routes; update `sitemap.ts` for new slugs.
5. **Do not invent API** — Context7 MCP for `@next/*` syntax; avoid hallucinated Next 15 config flags.

## Common tasks

```powershell
pnpm build
pnpm dev
```

## MCP / tools

- **Context7** — Next.js, React, Tailwind docs
- **Vercel MCP** — deploy, env, runtime logs (pair with `vercel` skill)

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| Client fetch for static marketing copy | RSC + server data |
| `useEffect` for data that can run on server | Server Component or Server Action |
| Breaking `generateStaticParams` contracts | Match existing SSG slug list |
