$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$required = @('package.json','astro.config.mjs','netlify.toml','src/pages/index.astro','src/pages/shop/index.astro','src/pages/shop/[slug].astro','src/pages/tavern-tales/index.astro','src/pages/tavern-tales/[slug].astro','src/pages/trash-pandas/index.astro','src/pages/trash-pandas/[slug].astro','src/pages/about/index.astro','src/pages/about/ale.astro','src/pages/submit.astro','src/pages/faq.astro','src/pages/contact.astro','src/pages/shipping.astro','src/pages/returns.astro','src/pages/privacy.astro','src/pages/terms.astro','src/pages/404.astro','docs/SITE_OPERATIONS.md')
$missing = $required | Where-Object { -not (Test-Path -LiteralPath (Join-Path $root $_)) }
if ($missing) { throw "Missing site files: $($missing -join ', ')" }
$sourceFiles = Get-ChildItem -LiteralPath (Join-Path $root 'src') -Recurse -File
$source = ($sourceFiles | Get-Content -Raw) -join "`n"
$css = Get-Content -LiteralPath (Join-Path $root 'src/styles/global.css') -Raw
if ($css -notmatch 'img\s*\{[^}]*max-width:\s*100%[^}]*height:\s*auto[^}]*\}') { throw 'Global intrinsic responsive-image constraint is missing; wide media may overflow at 320px.' }
$disclaimer = 'An unofficial player-community project. The Tavern and ALE are not affiliated with or endorsed by Kingshot or CenturyGames.'
if ($source -notlike "*$disclaimer*") { throw 'Exact disclaimer missing from site source.' }
if ($source -match '<form\b|type=["'']submit|<input[^>]+(?:card|payment|cc-)') { throw 'Submit-capable or payment form detected.' }
if ($source -match 'Kingshot[^\r\n]*(?:logo|screenshot|asset)') { throw 'Potential protected-asset reference detected.' }
if ($source -notmatch 'srcset=') { throw 'Responsive image sources are missing.' }
if ($source -match '/images/(?:steve-hero|merch-direction)-v1\.png') { throw 'Unoptimized website image reference detected.' }
$netlify = Get-Content -LiteralPath (Join-Path $root 'netlify.toml') -Raw
foreach ($header in @('Content-Security-Policy','X-Robots-Tag','Permissions-Policy')) { if ($netlify -notlike "*$header*") { throw "Missing header: $header" } }
if ((Get-Content -LiteralPath (Join-Path $root '.env.example') -Raw) -match '=\S+') { throw '.env.example contains a value.' }
$dist = Join-Path $root 'dist'
if (Test-Path -LiteralPath $dist) {
  $built = @('index.html','shop/index.html','tavern-tales/index.html','trash-pandas/index.html','trash-pandas/bramble-bung/index.html','about/index.html','about/ale/index.html','submit/index.html','faq/index.html','contact/index.html','shipping/index.html','returns/index.html','privacy/index.html','terms/index.html','404.html')
  $missingBuilt = $built | Where-Object { -not (Test-Path -LiteralPath (Join-Path $dist $_)) }
  if ($missingBuilt) { throw "Missing built routes: $($missingBuilt -join ', ')" }
  $htmlFiles = Get-ChildItem -LiteralPath $dist -Filter '*.html' -Recurse
  foreach ($file in $htmlFiles) {
    $html = Get-Content -LiteralPath $file.FullName -Raw
    foreach ($requiredMeta in @('<meta name="description"','<meta property="og:title"','<meta property="og:description"','<link rel="canonical"')) { if ($html -notlike "*$requiredMeta*") { throw "$requiredMeta missing from $($file.FullName)" } }
    if ($html -match '<script\b') { throw "Unexpected client script in $($file.FullName)" }
  }
  $lazyCount = ($htmlFiles | Select-String -Pattern 'loading="lazy"' -ErrorAction SilentlyContinue).Count
  if ($lazyCount -lt 1) { throw 'No lazy-loaded below-fold image found in build.' }
  $otherCharacterRoutes = Get-ChildItem -LiteralPath (Join-Path $dist 'trash-pandas') -Directory | Where-Object Name -ne 'bramble-bung'
  if ($otherCharacterRoutes) { throw "Deferred character routes were built: $($otherCharacterRoutes.Name -join ', ')" }
}
Write-Host "Site validation passed: $($required.Count) required files, built routes/metadata/zero hydration, fail-closed forms/commerce, disclaimer, headers, and env safety."
