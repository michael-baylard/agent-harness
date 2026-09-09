# Competitive rank — agent-harness vs GitHub harness repos

> _Last updated: 2026-09-09_ · Stars via GitHub API same day.

## Weighted score (1–5 per dimension)

| Dimension | Weight | agent-harness | mattpocock/skills | vercel-labs/agent-skills | cursor/plugin-template | fieldsphere/cursor-fundamentals |
|-----------|:------:|:-------------:|:-----------------:|:------------------------:|:----------------------:|:-------------------------------:|
| SDLC depth (spec→ship) | 20% | 4 | **5** | 3 | 2 | 4 |
| Portability (any repo) | 15% | **5** | 4 | 2 | 4 | 3 |
| Research / ideology docs | 15% | **5** | 2 | 1 | 1 | 2 |
| ROI / onboarding clarity | 15% | **5** | 3 | 2 | 2 | 3 |
| Model cost router | 10% | **5** | 1 | 1 | 1 | 1 |
| RAG / semantic docs | 10% | **4** | 1 | 1 | 1 | 1 |
| Distribution readiness | 10% | 2 | **5** | **5** | 4 | 3 |
| Plugin marketplace format | 5% | 3* | 4 | **5** | **5** | **5** |
| Verification / ship gates | 5% | **5** | 4 | 2 | 1 | 3 |
| **Weighted total** | 100% | **4.35** | 3.65 | 2.15 | 2.40 | 2.85 |

\* Plugin manifest added this pass.

## Reference table (stars · overlap)

| Repo | ★ | Overlap | Unique to them |
|------|---|---------|----------------|
| [mattpocock/skills](https://github.com/mattpocock/skills) | 257k | SDLC skills | skills.sh distribution, Claude plugin |
| [vercel-labs/agent-skills](https://github.com/vercel-labs/agent-skills) | 31k | Skill layout | Vercel deploy/perf |
| [vercel-labs/skills](https://github.com/vercel-labs/skills) | 31k | CLI install | 70+ agent targets |
| [cursor/plugin-template](https://github.com/cursor/plugin-template) | 93 | Packaging | Official marketplace submit |
| [fieldsphere/cursor-team-marketplace-template](https://github.com/fieldsphere/cursor-team-marketplace-template) | 39 | Team plugins | Org function splits |
| [pingdotgg/t3code](https://github.com/pingdotgg/t3code) | 22k | Parallel sessions | GUI control plane |
| [ThePrimeagen/99](https://github.com/ThePrimeagen/99) | 4.7k | Native CLIs | Neovim integration |
| **agent-harness** | 0 | **Full stack** | TOOLS-ROI, model router, RAG, research corpus |

## Verdict

**No exact competitor.** Closest combo = mattpocock + cursor-fundamentals + Gumroad rule packs.

**Win:** content depth (ROI catalog, models, research, RAG).  
**Lose:** distribution (stars, marketplace listing, skills.sh presence).

## Paid market comps (non-GitHub)

| Product | Price | What you get |
|---------|-------|--------------|
| Cursor Rules Mega Pack (Gumroad) | $19 | 53 `.cursorrules` files |
| Custom rules service | $49 | One bespoke file |
| Build to Launch kit | $13+ | 16 rule/security files |
| **Agent Harness Pro (proposed)** | **$49–99** | Full harness + RAG + model router + updates |

Position: **rules packs sell files; we sell a operating system for agents.**
