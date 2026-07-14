$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$dir = Join-Path $root 'social'
$campaign = Get-Content (Join-Path $dir 'campaign.json') -Raw | ConvertFrom-Json
$copy = Get-Content (Join-Path $dir 'copy.json') -Raw | ConvertFrom-Json
$platforms = Get-Content (Join-Path $dir 'platforms.json') -Raw | ConvertFrom-Json
$ledger = @(Import-Csv (Join-Path $dir 'review-ledger.csv'))

if ($campaign.days.Count -ne 30) { throw 'Calendar must contain 30 days.' }
if (($campaign.days.day | Sort-Object -Unique).Count -ne 30) { throw 'Calendar days must be unique.' }
if ($campaign.publicationAuthorized -ne $false -or $campaign.scheduleId -or $campaign.accountIds) { throw 'Publication gate changed.' }
if (@($campaign.days | Where-Object status -ne 'draft').Count) { throw 'Every campaign item must remain draft.' }

$week = @($campaign.days | Where-Object day -le 7)
foreach ($category in @('brand-introduction','lead-character-introduction','merchandise-preview','incident-desk-closed-invitation')) {
  if ($week.category -notcontains $category) { throw "Launch week missing $category." }
}
if (@($week | Where-Object category -eq 'animated-skit').Count -ne 3) { throw 'Launch week needs three skit candidates.' }
$incident = $week | Where-Object category -eq 'incident-desk-closed-invitation'
if ($incident.asset -ne 'NO_COLLECTION' -or $incident.dependency -notmatch 'NO COLLECTION') { throw 'Incident desk must remain closed.' }

foreach ($pair in @(@('hooks',20),@('captions',20),@('prompts',10),@('responses',10),@('merchCrossovers',5))) {
  $items = @($copy.($pair[0]))
  $serialized = @($items | ForEach-Object { $_ | ConvertTo-Json -Compress })
  if ($items.Count -ne $pair[1] -or ($serialized | Sort-Object -Unique).Count -ne $items.Count) { throw "Invalid $($pair[0]) count or uniqueness." }
}

if ($platforms.publicationAuthorized -ne $false -or $platforms.linkInBio.status -ne 'blocked') { throw 'Platform gate changed.' }
if (@($platforms.linkInBio.links | Where-Object url).Count) { throw 'Live link-in-bio URL detected.' }
if ($platforms.skitPackages.Count -ne 3 -or (($platforms.skitPackages.id | Sort-Object) -join ',') -ne 'SOC-S01,SOC-S02,SOC-S07') { throw 'Invalid skit package set.' }
foreach ($package in $platforms.skitPackages) {
  if (-not (Test-Path (Join-Path $root $package.source)) -or $package.status -ne 'draft') { throw "Invalid skit package $($package.id)." }
}

$reviewFields = @('copy_review','ip_review','privacy_review','rights_review','a11y_review','format_review','dependency_review','sentinel_review','founder_review')
$allowedReviewStates = @('pending','blocked')
$expectedLedgerKeys = @(
  foreach ($id in $campaign.days.id) {
    foreach ($platform in @('TikTok','Instagram','YouTube')) { "$id|$platform" }
  }
)
$actualLedgerKeys = @($ledger | ForEach-Object { "$($_.campaign_id)|$($_.platform)" })
if ($ledger.Count -ne 90) { throw 'Review ledger must contain exactly 90 records.' }
if (($actualLedgerKeys | Sort-Object -Unique).Count -ne $actualLedgerKeys.Count) { throw 'Review ledger campaign/platform records must be unique.' }
$missingLedgerKeys = @($expectedLedgerKeys | Where-Object { $actualLedgerKeys -notcontains $_ })
$extraLedgerKeys = @($actualLedgerKeys | Where-Object { $expectedLedgerKeys -notcontains $_ })
if ($missingLedgerKeys.Count -or $extraLedgerKeys.Count) { throw 'Review ledger must exactly cover every campaign ID on TikTok, Instagram and YouTube.' }
foreach ($record in $ledger) {
  foreach ($field in $reviewFields) {
    if ($allowedReviewStates -notcontains $record.$field) { throw "Review ledger field $field for $($record.campaign_id)/$($record.platform) is not fail-closed." }
  }
}
$prohibitedStates = @('approved','cleared','complete','completed','passed','ready')
foreach ($record in $ledger) {
  foreach ($field in $reviewFields) {
    if ($prohibitedStates -contains $record.$field.ToLowerInvariant()) { throw "Cleared review state detected for $($record.campaign_id)/$($record.platform)." }
  }
}

$text = (Get-ChildItem $dir -Recurse -File -Exclude CHECKSUMS.sha256 | Get-Content -Raw) -join "`n"
if ($text.Contains('https://')) { throw 'Live URL detected.' }
if ($text.Contains('token=') -or $text.Contains('secret=') -or $text.Contains('password=')) { throw 'Token-like value detected.' }
$disclaimer = 'An unofficial player-community project. The Tavern and ALE are not affiliated with or endorsed by Kingshot or CenturyGames.'
if (@($platforms.bios.psobject.Properties.Value.full | Where-Object { $_ -like "*$disclaimer*" }).Count -lt 1) { throw 'Exact disclaimer missing.' }

foreach ($line in (Get-Content (Join-Path $dir 'CHECKSUMS.sha256'))) {
  if ($line -notmatch '^([0-9a-f]{64})  (.+)$') { throw 'Bad checksum line.' }
  $actual = (Get-FileHash -Algorithm SHA256 (Join-Path $root $Matches[2])).Hash.ToLower()
  if ($actual -ne $Matches[1]) { throw "Checksum mismatch $($Matches[2])." }
}
$rights = Get-Content (Join-Path $root 'docs/ASSET_RIGHTS_REGISTER.md') -Raw
foreach ($id in @('SOCIAL-ASSET-001','SOCIAL-COPY-001')) { if ($rights -notmatch $id) { throw "Missing rights $id." } }
Write-Host 'Social validation passed: 30 days, 90 fail-closed platform review records, launch week, copy counts, platforms/links, disclaimer, rights, and checksums.'
