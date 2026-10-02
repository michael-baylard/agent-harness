---
status: accepted
date: 2026-10-02
---

# Ship routing stubs in the public repo

**Decision.** The MIT repo ships the 23 platform skills as routing stubs — scope, triggers, guardrails — and the full stack packs stay in the licensed `agent-harness-pro` repo. Applies to: `platform-skills/`.

## Context

The free core is the process layer: phase protocol, core skills, subagents, model router, and the 14-IDE installer. A stub is enough for an agent to know when a platform skill applies and what the guardrails are, which is the routing job. The depth — worked patterns, RAG wiring, a live cost catalog — is what takes the longest to build and the most effort to keep current, and it funds the quarterly refresh.

## Consequences

The public catalog in `platform-skills/index.yaml` and the Pro catalog in `pro/stacks/index.yaml` must stay in sync, and Pro users overlay files that replace the stubs after every quarterly pull. A free user gets routing without worked examples. Rejected alternative: publishing the full packs in the MIT repo — rejected because Pro is a separate licensed product with no redistribution, delivered by GitHub invite after purchase.
