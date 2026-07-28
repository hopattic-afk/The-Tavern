$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$matrixPath = Join-Path $root 'docs/launch-readiness-matrix.json'
$reportPath = Join-Path $root 'docs/LAUNCH_READINESS_REPORT.md'
$matrix = Get-Content $matrixPath -Raw | ConvertFrom-Json
$report = Get-Content $reportPath -Raw

if ($matrix.criteria.Count -ne 30) { throw 'Readiness matrix must cover all 30 Issue #10 criteria.' }
$expectedIds = 1..30 | ForEach-Object { 'I10-{0:d2}' -f $_ }
$actualIds = @($matrix.criteria.id)
if (($actualIds | Sort-Object -Unique).Count -ne 30) { throw 'Readiness criterion IDs must be unique.' }
foreach ($id in $expectedIds) { if ($actualIds -notcontains $id) { throw "Missing readiness criterion $id." } }

$weight = ($matrix.criteria | Measure-Object weight -Sum).Sum
$earned = ($matrix.criteria | Measure-Object earned -Sum).Sum
if ($weight -ne 100 -or $matrix.localPackageScore.possible -ne 100) { throw 'Readiness weights must total 100.' }
if ($earned -ne 48 -or $matrix.localPackageScore.earned -ne 48) { throw 'Readiness earned score must transparently total 48.' }
foreach ($criterion in $matrix.criteria) {
  if (@('verified','partial','blocked') -notcontains $criterion.status) { throw "Invalid status $($criterion.id)." }
  $expectedEarned = switch ($criterion.status) { 'verified' { $criterion.weight }; 'partial' { $criterion.weight / 2 }; 'blocked' { 0 } }
  if ($criterion.earned -ne $expectedEarned) { throw "Score mismatch $($criterion.id)." }
  if (-not $criterion.domain -or -not $criterion.evidenceDate -or -not $criterion.owner -or @($criterion.evidence).Count -lt 1) { throw "Incomplete evidence fields $($criterion.id)." }
  foreach ($path in $criterion.evidence) { if (-not (Test-Path (Join-Path $root $path))) { throw "Missing evidence path $path." } }
}
$truthCeilings = @{ 'I10-07' = 'blocked'; 'I10-08' = 'blocked'; 'I10-23' = 'blocked' }
foreach ($id in $truthCeilings.Keys) {
  $criterion = $matrix.criteria | Where-Object id -eq $id
  if ($criterion.status -ne $truthCeilings[$id]) { throw "Evidence ceiling changed for $id." }
}

if ($matrix.publicLaunchGate -cne 'NO-GO') { throw 'Public launch gate must remain exact NO-GO.' }
if ($matrix.criticalBlockers.Count -lt 1 -or $matrix.founderDecisions.Count -lt 3) { throw 'Blockers and founder decisions must remain explicit.' }
foreach ($id in $matrix.criticalBlockers) { if ($report -notmatch [regex]::Escape($id)) { throw "Missing blocker $id in report." } }
foreach ($id in $matrix.founderDecisions) { if ($report -notmatch [regex]::Escape($id)) { throw "Missing founder decision $id in report." } }

foreach ($heading in @('Launch-readiness score','Completed items','Critical blockers','Noncritical improvements','Founder decisions required','Public-launch procedure','Rollback procedure','First-week monitoring plan')) {
  if ($report -notmatch "(?m)^## $([regex]::Escape($heading))\r?$") { throw "Missing report section $heading." }
}
foreach ($required in @('Current decision: **NO-GO**','FD-06, FD-07 and FD-08 are separate','Rollback drill evidence remains **TBD**','Privacy-safe log template','sandboxed npm execution fails with `EPERM`')) {
  if (-not $report.Contains($required)) { throw "Missing readiness control: $required" }
}
if ($report -match '(?i)public launch (is )?(approved|authorized|ready|go)') { throw 'False public-launch approval detected.' }
if (@($matrix.criteria | Where-Object status -eq 'blocked').Count -lt 1) { throw 'Readiness must retain blocked criteria.' }

Write-Host 'Readiness validation passed: 30 criteria, 48/100 arithmetic, critical overlay, NO-GO, blockers, founder decisions, launch/rollback/monitoring controls.'
