# GenSync Prospector installer (Windows / PowerShell)
# Copies the gensync skill pack into your Hermes skills directory.
$ErrorActionPreference = "Stop"

$home_dir = if ($env:HERMES_HOME) { $env:HERMES_HOME }
            elseif (Test-Path "$env:LOCALAPPDATA\hermes\skills") { "$env:LOCALAPPDATA\hermes" }
            else { "$HOME\.hermes" }

$dest = Join-Path $home_dir "skills\gensync"
$src  = Join-Path $PSScriptRoot "skills\gensync"

New-Item -ItemType Directory -Force -Path (Split-Path $dest) | Out-Null
Copy-Item -Recurse -Force -Path $src -Destination (Split-Path $dest)

Write-Host "Installed gensync skill pack to $dest" -ForegroundColor Green
Write-Host "Next: edit $dest\CONTEXT.md, then ask Hermes to 'run gensync-lead-scout'." -ForegroundColor Cyan
