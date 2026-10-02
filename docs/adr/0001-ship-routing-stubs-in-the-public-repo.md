---
status: accepted
date: 2026-10-02
applies_to:
  - platform-skills/**
related:
  - agent-harness-pro ADR-0001
---

# Ship routing stubs in the public repo

MUST: Ship the public platform skills as routing stubs: scope, triggers, and guardrails.
MUST NOT: Commit full stack packs, RAG wiring, or the live cost catalog in this MIT repo.

Rejected: publishing the full packs here. Depth stays in `agent-harness-pro`.

Context: Pro users copy `pro/stacks/*` over these stubs after each quarterly pull.
