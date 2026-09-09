# Sync harness into a consuming repo (full kit per IDE).
# Usage: pwsh -File install.ps1 [-Ide <slug>] [-HarnessRoot <path>] [-TargetRoot <path>] [-DryRun]
# Ides: cursor, codex, claude-code, antigravity, gemini-cli, windsurf, vscode-copilot, amazon-q, openclaw, cline, roo, continue, zed, jetbrains-junie

param(
    [ValidateSet('cursor', 'codex', 'claude-code', 'antigravity', 'gemini-cli', 'windsurf', 'vscode-copilot', 'amazon-q', 'openclaw', 'cline', 'roo', 'continue', 'zed', 'jetbrains-junie')]
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

function Sync-PlatformSkillsTo {
    param([string]$DestSkillsDir, [string]$Label)
    $platformSrc = Join-Path $HarnessRoot "platform-skills"
    if (-not (Test-Path $platformSrc)) { return }
    Get-ChildItem -Path $platformSrc -Directory | ForEach-Object {
        $dst = Join-Path $DestSkillsDir $_.Name
        if ($DryRun) {
            Write-Host "[dry-run] Would merge platform skill $($_.Name) -> $Label"
            return
        }
        New-Item -ItemType Directory -Force -Path $DestSkillsDir | Out-Null
        if (Test-Path $dst) { Remove-Item -Recurse -Force $dst }
        Copy-Item -Path $_.FullName -Destination $dst -Recurse -Force
        Write-Host "Merged platform skill $($_.Name) -> $Label"
    }
}

function Install-CommonKit {
    param([string]$AdapterDir)
    Sync-Dir -Source (Join-Path $AdapterDir ".agents\skills") -Dest (Join-Path $TargetRoot ".agents\skills") -Label ".agents/skills"
    Sync-PlatformSkillsTo -DestSkillsDir (Join-Path $TargetRoot ".agents\skills") -Label ".agents/skills"
    Sync-Dir -Source (Join-Path $AdapterDir "delegates") -Dest (Join-Path $TargetRoot "delegates") -Label "delegates"
    Sync-Dir -Source (Join-Path $AdapterDir "mcp-profiles") -Dest (Join-Path $TargetRoot "harness-mcp-profiles") -Label "mcp-profiles"
    Copy-FileIfExists -Source (Join-Path $AdapterDir "HARNESS.md") -Dest (Join-Path $TargetRoot "HARNESS.md") -Label "HARNESS.md"
    Copy-FileIfExists -Source (Join-Path $AdapterDir "IDE-PARITY.md") -Dest (Join-Path $TargetRoot "IDE-PARITY.md") -Label "IDE-PARITY.md"
    $agents = Join-Path $AdapterDir "AGENTS.md"
    if (Test-Path $agents) {
        Copy-FileIfExists -Source $agents -Dest (Join-Path $TargetRoot "AGENTS.md") -Label "AGENTS.md"
    } else {
        Copy-FileIfExists -Source (Join-Path $HarnessRoot "AGENTS.template.md") -Dest (Join-Path $TargetRoot "AGENTS.md") -Label "AGENTS.md"
    }
}

$adapterDir = Join-Path $HarnessRoot "ides\$Ide"

switch ($Ide) {
    'cursor' {
        $rulesSrc = Join-Path $HarnessRoot "cursor-rules"
        $skillsSrc = Join-Path $HarnessRoot "cursor-skills"
        $agentsSrc = Join-Path $HarnessRoot "cursor-agents"
        Sync-Dir -Source $rulesSrc -Dest (Join-Path $TargetRoot ".cursor\rules") -Label "cursor rules"
        $cursorSkillsDest = Join-Path $TargetRoot ".cursor\skills"
        Sync-Dir -Source $skillsSrc -Dest $cursorSkillsDest -Label "cursor skills"
        Sync-PlatformSkillsTo -DestSkillsDir $cursorSkillsDest -Label "cursor skills"
        Sync-Dir -Source $agentsSrc -Dest (Join-Path $TargetRoot ".cursor\agents") -Label "cursor agents"
        if (Test-Path $adapterDir) { Install-CommonKit -AdapterDir $adapterDir }
    }
    'codex' {
        Install-CommonKit -AdapterDir $adapterDir
        Sync-Dir -Source (Join-Path $adapterDir ".codex\agents") -Dest (Join-Path $TargetRoot ".codex\agents") -Label "codex agents"
    }
    'antigravity' {
        Install-CommonKit -AdapterDir $adapterDir
        Sync-Dir -Source (Join-Path $adapterDir ".agents\rules") -Dest (Join-Path $TargetRoot ".agents\rules") -Label "antigravity rules"
        Copy-FileIfExists -Source (Join-Path $adapterDir "GEMINI.md") -Dest (Join-Path $TargetRoot "GEMINI.md") -Label "GEMINI.md"
    }
    'gemini-cli' {
        Install-CommonKit -AdapterDir $adapterDir
        Copy-FileIfExists -Source (Join-Path $adapterDir "GEMINI.md") -Dest (Join-Path $TargetRoot "GEMINI.md") -Label "GEMINI.md"
    }
    'amazon-q' {
        Install-CommonKit -AdapterDir $adapterDir
        Sync-Dir -Source (Join-Path $adapterDir ".amazonq\rules") -Dest (Join-Path $TargetRoot ".amazonq\rules") -Label "amazon-q rules"
    }
    'openclaw' {
        Install-CommonKit -AdapterDir $adapterDir
        Copy-FileIfExists -Source (Join-Path $adapterDir "SOUL.md") -Dest (Join-Path $TargetRoot "SOUL.md") -Label "SOUL.md"
    }
    'claude-code' {
        Install-CommonKit -AdapterDir $adapterDir
        Sync-Dir -Source (Join-Path $adapterDir ".claude\skills") -Dest (Join-Path $TargetRoot ".claude\skills") -Label "claude skills"
    }
    'windsurf' {
        Install-CommonKit -AdapterDir $adapterDir
        Sync-Dir -Source (Join-Path $adapterDir ".windsurf\skills") -Dest (Join-Path $TargetRoot ".windsurf\skills") -Label "windsurf skills"
        Write-Host "Note: add .windsurf/rules from cursor-rules (YAML trigger) — see ides/windsurf/README.md"
    }
    default {
        if (-not (Test-Path $adapterDir)) {
            Write-Error "Missing adapter folder $adapterDir — run scripts/build-ides.ps1 first"
        }
        Install-CommonKit -AdapterDir $adapterDir
    }
}

Write-Host ""
Write-Host "Done ($Ide). Full kit: rules/skills/MCP profiles/delegates. See IDE-PARITY.md and https://klarix.ai/harness/ides"
