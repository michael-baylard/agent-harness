# Skills routing

> _Last updated: 2026-09-09_

## Native harness skills

| Situation | Invoke |
|-----------|--------|
| Unsure which workflow | `/ask-harness` |
| Vague "fix the app" | `/sharpen-query` |
| 3+ files / API coupling | `/plan-before-code` |
| Context full / compact | `/session-handoff` |
| 2+ independent tickets | `/parallel-work` |
| Before ship / merge | `ship-check` |
| Wide grep / locate | `fast-ops` |

## Vendor — Matt Pocock (skills.sh)

| Situation | Invoke |
|-----------|--------|
| Thread → spec | `/to-spec` |
| Spec → tickets | `/to-tickets` |
| Build one ticket | `/implement` |
| Test-first | `/tdd` |
| Hard bug | `/diagnosing-bugs` |
| Pre-merge review | `/code-review` |
| Huge foggy effort | `/wayfinder` |
| Portable MD handoff | `/handoff` |

## Vendor — Vercel (if Next.js)

| Situation | Invoke |
|-----------|--------|
| Deploy | `/deploy-to-vercel` |
| Bill / caching | `/vercel-optimize` |
| React perf | `/vercel-react-best-practices` |

## Subagents

| Situation | Subagent |
|-----------|----------|
| 15+ path hits | `caveman-explore` |
| Diff review | `caveman-review` |
| Skeptical ship | `adversarial-verifier` |
| Human prose | `md-plain-language` |
| Schema | `db-architect` |

## Near-miss boundaries

| Don't use | Use instead | Why |
|-----------|-------------|-----|
| `/handoff` | `/session-handoff` | Same chat vs cross-directory |
| Main thread wide grep | `caveman-explore` | Token cost |
| Marketplace skill dump | `skills-vendor.yaml` | Stale sprawl |
