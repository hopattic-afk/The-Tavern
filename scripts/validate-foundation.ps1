$ErrorActionPreference = 'Stop'

$required = @(
  'README.md', 'AGENTS.md', '.gitignore', '.env.example',
  'docs/PROJECT_BRIEF.md', 'docs/ROADMAP.md', 'docs/BRAND_BIBLE.md',
  'docs/CHARACTER_BIBLE.md', 'docs/VOICE_GUIDE.md', 'docs/MERCH_PLAN.md',
  'docs/CONTENT_PIPELINE.md', 'docs/TECHNICAL_ARCHITECTURE.md',
  'docs/IP_AND_PRIVACY_RULES.md', 'docs/LAUNCH_CHECKLIST.md',
  'docs/DECISION_LOG.md', 'docs/ASSET_RIGHTS_REGISTER.md',
  'content/README.md', 'public/README.md', 'founder-input/README.md',
  'founder-input/photos/PHOTO_INPUT_TEMPLATE.md',
  'founder-input/stories/STORY_INPUT_TEMPLATE.md',
  'founder-input/characters/CHARACTER_INPUT_TEMPLATE.md',
  'scripts/validate-founder-input.mjs', 'scripts/validate-founder-input.ps1',
  'components/README.md', 'scripts/validate-foundation.ps1'
  'scripts/validate-brand.ps1'
  'scripts/validate-characters.ps1'
  'scripts/validate-design.ps1'
  'docs/WEBSITE_DESIGN.md'
  'docs/ANALYTICS_PLAN.md'
)

$missing = $required | Where-Object { -not (Test-Path -LiteralPath $_) }
if ($missing) { throw "Missing required paths: $($missing -join ', ')" }

$trackedEnv = git ls-files | Where-Object { $_ -match '(^|/)\.env($|\.)' -and $_ -notmatch '\.env\.example$' }
if ($trackedEnv) { throw "Tracked environment files: $($trackedEnv -join ', ')" }

& (Join-Path $PSScriptRoot 'validate-founder-input.ps1')
if ($LASTEXITCODE -ne 0) { throw 'Founder-input validation failed.' }

$docs = Get-ChildItem -LiteralPath docs -Filter '*.md'
$empty = $docs | Where-Object { $_.Length -eq 0 }
if ($empty) { throw "Empty documents: $($empty.Name -join ', ')" }

$disclaimer = 'not affiliated with or endorsed by Kingshot or CenturyGames'
if (-not (Select-String -LiteralPath README.md, docs/IP_AND_PRIVACY_RULES.md -SimpleMatch $disclaimer)) {
  throw 'Required legal disclaimer is missing.'
}

Write-Host "Foundation validation passed: $($required.Count) required paths; $($docs.Count) documents."
