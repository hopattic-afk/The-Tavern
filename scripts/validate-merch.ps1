$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$drop = Join-Path $root 'merch/drop-01'
foreach ($path in @('concepts.json','products.json','pricing-scenarios.csv','production-manifest.json','SAMPLE_QA.md','CHECKSUMS.sha256')) { if (-not (Test-Path -LiteralPath (Join-Path $drop $path))) { throw "Missing Drop 01 file: $path" } }
$data = Get-Content -LiteralPath (Join-Path $drop 'concepts.json') -Raw | ConvertFrom-Json
if ($data.concepts.Count -ne 10) { throw "Expected exactly 10 concepts; found $($data.concepts.Count)." }
if (($data.concepts | Where-Object refined).Count -ne 5) { throw 'Expected exactly 5 refined concepts.' }
$tieBreak = @($data.refinementPolicy.tieBreakOrder)
if (-not $data.refinementPolicy.rule -or $tieBreak.Count -ne $data.concepts.Count -or ($tieBreak | Sort-Object -Unique).Count -ne $data.concepts.Count) { throw 'Refinement policy must declare a complete unique tie-break order.' }
$rank = @{}; for ($index=0; $index -lt $tieBreak.Count; $index++) { $rank[$tieBreak[$index]] = $index }
$expectedRefined = @($data.concepts | Sort-Object @{Expression={$_.score.total};Descending=$true}, @{Expression={$rank[$_.id]};Ascending=$true} | Select-Object -First 5 | ForEach-Object id | Sort-Object)
$actualRefined = @($data.concepts | Where-Object refined | ForEach-Object id | Sort-Object)
if (($expectedRefined -join ',') -ne ($actualRefined -join ',')) { throw "Refined set must follow score/tie-break ranking. Expected $($expectedRefined -join ','); found $($actualRefined -join ',')." }
$selected = @($data.concepts | Where-Object selected)
if ($selected.Count -ne 3) { throw 'Expected exactly 3 selected concepts.' }
if ($data.productTypes.Count -gt 4 -or $data.productTypes.Count -lt 1) { throw 'Drop 01 must use 1-4 product types.' }
if (($data.productTypes | Sort-Object -Unique).Count -ne $data.productTypes.Count) { throw 'Product types must be unique.' }
$weightNames = @('brandFit','originalitySafety','smallSize','reproducibility','productBreadth','backgroundBehavior','audienceClarity','unitEconomicsRisk')
$weightTotal = 0; foreach ($name in $weightNames) { $weightTotal += $data.scoreWeights.$name }
if ($weightTotal -ne 100) { throw "Score weights must total 100; found $weightTotal." }
$ids = @(); foreach ($concept in $data.concepts) {
  if ($ids -contains $concept.id) { throw "Duplicate concept ID: $($concept.id)" }; $ids += $concept.id
  $total = 0; foreach ($name in $weightNames) { $value = $concept.score.$name; if ($value -lt 0 -or $value -gt $data.scoreWeights.$name) { throw "$($concept.id) invalid $name score." }; $total += $value }
  if ($total -ne $concept.score.total) { throw "$($concept.id) score arithmetic mismatch." }
  foreach ($product in $concept.products) { if ($data.productTypes -notcontains $product) { throw "$($concept.id) uses unapproved product type $product." } }
  if (-not $concept.rights -or -not $concept.dependency -or -not $concept.focalIdea) { throw "$($concept.id) lacks rights, dependency or focal idea." }
}
$products = Get-Content -LiteralPath (Join-Path $drop 'products.json') -Raw | ConvertFrom-Json
if ($products.products.Count -ne $data.productTypes.Count) { throw 'Product record count must match selected product types.' }
foreach ($product in $products.products) {
  if ($data.productTypes -notcontains $product.type) { throw "Unknown product record: $($product.type)" }
  foreach ($design in $product.designs) { if ($selected.id -notcontains $design) { throw "$($product.type) uses non-selected design $design." } }
  foreach ($field in @('size','care','baseCost','salePrice','margin','production','shipping')) { if ([string]$product.$field -notmatch 'TBD|vendor') { throw "$($product.type).$field must remain explicit TBD/vendor-dependent." } }
}
foreach ($design in $selected) {
  $files = Get-ChildItem -LiteralPath (Join-Path $drop 'art') -Filter "$($design.id)-*.svg"
  if ($files.Count -ne 3) { throw "$($design.id) needs exactly dark, light and one-color SVG variants." }
  foreach ($variant in @('dark','light','one-color')) { if (-not ($files.Name -match "-$variant\.svg$")) { throw "$($design.id) missing $variant variant." } }
  foreach ($file in $files) { $svg = Get-Content -LiteralPath $file.FullName -Raw; if ($svg -notmatch '<title>') { throw "$($file.Name) lacks title." }; if ($svg -match '<text\b|(?:href|src)=["'']https?://|Kingshot|CenturyGames') { throw "$($file.Name) contains font text, external reference, or protected name." } }
}
$mockups = Get-ChildItem -LiteralPath (Join-Path $drop 'mockups') -Filter '*.svg'
if ($mockups.Count -ne 3) { throw 'Expected exactly 3 selected-design mockups.' }
foreach ($mockup in $mockups) { if ((Get-Content -LiteralPath $mockup.FullName -Raw) -notmatch 'NOT FOR SALE — PROVISIONAL') { throw "$($mockup.Name) lacks provisional label." } }
$manifest = Get-Content -LiteralPath (Join-Path $drop 'production-manifest.json') -Raw | ConvertFrom-Json
if ($manifest.targetRasterDpi -ne 300 -or $manifest.status -ne 'production-candidate-not-print-ready') { throw 'Manifest must retain conservative 300-DPI candidate status.' }
if ($manifest.vendorDimensions -notmatch 'TBD') { throw 'Vendor dimensions must remain TBD.' }
if (@($manifest.exports | Where-Object rasterExport -ne 'blocked').Count -ne 0) { throw 'Raster exports must remain blocked until vendor specifications exist.' }
$pricing = Get-Content -LiteralPath (Join-Path $drop 'pricing-scenarios.csv') -Raw
if ($pricing -match '(?m)^template,[^,]+,[A-Z]{3},\d') { throw 'Pricing template contains an invented currency/price.' }
if ($pricing -notmatch 'unit_margin,margin_percent' -or $pricing -notmatch '=IF\(') { throw 'Pricing formulas are missing.' }
$checksumLines = Get-Content -LiteralPath (Join-Path $drop 'CHECKSUMS.sha256') | Where-Object { $_.Trim() }
foreach ($line in $checksumLines) { if ($line -notmatch '^([0-9a-f]{64})  (.+)$') { throw "Invalid checksum line: $line" }; $expected=$Matches[1]; $relative=$Matches[2]; $actual=(Get-FileHash -Algorithm SHA256 -LiteralPath (Join-Path $root $relative)).Hash.ToLower(); if ($actual -ne $expected) { throw "Checksum mismatch: $relative" } }
$rights = Get-Content -LiteralPath (Join-Path $root 'docs/ASSET_RIGHTS_REGISTER.md') -Raw
foreach ($id in @('MERCH-D01','MERCH-D02','MERCH-D03','MERCH-D04-D10')) { if ($rights -notmatch [regex]::Escape($id)) { throw "Missing rights row $id." } }
Write-Host 'Merch validation passed: 10 concepts, 5 refined, 3 selected, 4 product types, 9 art variants, 3 provisional mockups, pricing/production gates, checksums, and rights coverage.'
