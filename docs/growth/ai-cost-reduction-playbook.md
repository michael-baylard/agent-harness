# AI cost reduction playbook — Harness + CI GTM

> _Last updated: 2026-09-09_ · Serper credits exhausted 2026-09-09 — supplement with manual Serper refresh when topped up.

## Target: $2–4k/mo total → lower effective CAC

| Spend line | Traditional | AI-reduced | How |
|------------|-------------|------------|-----|
| Outbound list build | Apollo seats + VA research | **Pipeline scripts** (stage0/stage3) + Serper volume lookups | Already in klarix; no Apollo MCP |
| Email copy | Freelance SDR $1.5k+ | **Instantly MCP** + `outreach-responder` subagent + voice-lint | Human approves sends only |
| Lead scoring | Manual ICP review | **`score_prospect_fit`** MCP + composite rank scripts | 7+/10 gate before human touch |
| CI landing pages | Agency $2k/page | **Programmatic** `/harness/platforms`, `/harness/ides`, industry routes | Shipped — compound SEO |
| Competitive intel for calls | Analyst hours | **Klarix Intelligence MCP** (battlecards, triggers) | Free tier for narrative; Pro for depth |
| Site research / pricing intel | Consultant | **Obscura stealth** on competitor pages + Serper SERP | Obscura: skills.sh, Gumroad; Serper when credited |
| Harness support | Email you | **`/ask-harness` skill** + FAQ schema on site | Deflect before inbox |
| RAG over docs | Build custom | **Pro embed script** (`agent-harness-pro/scripts/embed-markdown.py`) | Productized, not services |

## Obscura stealth wins (2026-09-09)

| Site | Finding | Action |
|------|---------|--------|
| [skills.sh](https://skills.sh) | Free directory; monetize via unlisted pack URLs | List harness skills; optional paid pack URL for Pro deep stacks |
| [cursor.directory](https://cursor.directory) | Bot wall — manual browser submit | Human submit from marketplace checklist |
| Gumroad rules packs | $19–60 one-time, zip piracy | Price Pro at **$49 once** in same band; don't undercut to $12/mo |

## Serper queries (run when credits refresh)

```
open source developer tool subscription vs one-time pricing
AI reduce customer acquisition cost outbound email automation SaaS
competitive intelligence service pricing outbound stack 2025
instantly.ai vs smartlead cost per meeting booked
```

Skill: `serper-search` · MCP: `user-serper/google_search`

## Automation stack (≤6 MCP profile: sales/outreach)

| MCP | Replaces |
|-----|----------|
| Instantly | Manual campaign checks |
| Gmail | Inbox triage |
| GitHub | Marketplace + fulfillment |
| Context7 | Doc lookup for harness skills |
| user-serper | Cheap SERP volume |
| Klarix Intelligence | Pre-call intel |

Disable Neon/Vercel on sales sessions.

## Do not AI-automate (yet)

- Stripe Pro $12/mo without private-repo enforcement
- Fully autonomous outbound send (compliance + voice drift)
- Neon embed of vendor doc corpora (licensing + staleness)
- Paid ads to $49 SKU (CAC > LTV)

## Monthly review metric

| Metric | Kill threshold |
|--------|----------------|
| Harness Pro CPA (newsletter test) | > $30/sale |
| CI outbound | <$2,997 closed in 90 days → reallocate to Search |
| Serper + Obscura research hours | Cap 2h/mo — feed into programmatic pages, not bespoke reports |
