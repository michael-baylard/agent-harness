# Skill smells — authoring checklist

> _Last updated: 2026-09-09_

Source: Hong et al. 2026, [arXiv:2607.01456](https://arxiv.org/abs/2607.01456) — quality study over marketplace SKILL.md files.

**Do not install marketplace dumps.** Liu et al. 2026 show skill gains collapse at 34k-skill scale. Curate ~15–25 skills; let Cursor route on name + description.

## Static checks (automatable)

| Acronym | Smell | Rule |
|---------|-------|------|
| **LSN** | Long skill name | `name` > 64 chars |
| **LSD** | Long description | `description` > 1024 chars |
| **LSB** | Long body | body > 5000 words |
| **XID** | XML in description | `<tag>` in description breaks routing |
| **CSD** | Confusing description | Missing when-cue: `use when` / `do not use when` |
| **USN** | Uninformative name | {helper, utils, tools} or name ≠ directory |

## Description template (CSD fix)

```yaml
description: [What it does]. Use when [trigger]. Do not use when [near-miss].
```

## Human review (before merge)

| Smell | Look for |
|-------|----------|
| **TSW** Stepless workflow | One prose block — needs numbered steps |
| **TOB** Option buffet | Many tools, no default pick |
| **MDT** Missing decision tree | Branching task without if/then |

## Progressive disclosure ([agentskills.io](https://agentskills.io))

- SKILL.md = router + steps
- Deep refs → `references/` subfolder, loaded on demand
- Never inline 3000 lines into AGENTS.md

## Policy

- Curated vendor manifest only: `config/skills-vendor.yaml`
- Never `npx skills add --all`
- Router skill: `/ask-harness`
