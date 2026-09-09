# Model router — task → best model for the cost

> _Last updated: 2026-09-09_ · Canonical prices: [`cost-catalog.json`](cost-catalog.json) · Source lineage: [research MODEL-INTEL](https://github.com/michael-baylard/agent-harness/blob/main/docs/models/README.md)

**Principle:** Context + harness beat model chasing. Use this table when the harness cannot solve it alone.

## Quick pick (harness tasks)

| Rank | Your task | Model | Why | $/1M in–out | Value tier |
|:----:|-----------|-------|-----|-------------|:----------:|
| 1 | Cursor daily agent / ship | **Composer 2.5 Fast** | MCP + subagents; included in plan | Cursor plan | **S** |
| 2 | Vague → sharp prompt | **Claude Opus 5** (thinking) | Narrow search space once | 5 / 25 | A |
| 3 | Multi-file implement | **MiniMax-M3** | Cheap structured diffs | 0.30 / 1.20 | **S** |
| 4 | Wide locate / explore subagent | **fast** (Composer / Haiku class) | Noise delegation | 1–5 / 5–25 | **S** |
| 5 | Adversarial ship gate | **fast** + deterministic scripts | Collapse alpha; don't re-prompt | low | **S** |
| 6 | Human prose / docs | **md-plain-language** (Sonnet class) | Readable output | 2 / 10 | A |
| 7 | HTML / dashboard visual | **gemini-3.7-flash** + visual critic | Best $ for UI gen (intro pricing) | 0.75 / 3.75* | **S** |
| 8 | Hard stuck loop (3+ fails) | **Claude Opus 5** | Highest agentic bar | 5 / 25 | A |
| 9 | Schema / migrations | **Opus 5** or `db-architect` | Correctness > cost | 5 / 25 | A |
| 10 | Volume JSON classify | **gemini-3.5-flash-lite** | Cheapest reliable volume | 0.30 / 2.50 | **S** |
| 11 | Research fan-out / SERP synth | **Groq gpt-oss-20b** | ~1000 tok/s | 0.075 / 0.30 | **S** |
| 12 | Long PDF / doc synthesis | **gemini-3.7-flash** | 1M ctx; strong AutomationBench | 0.75 / 3.75* | **S** |
| 13 | Finance / capital $ facts | **Claude Sonnet 5** | GDPVal-AA Elo edge; never GPT-5.x for $ | 2 / 10 | A |
| 14 | Terminal / shell heavy | **GPT-5.6 Sol** | Routing convention | 5 / 30 | B |
| 15 | Brainstorm in Cursor limits | **Grok 4.6 High Fast** | Strong under 200k ctx | 2 / 6 | A |
| 16 | Embeddings (RAG) | **Voyage voyage-4** | Not an LLM — 1024-dim | API per token | A |

\* Gemini 3.7 Flash intro through 2026-12-31; then 1.50 / 7.50.

## Value tier legend

| Tier | Meaning |
|------|---------|
| **S** | Best quality-per-dollar for this task class |
| **A** | Strong; use when S tier fails or task demands it |
| **B** | Situational; higher cost or narrower win |

## Intelligence vs cost (frontier agents, Aug 2026)

Google model-card benchmarks — use for **API** routing, not Cursor picker names:

| Model | AA Index | Best at | in / out | $ efficiency |
|-------|:--------:|---------|----------|--------------|
| GPT-5.6 Terra | 57 | DeepSWE | 2.50 / 15 | Medium |
| **Gemini 3.7 Flash** | 56 | Agents, PDFs, automation | **0.75 / 3.75** | **Highest** |
| Claude Sonnet 5 | 55 | Knowledge work, $ facts | 2 / 10 | High |
| Gemini 3.6 Flash | 52 | Fallback flash | 1.50 / 7.50 | Medium |
| Claude Opus 5 | — | Hard agentic loops | 5 / 25 | Low (quality buy) |

## Subagent → model map

| Subagent | Default model class | Escalate to |
|----------|---------------------|-------------|
| `caveman-explore` | fast | — |
| `caveman-review` | fast | Opus if security |
| `adversarial-verifier` | fast | inherit if schema |
| `db-architect` | thinking (Opus) | — |
| `md-plain-language` | Sonnet class | — |
| `highspeed` | fast | — |

Rule: `cursor-rules/subagent-arsenal.mdc` · skill `ship-check`.

## Do not

| Avoid | Use instead |
|-------|-------------|
| GPT-5.x for factual / financial synthesis | Sonnet 5 or verified sources |
| Opus for wide grep | `fast-ops` + caveman-explore |
| Frontier model for typos | Main thread |
| 10+ MCP + Opus on everything | ≤6 MCP profile; tier models |

## Refresh

Monthly or on vendor launch:

```powershell
# From research repo (canonical catalog)
doppler run --project personal --config prd -- python scripts/model_intel/refresh_serper.py
# Copy catalog.json → agent-harness/docs/models/cost-catalog.json
```

**Pro tier:** automated refresh script + quarterly intel stamp in `agent-harness-pro`.
