# Recommended MCPs and plugins

> _Last updated: 2026-09-09_ · Pick **one profile per session** (≤6 servers). Enable in Cursor Settings → MCP.

## Core (most repos)

| MCP / plugin | When | Skip when |
|--------------|------|-----------|
| **Context7** | Library/API syntax (Next.js, Tailwind, Neon, Pydantic) | You already have the doc open |
| **GitHub** | Issues, PRs, repo ops | Local-only edits |
| **sqz** (token) | Large reads/grep/shell output | Tiny one-line fixes |

## Web / Next.js profile

| Enable | Disable |
|--------|---------|
| Context7, GitHub, **Vercel**, Stack Auth (if using) | Neon, Instantly, Tavily, Exa, Stripe |

## Backend / data profile

| Enable | Disable |
|--------|---------|
| Context7, **Neon**, GitHub | Browser, marketing, scrape-heavy MCPs |

## Research / competitive intel profile

| MCP | Role | Cost note |
|-----|------|-----------|
| **Serper** (skill or MCP) | Cheap Google SERP volume | Prefer for many lookups |
| **Exa** *or* **Tavily** (one, not both) | Semantic search + page extract | Exa for niche; Tavily for synthesized extract |
| **Obscura** | Browser automation when fetch MCPs fail | Heavier; login/captcha = stop and ask human |
| Context7 | Doc lookup after you pick a stack | — |

**Rule:** Serper for volume → Tavily/Exa for one page → Obscura only when the page needs a real browser.

## Ops / deploy profile

| Enable | Disable |
|--------|---------|
| Vercel, GitHub, Sentry (if wired) | Research scrapers, Apollo |

## Optional (product-specific)

| MCP | Use case |
|-----|----------|
| **Stripe** | Billing, products, checkout debugging |
| **Notion** | Content calendar, VA tasks |
| **Railway** | Non-Vercel workers (e.g. MCP host) |
| **Instantly / Gmail** | Outreach only — sales sessions |

## Do not enable by default

| MCP | Why |
|-----|-----|
| **Apollo MCP** | Unreliable saved data — use pipeline/scripts instead |
| Duplicate Context7 + Exa plugin + user copy | Token waste — dedupe |

## Wiring in a new repo

1. Copy `cursor-rules/mcp-routing.mdc` via `install.ps1`.
2. Add only the MCPs your **persona** needs (`config/personas/index.yaml`).
3. Store secrets in Doppler or gitignored `.env.local` — never commit tokens.
4. Pro: `docs/rag/` for Neon + Voyage semantic search over your docs.

## Cursor Marketplace plugins (curated)

| Plugin | Fits |
|--------|------|
| **Context7** | Any TS/Python repo |
| **Vercel** | Next.js on Vercel |
| **Neon** | Postgres-backed apps |
| **Stripe** | Paid products (Harness Pro, MCP tiers) |
| **Exa** | Research-heavy agents |

Install from Cursor Marketplace; align with the profile table above.
