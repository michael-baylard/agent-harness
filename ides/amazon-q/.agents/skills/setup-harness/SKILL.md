---
name: setup-harness
description: One-time per-repo setup — issue tracker, triage labels, domain doc paths, AGENTS.md block. Use when onboarding a new project to agent-harness. Do not use on every session.
disable-model-invocation: true
last_updated: 2026-09-09
---

# Setup harness

Adapted from [mattpocock/setup-matt-pocock-skills](https://github.com/mattpocock/skills). Run **once per consuming repo**.

## Ask the user

1. **Issue tracker:** GitHub (`gh`) · GitLab (`glab`) · local `.scratch/` · other (one paragraph)
2. **Triage labels:** Confirm or customize [`docs/agents/triage-labels.md`](../../docs/agents/triage-labels.md)
3. **Domain docs path:** Default `docs/domain/` — ok?
4. **RAG:** Enable Neon embeddings? → point to [`docs/rag/neon-doppler-setup.md`](../../docs/rag/neon-doppler-setup.md)
5. **Instruction file:** `AGENTS.md` (canonical). If `CLAUDE.md` exists, add one line: `@AGENTS.md`

## Write / update

| File | Content |
|------|---------|
| `docs/agents/issue-tracker.md` | Tracker + CLI commands |
| `docs/agents/domain.md` | Domain layout |
| `docs/agents/triage-labels.md` | Label map (if `/triage` installed) |
| `AGENTS.md` | From `AGENTS.template.md` + `## Agent harness` block |
| `config/rag.yaml` | Copy from `config/rag.template.yaml` if RAG enabled |

## AGENTS.md block template

```markdown
## Agent harness

- Entry: `HARNESS.md` · ROI: `TOOLS-ROI.md`
- Router: `/ask-harness` · Setup: `/setup-harness` (once)
- Sync: `pwsh -File path/to/agent-harness/install.ps1`
- Issue tracker: docs/agents/issue-tracker.md
```

## Verify

- [ ] `install.ps1` run; Cursor restarted
- [ ] Labels exist in tracker (if GitHub)
- [ ] `/ask-harness` returns a sensible route for "fix a bug"

Do **not** edit vendor SKILL.md files — only repo config markdown.
