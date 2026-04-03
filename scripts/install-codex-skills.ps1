param(
  [string]$Target = ""
)

$ErrorActionPreference = "Stop"

$RepoRoot = Split-Path -Parent $PSScriptRoot
$SourceRoot = Join-Path $RepoRoot ".codex\skills"

if (-not (Test-Path $SourceRoot)) {
  throw "Repo skill source not found: $SourceRoot"
}

if (-not $Target) {
  if ($env:CODEX_HOME) {
    $Target = Join-Path $env:CODEX_HOME "skills"
  } else {
    $Target = Join-Path $HOME ".codex\skills"
  }
}

New-Item -ItemType Directory -Path $Target -Force | Out-Null

$SkillDirs = Get-ChildItem -LiteralPath $SourceRoot -Directory
foreach ($SkillDir in $SkillDirs) {
  $Destination = Join-Path $Target $SkillDir.Name
  if (Test-Path $Destination) {
    Remove-Item -LiteralPath $Destination -Recurse -Force
  }
  Copy-Item -LiteralPath $SkillDir.FullName -Destination $Destination -Recurse -Force
  Write-Host "Installed skill: $($SkillDir.Name) -> $Destination"
}

Write-Host ""
Write-Host "Codex skills installed successfully."
Write-Host "Source: $SourceRoot"
Write-Host "Target: $Target"