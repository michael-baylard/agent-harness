# Domain docs — template

> _Last updated: 2026-09-09_ · Where ADRs and feature context live.

## Layout

```
docs/
  domain/
    CONTEXT.md          # Living glossary — terms resolved here
    adr/
      0001-<slug>.md    # Architecture decisions
  agents/               # Harness config (this folder)
```

## Rules

- **`CONTEXT.md`** — created lazily when `/grill-with-docs` or `/domain-modeling` resolves a fuzzy term. Not upfront boilerplate.
- **ADRs** — one decision per file; status: proposed | accepted | superseded.
- **Do not** duplicate harness docs here — `docs/agents/` is process; `docs/domain/` is product.

## Consumer skills

| Skill | Reads |
|-------|-------|
| `/grill-with-docs` | Writes `.scratch/<feature>/CONTEXT.md` first |
| `/domain-modeling` | Updates `docs/domain/CONTEXT.md` + ADRs |
| `/wayfinder` | Reads issue-tracker + domain for map tickets |
