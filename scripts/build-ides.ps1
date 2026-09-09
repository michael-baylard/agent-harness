# Regenerate ides/* adapter folders from canonical Cursor assets.
# Usage: pwsh -File scripts/build-ides.ps1 [-DryRun]

param([switch]$DryRun)

$ErrorActionPreference = "Stop"
$Root = Split-Path $PSScriptRoot -Parent

function Sync-Tree {
    param([string]$Source, [string]$Dest, [string]$Label)
    if (-not (Test-Path $Source)) {
        Write-Warning "Skip $Label — missing $Source"
        return
    }
    if ($DryRun) {
        Write-Host "[dry-run] $Label`: $Source -> $Dest"
        return
    }
    if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
    New-Item -ItemType Directory -Force -Path $Dest | Out-Null
    Copy-Item -Path (Join-Path $Source '*') -Destination $Dest -Recurse -Force
    Write-Host "Built $Label"
}

function Write-TextFile {
    param([string]$Path, [string]$Content, [string]$Label)
    if ($DryRun) {
        Write-Host "[dry-run] write $Label"
        return
    }
    $dir = Split-Path $Path -Parent
    if ($dir -and -not (Test-Path $dir)) {
        New-Item -ItemType Directory -Force -Path $dir | Out-Null
    }
    Set-Content -Path $Path -Value $Content -Encoding utf8NoBOM
    Write-Host "Wrote $Label"
}

function Build-CommonKit {
    param([string]$IdeDir, [string]$Label)
    $skillsSrc = Join-Path $Root "cursor-skills"
    $agentsSrc = Join-Path $Root "cursor-agents"
    $mcpProfilesSrc = Join-Path $Root "config\mcp-profiles"

    Sync-Tree -Source $skillsSrc -Dest (Join-Path $IdeDir ".agents\skills") -Label "$Label .agents/skills"
    Sync-Tree -Source $agentsSrc -Dest (Join-Path $IdeDir "delegates") -Label "$Label delegates"

    if (Test-Path $mcpProfilesSrc) {
        Sync-Tree -Source $mcpProfilesSrc -Dest (Join-Path $IdeDir "mcp-profiles") -Label "$Label mcp-profiles"
    }

    foreach ($file in @("HARNESS.md", "AGENTS.template.md", "TOOLS-ROI.md")) {
        $src = Join-Path $Root $file
        $dst = Join-Path $IdeDir $file
        if (-not (Test-Path $src)) { continue }
        if ($DryRun) { Write-Host "[dry-run] copy $file -> $Label"; continue }
        Copy-Item $src $dst -Force
    }

    $parityDoc = Join-Path $Root "docs\IDE-PARITY.md"
    if (Test-Path $parityDoc) {
        if ($DryRun) { Write-Host "[dry-run] copy IDE-PARITY.md -> $Label"; return }
        Copy-Item $parityDoc (Join-Path $IdeDir "IDE-PARITY.md") -Force
    }
}

$mcpReadme = @"
# MCP profiles (harness)

Copy a profile from ``mcp-profiles/`` and wire servers in your IDE MCP settings (≤6 per session).

See ``docs/MCP-RECOMMENDATIONS.md`` in the harness root for server names and when to enable each.

Cursor: ``.cursor/mcp.json`` · Claude Code: ``.mcp.json`` · Windsurf/Cline/Continue: IDE MCP UI + env vars.
"@

$delegatesReadme = @"
# Delegate briefs (adapted subagents)

Portable subagent prompts — same content as Cursor ``cursor-agents/``. On non-Cursor IDEs:

1. Open a delegate file (e.g. ``caveman-explore.md``).
2. Start a new agent session or mode; paste the brief as system context.
3. Or invoke the ``/parallel-work`` skill for handoff steps.

Native subagent dispatch: Cursor and Codex CLI. Every other IDE uses this folder as the full-kit equivalent.
"@

$geminiMd = @"
# GEMINI.md — Antigravity / Gemini CLI overrides

IDE-specific notes on top of ``AGENTS.md``. Keep harness phase protocol and ship gates here when the IDE reads this file.

See ``HARNESS.md`` and ``IDE-PARITY.md`` for install paths.
"@

$soulMd = @"
# SOUL.md — OpenClaw operator persona

OpenClaw reads ``SOUL.md`` for persistent operator tone. Keep harness voice: direct, scoped verify, no filler.

Workflow: ``AGENTS.md`` (team rules) + ``SOUL.md`` (operator) + MCP servers from ``mcp-profiles/``.
"@

