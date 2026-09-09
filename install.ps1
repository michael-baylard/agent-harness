# Sync harness into a consuming repo for Cursor or documented IDE paths.
# Usage: pwsh -File install.ps1 [-Ide cursor|claude-code|windsurf] [-HarnessRoot <path>] [-TargetRoot <path>] [-DryRun]

param(
    [ValidateSet('cursor', 'claude-code', 'windsurf')]
    [string]$Ide = 'cursor',
    [string]$HarnessRoot = $PSScriptRoot,
    [string]$TargetRoot = (Get-Location).Path,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

function Sync-Dir {
    param([string]$Source, [string]$Dest, [string]$Label)
    if (-not (Test-Path $Source)) {
        Write-Warning "Skip $Label — source missing: $Source"
        return
    }
    if ($DryRun) {
        Write-Host "[dry-run] Would sync $Label`: $Source -> $Dest"
        Get-ChildItem -Path $Source -Recurse -File | ForEach-Object {
            $rel = $_.FullName.Substring($Source.Length).TrimStart('\', '/')
            Write-Host "  $rel"
        }
        return
    }
    New-Item -ItemType Directory -Force -Path $Dest | Out-Null
    Copy-Item -Path (Join-Path $Source '*') -Destination $Dest -Recurse -Force
    Write-Host "Synced $Label -> $Dest"
}

function Copy-FileIfExists {
    param([string]$Source, [string]$Dest, [string]$Label)
    if (-not (Test-Path $Source)) {
        Write-Warning "Skip $Label — missing $Source"
        return
    }
    if ($DryRun) {
        Write-Host "[dry-run] Would copy $Label`: $Source -> $Dest"
        return
    }
    Copy-Item -Path $Source -Destination $Dest -Force
    Write-Host "Copied $Label -> $Dest"
}

$rulesSrc = Join-Path $HarnessRoot "cursor-rules"
$skillsSrc = Join-Path $HarnessRoot "cursor-skills"

switch ($Ide) {
    'cursor' {
        Sync-Dir -Source $rulesSrc -Dest (Join-Path $TargetRoot ".cursor\rules") -Label "cursor rules"
        Sync-Dir -Source $skillsSrc -Dest (Join-Path $TargetRoot ".cursor\skills") -Label "cursor skills"
    }
    'claude-code' {
        Sync-Dir -Source $skillsSrc -Dest (Join-Path $TargetRoot ".claude\skills") -Label "claude skills"
        Copy-FileIfExists -Source (Join-Path $HarnessRoot "HARNESS.md") -Dest (Join-Path $TargetRoot "HARNESS.md") -Label "HARNESS.md"
        Copy-FileIfExists -Source (Join-Path $HarnessRoot "AGENTS.template.md") -Dest (Join-Path $TargetRoot "AGENTS.md") -Label "AGENTS.md"
    }
    'windsurf' {
        Sync-Dir -Source $skillsSrc -Dest (Join-Path $TargetRoot ".windsurf\skills") -Label "windsurf skills"
        Copy-FileIfExists -Source (Join-Path $HarnessRoot "HARNESS.md") -Dest (Join-Path $TargetRoot "HARNESS.md") -Label "HARNESS.md"
        Write-Host "Note: convert cursor-rules to .windsurf/rules/*.md with YAML trigger frontmatter (see ides/windsurf/README.md)"
    }
}

Write-Host ""
if ($Ide -eq 'cursor') {
    Write-Host "Done. Restart Cursor. Point agents at HARNESS.md and copy AGENTS.template.md -> AGENTS.md"
} else {
    Write-Host "Done ($Ide). See ides/$Ide/README.md and https://klarix.ai/harness/ides"
}
