# Website design architecture — provisional

Status: design evidence only. Issue #2/#3 identity and roster assets are **PROVISIONAL**. Incident intake is **NO COLLECTION**. This document does not approve implementation, providers, legal text, preview deployment, or publication.

## Sitemap and routes

| Route | Page | Primary outcome | Required content/state |
|---|---|---|---|
| `/` | Home | Understand and choose a path | Hero, brand explanation, featured merch, featured character, latest skit, noticeboard, email signup, social links, disclaimer |
| `/shop` | Shop | Browse curated products | Provisional product grid, Fourthwall disclosure, empty/error state |
| `/shop/[slug]` | Product detail | Review facts and hand off | Images/alt, price/variant ownership, size/care, shipping/returns links, Fourthwall handoff |
| `/tavern-tales` | Tavern Tales | Browse skits | Cards, filters only if evidence supports, empty state |
| `/tavern-tales/[slug]` | Tale detail | Watch/read accessibly | Poster, player, captions, transcript, related content, rights/review status |
| `/trash-pandas` | Meet the Trash Pandas | Browse cast | Provisional roster cards and approval label |
| `/trash-pandas/[slug]` | Character detail | Understand a character | Provisional profile, alt text, related tales/merch concepts |
| `/about` | About The Tavern | Understand purpose | Objective, tone, unofficial disclaimer |
| `/about/ale` | About ALE | Public-safe context only | No names, strategy, messages, coordinates, or private history |
| `/submit` | Submit an Incident | Explain future process | Disabled form architecture, NO COLLECTION notice, privacy prerequisites |
| `/faq` | FAQ | Resolve common questions | Brand, commerce ownership, submissions, disclaimer |
| `/contact` | Contact | Find approved support path | Provider placeholder, no live form until approved |
| `/shipping` | Shipping | Understand order ownership | Fourthwall-sourced placeholder, effective/review date |
| `/returns` | Returns | Understand return ownership | Fourthwall-sourced placeholder, effective/review date |
| `/privacy` | Privacy | Understand data handling | Legal placeholder; provider/jurisdiction decisions required |
| `/terms` | Terms | Understand use terms | Legal placeholder; founder/legal review required |
| `/404` | Not found | Recover | Search-free suggested paths, Home/Tales/Shop links |

## Core journeys

1. First visit: Home → explanation → Shop, Tales, or Characters; disclaimer remains visible.
2. Commerce: card → product facts → explicit Fourthwall handoff. Tavern never receives payment data.
3. Content: Tales → detail → caption/transcript → related character/social handoff.
4. Character: featured/cast → provisional profile → related content; no asset presented as approved.
5. Incident: noticeboard → `/submit` → NO COLLECTION explanation. Future form remains disabled until Issue #8 founder data gate.
6. Email/social: CTA → provider/consent disclosure → placeholder result/error states; no provider activation.
7. Support/legal: product/footer → shipping/returns/contact/privacy/terms with ownership and placeholder status visible.
8. Failure/accessibility: skip link, keyboard navigation, validation summary, reduced-motion experience, empty/error/loading, 404 recovery.

## Component system

- Shell: `SiteHeader`, `PrimaryNav`, `SkipLink`, `FooterDisclaimer`, `PageMeta`.
- Brand/content: `TavernNotice`, `DumpsterDivider`, `WantedPoster`, `CharacterCard`, `SkitCard`, `TavernQuote`, `FlamingDumpsterBadge`.
- Commerce: `MerchCard`, `ProductFacts`, `FourthwallHandoff`, `TankardButton`.
- Forms: `IncidentFormDisabled`, `Field`, `ValidationSummary`, `ConsentBlock`, `StatusNotice`, `EmailSignupPlaceholder`.
- Media/system: `ResponsiveImage`, `CaptionedVideo`, `Transcript`, `EmptyState`, `ErrorState`, `LoadingSkeleton`.

Every component requires semantic element, content owner, loading/empty/error/disabled behavior where relevant, keyboard/focus contract, accessible name, analytics trigger, privacy classification, and provisional/approval status.

## Content matrix

Every record supplies stable ID/slug, title, summary, status, timestamps, privacy/IP reviews, founder approval, rights IDs, metadata/OG requirements, alt/transcript where relevant, owner, and empty/error fallback. Only approved/scheduled/published content may feed public builds.

- Merch adds Fourthwall ID/URL, factual description, images/alt, price ownership, variants, care/size, shipping/returns source; placeholders say `NOT FOR SALE — PROVISIONAL`.
- Tales add poster/alt, duration, captions/transcript, character references and publication status.
- Characters add approved name/role/accent/image/alt and related content; current data stays provisional.
- Legal/support adds jurisdiction/provider dependency, effective date, last review, and placeholder label.

## Responsive rules

Mobile-first at 320px minimum. Content uses one column through 767px, two-column layouts only when content order remains logical, and maximum reading width 72ch. At 768px and 1200px, grids may expand to 2/3 columns. Navigation collapses to an accessible disclosure, never hover-only. Media reserves aspect ratio. Touch targets are at least 44×44 CSS px. At 200% zoom and 320 CSS px, no two-dimensional scrolling except intentional data tables.

## Accessibility and motion

Target WCAG 2.2 AA: semantic landmarks/headings, skip link, visible focus, logical focus/order, labels/instructions/errors, validation summary, programmatic status, no color-only meaning, contrast from actual token pairs, text reflow, captions/transcripts, useful alt text, and keyboard-operable controls. Decorative texture is hidden from assistive technology.

Reduced motion removes parallax, fire flicker, auto-rotation, smooth scrolling, and nonessential transforms. Essential state changes use instant replacement or opacity under 150ms. No autoplay audio or motion.

Warnings use Ink text on Parchment 50 with Ember only as a border/icon/non-text accent. Never use Ember as warning body text on Soot; status meaning also requires text/icon labels.

## Performance budgets

Proposed for founder approval and Issue #5 verification at p75: LCP ≤2.5s, INP ≤200ms, CLS ≤0.1. Initial JavaScript ≤100KB compressed excluding an on-demand media player. Use responsive modern images, explicit dimensions, lazy-load below-fold media, static rendering by default, and no decorative video on initial load.

## Fourthwall and forms

Fourthwall owns products, variants, cart, checkout, payments, tax, printing, fulfillment, shipping and order handling. The Tavern provides an explicit outbound handoff only through a currently supported method validated in Issue #5. No payment data, cart clone, or custom checkout.

`IncidentFormDisabled` renders information only and submits nothing. Real data, test member data, endpoints, storage, consent records and analytics are forbidden until Issue #8 approval. Email/contact controls are nonfunctional placeholders until provider, consent, retention, error and privacy decisions are approved.

## Design approval gate

Founder must approve sitemap, journeys, representative mobile/desktop architecture, performance budgets and analytics taxonomy after Sentinel review. This handoff permits Issue #5 planning only; it does not approve provisional identity/characters, data collection, integrations, legal text, deployment or publication.
