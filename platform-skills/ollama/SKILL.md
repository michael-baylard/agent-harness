---
name: ollama
description: Ollama — local LLM pull, run, and OpenAI-compatible API for offline agent loops. Use when routing subagents or scripts to localhost models.
last_updated: 2026-09-09
---

# Ollama (local models)

## Official docs

| Topic | URL |
|-------|-----|
| Ollama | https://ollama.com |
| API | https://github.com/ollama/ollama/blob/main/docs/api.md |
| Modelfile | https://github.com/ollama/ollama/blob/main/docs/modelfile.md |

## Agent rules

1. **Default local stack** — Ollama is the fastest path to local inference on Mac/Windows/Linux for harness dev loops.
2. **Model pick** — coding: `qwen2.5-coder`, `deepseek-coder-v2`, `codellama`; general: `llama3.1`, `mistral`. Match VRAM (8GB ≈ 7–8B Q4).
3. **OpenAI-compatible** — point tools at `http://localhost:11434/v1` when the client supports base URL override.
4. **Never for ship gates** — local models OK for explore/draft; verification and customer copy stay on cloud S-tier models per MODEL-ROUTER.
5. **Privacy** — prefer Ollama for secrets-heavy repos when cloud upload is disallowed.

## Common tasks

```powershell
ollama pull qwen2.5-coder:7b
ollama run qwen2.5-coder:7b
curl http://localhost:11434/api/tags
```

## Pairs with

- `agent-cli` — headless agent calling local endpoint
- `vllm` — when you need batched GPU serving instead of desktop Ollama

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| 70B model on 8GB VRAM | Quantized 7–8B or cloud escalate |
| Local model for schema migrations | Opus / db-architect |
| Storing models in git | `ollama pull` in setup doc |
