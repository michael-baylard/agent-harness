# Launch checklist — sell under Klarix

> _Last updated: 2026-09-09_ · Execute in order.

## Phase 1 — Stripe (same account as klarix.ai MCP)

1. **Stripe Dashboard** → Products → Add product  
   - Name: `Agent Harness Pro`  
   - Price: **$49 one-time** (Price ID: save to Doppler `STRIPE_HARNESS_PRO_PRICE_ID`)  
   - Optional: **$12/mo** recurring for updates  

2. **Payment Link** → copy URL → store in Doppler `STRIPE_HARNESS_PRO_PAYMENT_LINK`

3. **Customer email** → Stripe Settings → use **contact@klarix.ai** as business contact

4. **Receipt branding** → Klarix logo (same as MCP checkout)

## Phase 2 — GitHub Pro repo

```powershell
gh repo create michael-baylard/agent-harness-pro --private --description "Agent Harness Pro — licensed"
# Copy pro paths: docs/rag/, scripts/embed-markdown.py, docs/models/, config/rag.yaml
# Add PRO-LICENSE.md
```

5. After payment (manual v1): invite buyer GitHub username as collaborator

## Phase 3 — klarix.ai landing (optional same sprint)

6. Add route `web/app/harness/page.tsx` — mirror free README + Stripe buy button  
7. Add to `web/app/sitemap.ts`  
8. Copy: "Operating system for Cursor agents — not another rules pack"

## Phase 4 — Cursor Marketplace (free funnel)

9. Submit **core** plugin from `.cursor-plugin/marketplace.json`  
10. [cursor.com/marketplace/publish](https://cursor.com/marketplace/publish)  
11. Description links to klarix.ai/harness for Pro

## Phase 5 — Fulfillment email template

```
From: contact@klarix.ai
Subject: Agent Harness Pro — access

Thanks for your purchase.

1. Accept GitHub invite: agent-harness-pro
2. pwsh -File install.ps1
3. doppler run -- python scripts/embed-markdown.py (Pro RAG)
4. Read HARNESS.md

Support: reply to this email.
```

## Phase 6 — Verify

- [ ] Test Payment Link with Stripe test mode
- [ ] Test install.ps1 on clean repo
- [ ] Pro repo excludes secrets (rag.yaml template only)

## MCP note

Stripe MCP in Cursor can verify product/price IDs after creation — enable in **ops** profile only.
