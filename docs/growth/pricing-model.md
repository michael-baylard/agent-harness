# Harness pricing model — Solo vs Team

> _Last updated: 2026-09-09_

## Ladder (live)

| Tier | Price | Who | Enforcement |
|------|-------|-----|-------------|
| **Free** | $0 MIT | Everyone | Public repo |
| **Pro Solo** | **$49 once** | 1 person · 1 GitHub seat | One invite; [PRO-LICENSE](../../agent-harness-pro/PRO-LICENSE.md) |
| **Team 5** | **$199/mo** | Up to 5 seats | Org collaborators; cancel = revoke |
| **Team 15** | **$497/mo** | Up to 15 seats | Same |
| **Enterprise** | Custom | Policy layer + SSO path | Sales |

## Org duplication

**You cannot DRM markdown.** Team exists to **capture org budget**, not to stop piracy.

| Behavior | Solo | Team |
|----------|------|------|
| One dev, personal repos | Yes | Overkill |
| Internal mirror for 50 engineers | **No** (license) | Yes (within seat cap) |
| Quarterly stack updates | Private repo snapshot | Active while subscribed |

## What not to sell

- **$12/mo for static public files** — strip-and-leave, bad conversion
- **Paid ads to $49 SKU** — CAC too high; use CI outbound instead

## Stripe spec

[`harness-team-stripe-spec.md`](harness-team-stripe-spec.md)

## CIaaS funds GTM

Harness = distribution. **Paid spend → CIaaS ($2,997+).**
