# Fail if ides/ is stale vs a fresh build-ides run.
# Usage: pwsh -File scripts/verify-ides-parity.ps1

$ErrorActionPreference = "Stop"
$Root = Split-Path $PSScriptRoot -Parent
$scratch = Join-Path $env:TEMP "agent-harness-ides-verify-$(Get-Random)"

Write-Host "Building fresh ides/ into scratch: $scratch"
Copy-Item -Path $Root -Destination $scratch -Recurse -Exclude @(".git", "node_modules", ".scratch")

Push-Location $scratch
try {
    & pwsh -NoProfile -File (Join-Path $scratch "scripts\build-ides.ps1")
    if ($LASTEXITCODE -ne 0) { throw "build-ides.ps1 failed" }

    $liveIdes = Join-Path $Root "ides"
    $freshIdes = Join-Path $scratch "ides"

    function Get-FileHashMap {
        param([string]$Base)
        $map = @{}
        if (-not (Test-Path $Base)) { return $map }
        Get-ChildItem -Path $Base -Recurse -File | ForEach-Object {
            $rel = $_.FullName.Substring($Base.Length).TrimStart('\', '/')
            $map[$rel] = (Get-FileHash $_.FullName -Algorithm SHA256).Hash
        }
        return $map
    }

    $live = Get-FileHashMap $liveIdes
    $fresh = Get-FileHashMap $freshIdes

    $missing = @()
    $extra = @()
    $diff = @()

    foreach ($key in $fresh.Keys) {
        if (-not $live.ContainsKey($key)) { $missing += $key }
        elseif ($live[$key] -ne $fresh[$key]) { $diff += $key }
    }
    foreach ($key in $live.Keys) {
        if (-not $fresh.ContainsKey($key)) { $extra += $key }
    }

    if ($missing.Count -eq 0 -and $extra.Count -eq 0 -and $diff.Count -eq 0) {
        Write-Host "OK — ides/ matches build-ides output."
        exit 0
    }

    Write-Error "ides/ parity drift detected. Run: pwsh -File scripts/build-ides.ps1"
    if ($diff.Count) { Write-Host "Changed:"; $diff | ForEach-Object { Write-Host "  $_" } }
    if ($missing.Count) { Write-Host "Missing in repo:"; $missing | ForEach-Object { Write-Host "  $_" } }
    if ($extra.Count) { Write-Host "Extra in repo:"; $extra | ForEach-Object { Write-Host "  $_" } }
    exit 1
}
finally {
    Pop-Location
    if (Test-Path $scratch) { Remove-Item -Recurse -Force $scratch }
}
