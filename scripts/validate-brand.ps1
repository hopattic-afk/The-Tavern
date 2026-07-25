$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$required = @(
  'public/brand/tokens.json', 'public/brand/tokens.css',
  'public/brand/concepts/direction-a-noticeboard.svg',
  'public/brand/concepts/direction-b-tankard.svg',
  'public/brand/concepts/direction-c-dumpster-lid.svg',
  'public/brand/recommended/wordmark.svg',
  'public/brand/recommended/simplified-mark.svg',
  'public/brand/recommended/favicon.svg',
  'public/brand/recommended/social-safe.svg'
)
foreach ($path in $required) {
  if (-not (Test-Path -LiteralPath (Join-Path $root $path))) { throw "Missing brand file: $path" }
}

$tokensPath = Join-Path $root 'public/brand/tokens.json'
$tokens = Get-Content -Raw -LiteralPath $tokensPath | ConvertFrom-Json
$expected = @('soot-950','soot-800','parchment-100','parchment-50','ale-gold-500','dumpster-green-500','ember-500','ink-900')
foreach ($name in $expected) {
  if (-not $tokens.color.PSObject.Properties.Name.Contains($name)) { throw "Missing color token: $name" }
}

function Get-Luminance([string]$hex) {
  $rgb = 1,3,5 | ForEach-Object { [Convert]::ToInt32($hex.Substring($_,2),16) / 255 }
  $linear = $rgb | ForEach-Object { if ($_ -le 0.04045) { $_ / 12.92 } else { [Math]::Pow(($_ + 0.055) / 1.055, 2.4) } }
  return 0.2126*$linear[0] + 0.7152*$linear[1] + 0.0722*$linear[2]
}
function Get-Contrast([string]$a, [string]$b) {
  $x = Get-Luminance $a; $y = Get-Luminance $b
  return ([Math]::Max($x,$y)+0.05)/([Math]::Min($x,$y)+0.05)
}
$pairs = @(
  @('parchment-50','soot-950',7), @('parchment-100','soot-950',7),
  @('ale-gold-500','soot-950',7), @('ink-900','parchment-50',7),
  @('ink-900','parchment-100',7), @('dumpster-green-500','soot-950',3),
  @('ember-500','soot-950',3)
)
foreach ($pair in $pairs) {
  $ratio = Get-Contrast $tokens.color.($pair[0]).'$value' $tokens.color.($pair[1]).'$value'
  if ($ratio -lt [double]$pair[2]) { throw "Contrast failed: $($pair[0]) / $($pair[1]) = $ratio" }
  Write-Host ("{0} / {1}: {2:N2}:1" -f $pair[0],$pair[1],$ratio)
}

Get-ChildItem -LiteralPath (Join-Path $root 'public/brand') -Recurse -Filter '*.svg' | ForEach-Object {
  [xml]$svg = Get-Content -Raw -LiteralPath $_.FullName
  if ($svg.svg.viewBox -eq $null) { throw "SVG lacks viewBox: $($_.FullName)" }
  if (-not $svg.svg.title) { throw "SVG lacks title: $($_.FullName)" }
}
Write-Host "Brand validation passed: $($required.Count) files and $($pairs.Count) contrast pairs."
