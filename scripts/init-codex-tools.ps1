param(
  [Parameter(Mandatory = $true)]
  [string]$Target,
  [switch]$InstallSkills
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $PSScriptRoot
$SourceRoot = Join-Path $RepoRoot ".codex"
if (-not (Test-Path $SourceRoot)) {
  throw "Source .codex directory not found: $SourceRoot"
}

$Target = (Resolve-Path $Target).Path
$TargetCodex = Join-Path $Target ".codex"
New-Item -ItemType Directory -Path $TargetCodex -Force | Out-Null

foreach ($name in @('commands','subagents','skill-specs','hooks','skills')) {
  $src = Join-Path $SourceRoot $name
  if (Test-Path $src) {
    $dst = Join-Path $TargetCodex $name
    if (Test-Path $dst) { Remove-Item -LiteralPath $dst -Recurse -Force }
    Copy-Item -LiteralPath $src -Destination $dst -Recurse -Force
    Write-Host "Synced: $name"
  }
}

$settings = Join-Path $SourceRoot 'settings.json'
if (Test-Path $settings) {
  Copy-Item -LiteralPath $settings -Destination (Join-Path $TargetCodex 'settings.json') -Force
  Write-Host 'Synced: settings.json'
}

if ($InstallSkills) {
  & (Join-Path $PSScriptRoot 'install-codex-skills.ps1')
}

Write-Host ''
Write-Host 'Codex tool assets initialized successfully.'
Write-Host "Target: $TargetCodex"