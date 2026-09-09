---
name: fast-ops
description: Fast repo search with rg, fd, and ast-grep instead of shell recursion. Use for locate, wide grep, or AST-aware refactors. Do not use for reading file contents — use Read after locate.
last_updated: 2026-09-09
---

# Fast ops

Rust CLIs beat PowerShell/bash recursion for agent locate work.

## Commands

```powershell
# Text search
rg -n "pattern" src/

# Find files by name
fd -e tsx component

# AST-aware search (example)
ast-grep -p 'function $NAME($$$)' --lang typescript src/
```

## Install

| OS | Command |
|----|---------|
| Windows | `winget install BurntSushi.ripgrep sharkdp.fd ast-grep.ast-grep` |
| macOS | `brew install ripgrep fd ast-grep` |
| Linux | distro packages or `cargo install` |

Full catalog: [`docs/research/references.md`](../../docs/research/references.md)

## When NOT to use

- File <1 KB you already know the path — just Read
- Need semantic "what calls X" at scale — consider dependency graph tools if project has them