# --- Cursor (native layout) ---
$cursorDir = Join-Path $Root "ides\cursor"
$cursorBase = Join-Path $cursorDir ".cursor"
Sync-Tree -Source (Join-Path $Root "cursor-rules") -Dest (Join-Path $cursorBase "rules") -Label "ides/cursor rules"
Sync-Tree -Source (Join-Path $Root "cursor-skills") -Dest (Join-Path $cursorBase "skills") -Label "ides/cursor skills"
Sync-Tree -Source (Join-Path $Root "cursor-agents") -Dest (Join-Path $cursorBase "agents") -Label "ides/cursor agents"
Build-CommonKit -IdeDir $cursorDir -Label "ides/cursor kit"

# --- Codex CLI (native agents layout) ---
$codexDir = Join-Path $Root "ides\codex"
Build-CommonKit -IdeDir $codexDir -Label "ides/codex"
Sync-Tree -Source (Join-Path $Root "cursor-agents") -Dest (Join-Path $codexDir ".codex\agents") -Label "ides/codex .codex/agents"
Write-TextFile -Path (Join-Path $codexDir "AGENTS.md") -Content (Get-Content (Join-Path $Root "AGENTS.template.md") -Raw) -Label "ides/codex AGENTS.md"
Write-TextFile -Path (Join-Path $codexDir "delegates\README.md") -Content $delegatesReadme -Label "codex delegates readme"
$codexReadme = @"
# OpenAI Codex CLI adapter (auto-routing)

