# agent-harness

> _Last updated: 2026-09-09_

Portable **Cursor agent harness** — rules, skills, subagents, and research docs distilled from years of multi-repo work. Drop into any new project; no product-specific scripts required.

## Quick start

```powershell
# From your new repo root — clone or submodule this repo, then:
pwsh -File path/to/agent-harness/install.ps1

# Or copy manually:
#   cursor-rules/*  →  .cursor/rules/
#   cursor-skills/* →  .cursor/skills/
#   cursor-agents/* →  ~/.cursor/agents/  (or project cursor-agents/)
```

Restart Cursor. Open **HARNESS.md** — any AI should start there.

## What's inside

| Layer | Path | Purpose |
|-------|------|---------|
| **Entry** | [`HARNESS.md`](HARNESS.md) | AI onboarding — phase protocol, ROI catalog pointer |
| **ROI catalog** | [`TOOLS-ROI.md`](TOOLS-ROI.md) | Every asset ranked S/A/B with when-to-use |
| **Project template** | [`AGENTS.template.md`](AGENTS.template.md) | Copy → `AGENTS.md` in consuming repo |
| **Rules** | `cursor-rules/` | Always-on workflow + communication |
| **Skills** | `cursor-skills/` | Slash-invoked workflows (`/sharpen-query`, etc.) |
| **Subagents** | `cursor-agents/` | Delegate noisy search/review |
| **Docs** | `docs/agents/` · `docs/research/` | Harness ops + systems/concurrency ideologies |
| **Vendor manifest** | `config/skills-vendor.yaml` | Optional Matt Pocock + Vercel skills |

## Design principles

1. **Context > model** — rich repo-native files beat chasing frontier models.
2. **No product coupling** — zero domain scripts; only sync + docs.
3. **Curated, not dumped** — ~15 skills, not marketplace sprawl.
4. **Verify before ship** — deterministic gates collapse model alpha.
5. **Native when it matters** — Rust CLIs for locate; Rust/C for hot paths only ([`docs/research/concurrency-and-systems.md`](docs/research/concurrency-and-systems.md)).

## Optional vendor skills

```powershell
# After install.ps1 — curated third-party pack (Matt Pocock + Vercel)
npx skills experimental_install   # uses config/skills-vendor.yaml pattern
# Or follow https://skills.sh for manual install
```

## License

Private — Michael Baylard. Fork for your own repos.
