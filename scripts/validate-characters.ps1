$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$data = Get-Content -Raw -LiteralPath (Join-Path $root 'content/characters/characters.json') | ConvertFrom-Json
if ($data.status -ne 'steve-selected-private' -or $data.remainingRosterStatus -ne 'archived-pending-founder-imagery' -or $data.publicCommercialUse -ne 'blocked' -or -not $data.mascotSelected) { throw 'Expected Steve selected privately, the remaining roster archived, and public/commercial use blocked.' }
if ($data.characters.Count -ne 7) { throw 'Exactly seven characters required.' }
$required = @('id','name','role','personality','appearance','silhouette','clothing','armor','accent','expressions','speech','strength','weakness','prop','runningJoke','catchphrase','relationships','poses','skits','merch','modelSheet','mascot')
$unique = @('id','name','role','silhouette','prop','catchphrase')
foreach ($field in $unique) { $values = $data.characters.$field; if (($values | Sort-Object -Unique).Count -ne 7) { throw "Character field must be unique: $field" } }
$rights = Get-Content -Raw -LiteralPath (Join-Path $root 'docs/ASSET_RIGHTS_REGISTER.md')
$weightsTotal = ($data.scoreWeights.PSObject.Properties.Value | Measure-Object -Sum).Sum
if ($weightsTotal -ne 100) { throw "Mascot weights total $weightsTotal, expected 100." }
$specificMarkers = @{
  'bramble-bung'='crooked-apron'; 'rook-rattleplate'='oversized-shoulder-plate';
  'tansy-tallytail'='three-pouches'; 'muddle-quill'='long-scarf';
  'vellum-sip'='split-coat'; 'pip-kindling'='oversized-hood';
  'drowse-coalpaw'='drooping-cap'
}
foreach ($c in $data.characters) {
  foreach ($field in $required) { if ($null -eq $c.$field -or [string]::IsNullOrWhiteSpace([string]$c.$field)) { throw "$($c.id) missing $field" } }
  if ($c.expressions.Count -lt 6 -or $c.poses.Count -lt 3) { throw "$($c.id) lacks expression/pose evidence." }
  if ($c.skits.Count -ne 3 -or $c.merch.Count -ne 3) { throw "$($c.id) must have exactly 3 skits and 3 merch concepts." }
  $sum = ($c.mascot.PSObject.Properties | Where-Object Name -ne 'total' | ForEach-Object Value | Measure-Object -Sum).Sum
  if ($sum -ne $c.mascot.total) { throw "$($c.id) mascot arithmetic mismatch: $sum vs $($c.mascot.total)" }
  $max = @{silhouette=25;roleBreadth=20;animation=15;merchandise=15;expression=10;originality=10;clarity=5}
  foreach ($key in $max.Keys) { if ($c.mascot.$key -gt $max[$key] -or $c.mascot.$key -lt 0) { throw "$($c.id) invalid $key score." } }
  $sheet = Join-Path $root $c.modelSheet
  if (-not (Test-Path -LiteralPath $sheet)) { throw "$($c.id) modelSheet reference missing." }
  [xml]$svg = Get-Content -Raw -LiteralPath $sheet
  foreach ($group in @('turnaround-front','turnaround-side','working-pose','reaction-pose','expression-eyes','expression-mouth','prop-layer')) {
    if (-not $svg.SelectSingleNode("//*[@id='$group']")) { throw "$($c.id) sheet missing layer/group $group" }
  }
  foreach ($expression in @('expression-neutral','expression-confident','expression-alarmed','expression-delighted','expression-exhausted','expression-suspicious')) {
    if (-not $svg.SelectSingleNode("//*[@id='$expression']")) { throw "$($c.id) sheet missing $expression" }
  }
  if (-not $svg.SelectSingleNode("//*[@id='$($specificMarkers[$c.id])']")) { throw "$($c.id) sheet missing character-specific clothing marker." }
  if (-not $svg.SelectSingleNode("//*[@id='$($c.prop)']")) { throw "$($c.id) sheet missing signature prop marker $($c.prop)." }
  if ($rights -notmatch [regex]::Escape($c.id)) { throw "$($c.id) missing rights-row coverage." }
}
$top = $data.characters | Sort-Object { $_.mascot.total } -Descending | Select-Object -First 1
if ($top.id -ne $data.mascotRecommendation.id -or $top.mascot.total -ne $data.mascotRecommendation.score -or -not $data.mascotRecommendation.selected -or $data.mascotRecommendation.displayName -ne 'Steve') { throw 'Mascot recommendation/selection state invalid.' }
if (($data.characters.mascot.total | Sort-Object -Unique).Count -ne 7) { throw 'Mascot totals must be distinct for deterministic ranking.' }
$bible = Get-Content -Raw -LiteralPath (Join-Path $root 'docs/CHARACTER_BIBLE.md')
foreach ($c in $data.characters) { if ($bible -notmatch [regex]::Escape($c.name)) { throw "Bible missing $($c.name)" } }
if ($bible -notmatch 'public/commercial use remains BLOCKED') { throw 'Blocking gate missing.' }
Write-Host 'Character validation passed: Steve selected privately, remaining records archived, gates retained, scorecards and production evidence valid.'
