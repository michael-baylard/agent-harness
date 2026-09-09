# Triage labels — template

> _Last updated: 2026-09-09_ · Maps canonical roles → your tracker's label strings.

Vendor `/triage` applies these — **labels must exist in your tracker** (create manually or via API).

| Role | GitHub label (example) | Meaning |
|------|------------------------|---------|
| bug | `bug` | Broken behavior |
| feature | `enhancement` | New capability |
| chore | `chore` | Maintenance, deps |
| docs | `documentation` | Docs-only |
| ready-for-agent | `ready-for-agent` | Spec complete; safe for `/implement` |

## Customize

Replace label strings to match your repo. Keep the **role** column stable — skills map to roles, not literal strings in SKILL.md files.

## GitHub bootstrap

```powershell
gh label create "ready-for-agent" --description "Spec complete for agent implement" --color "0E8A16"
```

Repeat for each label your tracker lacks.
