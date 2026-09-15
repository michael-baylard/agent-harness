# Verify config/team-policy.yaml against docs/team-policy-layer.md
# Usage (from agent-harness repo root): pwsh -File scripts/verify-team-policy.ps1

$ErrorActionPreference = "Stop"
$Root = Split-Path $PSScriptRoot -Parent
$PolicyPath = Join-Path $Root "config\team-policy.yaml"

if (-not (Test-Path $PolicyPath)) {
    Write-Error "Missing $PolicyPath"
    exit 1
}

$raw = Get-Content -Path $PolicyPath -Raw

$ciKeys = @("ci_retainer", "ci_monthly", "2997", "4997", "8997", "starter_monthly", "growth_monthly", "scale_monthly")
foreach ($key in $ciKeys) {
    if ($raw -match [regex]::Escape($key)) {
        Write-Error "CI-retainer key '$key' is not allowed in team-policy.yaml"
        exit 1
    }
}

function Get-YamlScalar([string]$text, [string]$key) {
    if ($text -match "(?m)^\s*$([regex]::Escape($key)):\s*(.+?)\s*$") {
        return $Matches[1].Trim()
    }
    return $null
}

$seats = [int](Get-YamlScalar $raw "seats")
if ($seats -notin 5, 15) {
    Write-Error "seats must be 5 or 15 (got $seats)"
    exit 1
}

$maxServers = [int](Get-YamlScalar $raw "max_servers")
if ($maxServers -gt 6) {
    Write-Error "mcp.max_servers must be <= 6 (got $maxServers)"
    exit 1
}

$tokenOnly = @("sqz", "tracepulse")
$profileCap = if ($seats -eq 5) { 4 } else { 8 }
$profileBlock = if ($raw -match "(?s)profiles:\s*(.+?)(?:\r?\npath_write:|\z)") { $Matches[1] } else { "" }
$profileNames = [regex]::Matches($profileBlock, "(?m)^\s{2,4}([A-Za-z0-9_-]+):\s*\[") | ForEach-Object { $_.Groups[1].Value }
if ($profileNames.Count -gt $profileCap) {
    Write-Error "SKU seats=$seats allows <= $profileCap profiles (got $($profileNames.Count))"
    exit 1
}

$serverLists = [regex]::Matches($profileBlock, "\[([^\]]+)\]")
foreach ($m in $serverLists) {
    $rawNames = $m.Groups[1].Value.Split(",") | ForEach-Object { $_.Trim().Trim("'").Trim('"') } | Where-Object { $_ }
    foreach ($n in $rawNames) {
        if ($n -cne $n.ToLowerInvariant()) {
            Write-Error "MCP names must be lowercase (got $n). Align with config/mcp-profiles/."
            exit 1
        }
    }
    $names = $rawNames | ForEach-Object { $_.ToLowerInvariant() }
    $billable = $names | Where-Object { $tokenOnly -notcontains $_ }
    if ($billable.Count -gt 6) {
        Write-Error "Profile exceeds 6 MCP servers (excluding sqz/tracepulse): $($billable -join ', ')"
        exit 1
    }
}

foreach ($must in @(".env*", "credentials*", "*.pem")) {
    if ($raw -notmatch [regex]::Escape($must)) {
        Write-Error "path_deny must cover $must"
        exit 1
    }
}

Write-Host "team-policy.yaml OK (seats=$seats profiles=$($profileNames.Count) cap=$profileCap)"
exit 0
