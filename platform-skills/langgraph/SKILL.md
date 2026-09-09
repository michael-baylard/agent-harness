---
name: langgraph
description: LangGraph — stateful agent graphs, checkpoints, human-in-the-loop, and multi-step LLM workflows. Use when editing graph nodes, edges, or LangChain agent orchestration.
last_updated: 2026-09-09
---

# LangGraph

## Official docs

| Topic | URL |
|-------|-----|
| LangGraph | https://langchain-ai.github.io/langgraph/ |
| Concepts | https://langchain-ai.github.io/langgraph/concepts/ |
| LangChain docs | https://python.langchain.com/docs/ |

## Agent rules

1. **Graph first** — model flows as nodes + edges with explicit state schema, not ad-hoc while loops.
2. **Checkpoints** — use persistence for long runs; document thread_id / checkpoint backend.
3. **Human gates** — interrupt before irreversible tools (payments, deletes, prod deploy).
4. **Model routing** — cheap local/cloud model for explore nodes; S-tier cloud for final synthesis (see MODEL-ROUTER).
5. **Context7** — LangGraph API changes frequently; verify imports against current docs.

## Pairs with

- `fastapi` — expose graph as HTTP endpoint
- `ollama` / `vllm` — local model nodes
- `postgres` / `neon` — checkpoint store

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| Unbounded agent recursion | max_iterations + verifier node |
| Secrets in graph state | Env / secret store |
| Monolithic single node | Decompose: retrieve → plan → act → verify |
