# Harness pricing model — $49 once vs $12/mo

> _Last updated: 2026-09-09_

## Short answer

**Do not sell $12/mo for static files** anyone can copy from the public MIT repo. That invites strip-and-leave churn and does not increase sales versus $49 once.

**Do sell recurring only when the value is ongoing and gated:**

| Gated asset | Why recurring works |
|-------------|---------------------|
| Private `agent-harness-pro` repo access | Revoke on cancel |
| Quarterly stack-pack releases | New value each quarter |
| RAG embed pipeline + Neon schema | Hosted or licensed wiring |
| Cost catalog + model router refresh | Stale data without updates |
| Email support / team seats (future) | Service, not files |

## Piracy reality (Obscura + market scan)

| Channel | Model | Piracy |
|---------|-------|--------|
| Gumroad rules packs | $19–60 **one-time** | High — zip/md re-shared |
| skills.sh | Free directory; paid = unlisted URL | High — URLs leak |
| MIT GitHub harness | Free clone | Total — by design |

Competitors do not beat piracy on **text rules**. They win on **distribution, trust, and updates**.

## Recommended ladder

| Tier | Price | Deliverable |
|------|-------|-------------|
| **Free** | $0 MIT | Phase protocol, core skills, IDE adapters, platform **routing stubs** (doc links + guardrails) |
| **Pro once** | **$49** | Private repo invite, RAG wiring, `pro/stacks/*` depth, cost catalog — **keep as primary SKU** |
| **Pro Plus** (optional later) | **$12/mo** | Everything in Pro once **plus** quarterly releases, support, team policy layer — cancel = lose repo access |

$49 once converts better for dev tools at this price point (Gumroad cluster $20–60). $12/mo only after Pro once exists and private repo is the enforcement mechanism.

## What we shipped wrong (fix in wave 2)

Platform skills landed in the **public** repo for SEO. That is fine as **marketing stubs**; depth and quarterly refresh belong in **`agent-harness-pro/pro/stacks/`**.

Site copy should say: Free = routing stubs · Pro = RAG + deep stacks + updates.

## CIaaS still funds everything

Harness is distribution. **Paid ads and SDR time go to CIaaS ($2,997+)** — not Harness CAC.
