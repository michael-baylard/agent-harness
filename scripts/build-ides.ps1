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
        Write-Host "[dry-run] $Source -> $Dest"
        return
    }
    if (Test-Path $Dest) { Remove-Item -Recurse -Force $Dest }
    New-Item -ItemType Directory -Force -Path $Dest | Out-Null
    Copy-Item -Path (Join-Path $Source '*') -Destination $Dest -Recurse -Force
    Write-Host "Built $Label -> $Dest"
}

# Cursor: mirror rules + skills into ides/cursor/.cursor/
$cursorBase = Join-Path $Root "ides\cursor\.cursor"
Sync-Tree -Source (Join-Path $Root "cursor-rules") -Dest (Join-Path $cursorBase "rules") -Label "ides/cursor rules"
Sync-Tree -Source (Join-Path $Root "cursor-skills") -Dest (Join-Path $cursorBase "skills") -Label "ides/cursor skills"

# Copy entry docs beside .cursor/
foreach ($file in @("HARNESS.md", "AGENTS.template.md", "TOOLS-ROI.md")) {
    $src = Join-Path $Root $file
    $dst = Join-Path $Root "ides\cursor\$file"
    if (Test-Path $src) {
        if ($DryRun) { Write-Host "[dry-run] copy $file"; continue }
        Copy-Item $src $dst -Force
    }
}

Write-Host ""
Write-Host "Done. Commit ides/ if output changed. Other IDE folders are README-only until generation expands."
