---
name: stripe
description: Stripe MCP — products, prices, subscriptions, and webhook debugging. Use for billing integrations when Stripe MCP is in the active profile.
last_updated: 2026-09-09
---

# Stripe (MCP-native)

## Official docs

| Topic | URL |
|-------|-----|
| Documentation | https://docs.stripe.com |
| Building with LLMs | https://docs.stripe.com/building-with-llms |
| Webhooks | https://docs.stripe.com/webhooks |

## Agent rules

1. **MCP for reads** — list products, prices, subscriptions via MCP before writing scripts.
2. **Webhook idempotency** — handlers must tolerate Stripe retries; verify signature server-side.
3. **Metadata contracts** — document product metadata keys in ops runbooks when adding SKUs.
4. **Live vs test** — confirm mode before creating prices; never mix test keys on production URLs.
5. **Secrets** — `STRIPE_SECRET_KEY` and webhook secrets via Doppler only.

## Do not

- Log full webhook payloads with PII in production
- Create duplicate webhook endpoints per product — one URL, route by metadata
