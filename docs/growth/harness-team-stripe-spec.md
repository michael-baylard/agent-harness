# Harness Team — Stripe spec

> _Last updated: 2026-09-09_

## Products (create in Stripe Dashboard)

| Product | Price | Mode | Env var |
|---------|------:|------|---------|
| Agent Harness Team 5 | **$199/mo** | subscription | `STRIPE_HARNESS_TEAM_5_PRICE_ID` |
| Agent Harness Team 15 | **$497/mo** | subscription | `STRIPE_HARNESS_TEAM_15_PRICE_ID` |

Solo Pro stays **$49 once** → `STRIPE_HARNESS_PRO_PRICE_ID` (existing).

## Checkout metadata

| Key | Example |
|-----|---------|
| `product` | `agent_harness_team` |
| `team_tier` | `team5` \| `team15` |
| `github_org` | `acme-corp` |
| `github_username` | admin invite handle |
| `seat_limit` | `5` \| `15` |

## Fulfillment (manual v1 → automate v2)

1. Webhook `checkout.session.completed` (subscription mode)
2. Invite GitHub org or up to N users on `agent-harness-pro`
3. Log row in `harness_pro_fulfillment` (extend schema with `plan`, `seat_limit`)
4. Cancel subscription → remove org collaborators (GitHub API)

## Vercel env (production)

```
STRIPE_HARNESS_TEAM_5_PRICE_ID=price_...
STRIPE_HARNESS_TEAM_15_PRICE_ID=price_...
```

Until set, `/harness#pricing` Team card falls back to **mailto** only.

## License docs

- Solo: `agent-harness-pro/PRO-LICENSE.md`
- Team: `agent-harness-pro/TEAM-LICENSE.md`
