$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

& node (Join-Path $PSScriptRoot 'validate-founder-input.mjs')
if ($LASTEXITCODE -ne 0) { throw 'Founder-input path validation failed.' }