| Surface | Status |
|---------|--------|
| Rules | ``AGENTS.md`` |
| Skills | ``.agents/skills/`` |
| MCP | ``mcp-profiles/*.yaml`` + Codex MCP config |
| Subagents | Native ``.codex/agents/`` (from harness ``cursor-agents/``) |

Install: ``pwsh -File install.ps1 -Ide codex``

Live matrix: https://klarix.ai/harness/ides
"@
Write-TextFile -Path (Join-Path $codexDir "README.md") -Content $codexReadme -Label "codex README"

# --- Claude Code ---
$claudeDir = Join-Path $Root "ides\claude-code"
Build-CommonKit -IdeDir $claudeDir -Label "ides/claude-code"
Sync-Tree -Source (Join-Path $Root "cursor-skills") -Dest (Join-Path $claudeDir ".claude\skills") -Label "ides/claude-code .claude/skills"
Write-TextFile -Path (Join-Path $claudeDir "AGENTS.md") -Content (Get-Content (Join-Path $Root "AGENTS.template.md") -Raw) -Label "ides/claude-code AGENTS.md"
Write-TextFile -Path (Join-Path $claudeDir "mcp-profiles\README.md") -Content $mcpReadme -Label "claude mcp readme"
Write-TextFile -Path (Join-Path $claudeDir "delegates\README.md") -Content $delegatesReadme -Label "claude delegates readme"

# --- Windsurf ---
$windsurfDir = Join-Path $Root "ides\windsurf"
Build-CommonKit -IdeDir $windsurfDir -Label "ides/windsurf"
Sync-Tree -Source (Join-Path $Root "cursor-skills") -Dest (Join-Path $windsurfDir ".windsurf\skills") -Label "ides/windsurf .windsurf/skills"
Write-TextFile -Path (Join-Path $windsurfDir "delegates\README.md") -Content $delegatesReadme -Label "windsurf delegates readme"

# --- Google Antigravity ---
$antigravityDir = Join-Path $Root "ides\antigravity"
Build-CommonKit -IdeDir $antigravityDir -Label "ides/antigravity"
Sync-Tree -Source (Join-Path $Root "cursor-rules") -Dest (Join-Path $antigravityDir ".agents\rules") -Label "ides/antigravity .agents/rules"
Write-TextFile -Path (Join-Path $antigravityDir "AGENTS.md") -Content (Get-Content (Join-Path $Root "AGENTS.template.md") -Raw) -Label "ides/antigravity AGENTS.md"
Write-TextFile -Path (Join-Path $antigravityDir "GEMINI.md") -Content $geminiMd -Label "ides/antigravity GEMINI.md"
Write-TextFile -Path (Join-Path $antigravityDir "delegates\README.md") -Content $delegatesReadme -Label "antigravity delegates readme"
Write-TextFile -Path (Join-Path $antigravityDir "README.md") -Content "# Google Antigravity adapter (full kit)`n`nInstall: ``pwsh -File install.ps1 -Ide antigravity```n`nLive matrix: https://klarix.ai/harness/ides" -Label "antigravity README"

# --- Gemini CLI ---
$geminiCliDir = Join-Path $Root "ides\gemini-cli"
Build-CommonKit -IdeDir $geminiCliDir -Label "ides/gemini-cli"
Write-TextFile -Path (Join-Path $geminiCliDir "AGENTS.md") -Content (Get-Content (Join-Path $Root "AGENTS.template.md") -Raw) -Label "ides/gemini-cli AGENTS.md"
Write-TextFile -Path (Join-Path $geminiCliDir "GEMINI.md") -Content $geminiMd -Label "ides/gemini-cli GEMINI.md"
Write-TextFile -Path (Join-Path $geminiCliDir "delegates\README.md") -Content $delegatesReadme -Label "gemini-cli delegates readme"
Write-TextFile -Path (Join-Path $geminiCliDir "README.md") -Content "# Gemini CLI adapter (full kit)`n`nInstall: ``pwsh -File install.ps1 -Ide gemini-cli```n`nLive matrix: https://klarix.ai/harness/ides" -Label "gemini-cli README"

# --- Amazon Q Developer ---
$amazonQDir = Join-Path $Root "ides\amazon-q"
Build-CommonKit -IdeDir $amazonQDir -Label "ides/amazon-q"
Sync-Tree -Source (Join-Path $Root "cursor-rules") -Dest (Join-Path $amazonQDir ".amazonq\rules") -Label "ides/amazon-q .amazonq/rules"
Write-TextFile -Path (Join-Path $amazonQDir "AGENTS.md") -Content (Get-Content (Join-Path $Root "AGENTS.template.md") -Raw) -Label "ides/amazon-q AGENTS.md"
Write-TextFile -Path (Join-Path $amazonQDir "delegates\README.md") -Content $delegatesReadme -Label "amazon-q delegates readme"
Write-TextFile -Path (Join-Path $amazonQDir "README.md") -Content "# Amazon Q Developer adapter (full kit)`n`nInstall: ``pwsh -File install.ps1 -Ide amazon-q```n`nLive matrix: https://klarix.ai/harness/ides" -Label "amazon-q README"

# --- OpenClaw ---
$openclawDir = Join-Path $Root "ides\openclaw"
Build-CommonKit -IdeDir $openclawDir -Label "ides/openclaw"
Write-TextFile -Path (Join-Path $openclawDir "AGENTS.md") -Content (Get-Content (Join-Path $Root "AGENTS.template.md") -Raw) -Label "ides/openclaw AGENTS.md"
Write-TextFile -Path (Join-Path $openclawDir "SOUL.md") -Content $soulMd -Label "ides/openclaw SOUL.md"
Write-TextFile -Path (Join-Path $openclawDir "delegates\README.md") -Content $delegatesReadme -Label "openclaw delegates readme"
Write-TextFile -Path (Join-Path $openclawDir "README.md") -Content "# OpenClaw adapter (full kit)`n`nInstall: ``pwsh -File install.ps1 -Ide openclaw```n`nLive matrix: https://klarix.ai/harness/ides" -Label "openclaw README"

# --- Community / full-kit IDEs (shared kit + README pointer) ---
$kitOnly = @(
    @{ Slug = "vscode-copilot"; Name = "VS Code + GitHub Copilot" }
    @{ Slug = "cline"; Name = "Cline" }
    @{ Slug = "roo"; Name = "Roo Code" }
    @{ Slug = "continue"; Name = "Continue.dev" }
    @{ Slug = "zed"; Name = "Zed" }
    @{ Slug = "jetbrains-junie"; Name = "JetBrains Junie" }
)

foreach ($entry in $kitOnly) {
    $dir = Join-Path $Root "ides\$($entry.Slug)"
    Build-CommonKit -IdeDir $dir -Label "ides/$($entry.Slug)"
    Write-TextFile -Path (Join-Path $dir "delegates\README.md") -Content $delegatesReadme -Label "$($entry.Slug) delegates readme"
    $readme = @"
# $($entry.Name) adapter (full kit)

Generated by ``scripts/build-ides.ps1``. Every harness surface is covered:

| Surface | Status |
|---------|--------|
| Rules | Adapted — copy from ``.agents/skills`` + IDE-specific paths in ``config/ide-matrix.yaml`` |
| Skills | ``.agents/skills/`` (SKILL.md open standard) |
| MCP profiles | ``mcp-profiles/*.yaml`` + wire in IDE settings |
| Subagents | ``delegates/*.md`` — adapted handoff (see ``IDE-PARITY.md``) |

Install: ``pwsh -File install.ps1 -Ide $($entry.Slug)``

Live matrix: https://klarix.ai/harness/ides
"@
    Write-TextFile -Path (Join-Path $dir "README.md") -Content $readme -Label "$($entry.Slug) README"
}

Write-Host ""
Write-Host "Done. Run scripts/verify-ides-parity.ps1 before commit."
