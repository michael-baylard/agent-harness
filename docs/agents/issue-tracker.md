# Issue tracker — template

> _Last updated: 2026-09-09_ · Customize via `/setup-harness` or edit directly.

**Tracker:** GitHub Issues on `{owner}/{repo}` — run `git remote get-url origin` to confirm.

**CLI:** `gh` (authenticated). Commands: `gh issue create`, `gh issue view`, `gh issue list`, `gh pr create`.

## Operations

| Action | Pattern |
|--------|---------|
| Create issue | `gh issue create --title "..." --body-file .scratch/issue-body.md` |
| Spec from chat | Vendor `/to-spec` |
| Tracer tickets | Vendor `/to-tickets` |
| Blocking edges | Body: `Blocked by #123` |

## Local scratch (offline)

- Issues under `.scratch/<feature>/issues/*.md`
- Filename = slug; first line `# Title`
- Blocking: `Blocked by: other-slug` in frontmatter

## Labels

See [`triage-labels.md`](triage-labels.md). Specs from `/to-spec` → `ready-for-agent`.
