# Sync tracked harness into a consuming repo's .cursor/ folder.
# Usage: pwsh -File install.ps1 [-HarnessRoot <path>] [-TargetRoot <path>] [-DryRun]

param(
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

$rulesSrc = Join-Path $HarnessRoot "cursor-rules"
$skillsSrc = Join-Path $HarnessRoot "cursor-skills"
$rulesDest = Join-Path $TargetRoot ".cursor\rules"
$skillsDest = Join-Path $TargetRoot ".cursor\skills"

Sync-Dir -Source $rulesSrc -Dest $rulesDest -Label "rules"
Sync-Dir -Source $skillsSrc -Dest $skillsDest -Label "skills"

Write-Host ""
Write-Host "Done. Restart Cursor. Point agents at HARNESS.md and copy AGENTS.template.md -> AGENTS.md"
