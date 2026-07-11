$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$routes=Get-Content -Raw (Join-Path $root 'design/routes.json')|ConvertFrom-Json
$components=Get-Content -Raw (Join-Path $root 'design/components.json')|ConvertFrom-Json
$events=Get-Content -Raw (Join-Path $root 'design/events.json')|ConvertFrom-Json
$requiredRoutes=@('/','/shop','/shop/[slug]','/tavern-tales','/tavern-tales/[slug]','/trash-pandas','/trash-pandas/[slug]','/about','/about/ale','/submit','/faq','/contact','/shipping','/returns','/privacy','/terms','/404')
foreach($route in $requiredRoutes){if($routes.routes -notcontains $route){throw "Missing route: $route"}}
if($routes.incidentCollection -or $routes.integrations){throw 'Collection/integrations must remain false.'}
$requiredComponents=@('FooterDisclaimer','FourthwallHandoff','IncidentFormDisabled','ValidationSummary','CaptionedVideo','Transcript','EmptyState','ErrorState','LoadingSkeleton')
foreach($name in $requiredComponents){if($components.components -notcontains $name){throw "Missing component: $name"}}
if($events.active){throw 'Analytics must remain inactive.'}
if(($events.events|Sort-Object -Unique).Count -ne $events.events.Count){throw 'Duplicate events.'}
if(($routes.routes|Sort-Object -Unique).Count -ne 17 -or ($components.components|Sort-Object -Unique).Count -ne 28 -or ($events.events|Sort-Object -Unique).Count -ne 13){throw 'Route/component/event parity changed.'}
foreach($property in @('free_text','email','member_id','coordinates','payment_data','private_content')){if($events.prohibited -notcontains $property){throw "Missing prohibited analytics property: $property"}}
foreach($path in @('docs/WEBSITE_DESIGN.md','docs/ANALYTICS_PLAN.md','design/wireframes/mobile-all-pages.svg','design/wireframes/desktop-all-pages.svg')){if(-not(Test-Path (Join-Path $root $path))){throw "Missing design evidence: $path"}}
Get-ChildItem (Join-Path $root 'design/wireframes') -Filter '*.svg'|ForEach-Object{[xml]$svg=Get-Content -Raw $_.FullName;if(-not $svg.svg.title -or -not $svg.svg.viewBox){throw "Invalid wireframe SVG: $($_.Name)"}}
$templates=@('listing-template','commerce-detail-template','tale-detail-template','character-index-template','character-detail-template','informational-template','disabled-submit-template','faq-contact-template','system-template')
foreach($file in @('mobile-template-families.svg','desktop-template-families.svg')){[xml]$svg=Get-Content -Raw (Join-Path $root "design/wireframes/$file");foreach($id in $templates){if(-not $svg.SelectSingleNode("//*[@id='$id']")){throw "$file missing template $id"}}}
$design=Get-Content -Raw (Join-Path $root 'docs/WEBSITE_DESIGN.md')
foreach($term in @('NO COLLECTION','Fourthwall','No payment data','WCAG 2.2 AA','Reduced motion','LCP ≤2.5s','INP ≤200ms','CLS ≤0.1','PROVISIONAL','Warnings use Ink')){if($design -notmatch [regex]::Escape($term)){throw "Design rule missing: $term"}}
foreach($journey in 1..8){if($design -notmatch "(?m)^$journey\."){throw "Missing journey $journey"}}
$tokens=Get-Content -Raw (Join-Path $root 'public/brand/tokens.json')|ConvertFrom-Json
foreach($token in @('page-background','surface-dark','surface-light','text-on-dark','text-on-light','action-primary','focus-ring','warning-background','warning-foreground','warning-border-nontext')){if($tokens.semantic.PSObject.Properties.Name -notcontains $token){throw "Missing semantic token: $token"}}
Write-Host "Design validation passed: 17 unique routes, 28 unique components, 13 inactive events, 8 journeys, 9 template families on mobile/desktop."
