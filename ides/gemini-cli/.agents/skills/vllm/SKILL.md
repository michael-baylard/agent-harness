---
name: vllm
description: vLLM — high-throughput local or server OpenAI-compatible inference. Use for batched GPU serving, multi-agent fan-out, or self-hosted coding models.
last_updated: 2026-09-09
---

# vLLM (local / self-hosted)

## Official docs

| Topic | URL |
|-------|-----|
| vLLM | https://docs.vllm.ai |
| OpenAI server | https://docs.vllm.ai/en/latest/serving/openai_compatible_server.html |

## Agent rules

1. **When Ollama is not enough** — multi-user, high QPS, or specific HF weights → vLLM server.
2. **OpenAI API surface** — clients use `OPENAI_BASE_URL=http://host:8000/v1` + dummy key.
3. **GPU memory** — check `--gpu-memory-utilization`; tensor parallel for multi-GPU.
4. **Harness routing** — volume classify / JSON fan-out to local vLLM; implement + review on cloud S-tier.
5. **Do not commit weights** — document model name + HF repo in README, not binaries.

## Pairs with

- `ollama` — desktop dev vs server vLLM
- `docker` — containerized vLLM deploy
- `kubernetes` — GPU node pools for inference

## Anti-patterns

| Avoid | Instead |
|-------|---------|
| vLLM for single-laptop daily chat | Ollama |
| Unpinned `--model` in prod | Version tag in deploy manifest |
