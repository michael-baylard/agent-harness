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

Native subagent dispatch is Cursor-only; this folder is the full-kit equivalent.
"@

# --- Cursor (native layout) ---
$cursorDir = Join-Path $Root "ides\cursor"
$cursorBase = Join-Path $cursorDir ".cursor"
Sync-Tree -Source (Join-Path $Root "cursor-rules") -Dest (Join-Path $cursorBase "rules") -Label "ides/cursor rules"
Sync-Tree -Source (Join-Path $Root "cursor-skills") -Dest (Join-Path $cursorBase "skills") -Label "ides/cursor skills"
Sync-Tree -Source (Join-Path $Root "cursor-agents") -Dest (Join-Path $cursorBase "agents") -Label "ides/cursor agents"
Build-CommonKit -IdeDir $cursorDir -Label "ides/cursor kit"

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
