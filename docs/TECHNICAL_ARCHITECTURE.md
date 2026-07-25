# Technical architecture

## Decision

The Issue #5 provisional implementation uses Astro with static output and zero hydration for content pages. This remains a proposed product decision until design/Sentinel/founder acceptance. The commerce boundary is a fail-closed HTTPS outbound link to an approved `fourthwall.com` store; no custom cart, checkout, payment fields or payment storage exists.

## Boundaries

- GitHub: source and review history.
- Astro application: public presentation, content rendering, navigation, accessible forms, SEO, and outbound commerce handoff.
- Repository Markdown/JSON: approved public content at launch; no raw submissions or consent records.
- Fourthwall: product catalog, variants, cart/checkout, payment, taxes, fulfillment, shipping, and order support.
- Netlify: founder-approved host for the noindex pre-launch site at `https://trashtavern.com`; the reachable site is not private access control.
- Alliance Alerts Worker: existing scheduler and database behind two exact hostname gates: a narrowly public `alerts.<approved-domain>` surface and a hostname-wide Access-protected `alerts-admin.<approved-domain>` application.
- Submission provider: undecided until data/privacy gate; must support consent evidence, restricted access, withdrawal, retention, and deletion.

## Alliance Alerts integration

The Tavern adds a static `/alliance-alerts/` route. At build time it accepts only an exact HTTPS URL whose path is `/embed` and which has no credentials, query or fragment. Invalid or missing configuration renders an unavailable notice and keeps CSP `frame-src 'none'`.

When configured, the page embeds that single public surface in a script-only sandbox with no referrer. The Tavern does not fetch reminder data, expose dashboard or delivery-history fields, or receive reminder-service credentials. A post-build generator writes `dist/_headers` so the CSP permits only the configured embed origin while retaining the existing noindex, anti-framing, permissions, referrer, MIME and opener controls.

Release topology is the founder-approved Tavern apex/`www` origin on Netlify, `alerts.<approved-domain>` as the public Worker hostname, and `alerts-admin.<approved-domain>` as the private Worker hostname. The public hostname has no Cloudflare Access application and the Worker returns `404` for everything except `/embed`, `/embed.css`, `/embed.js` and `/api/public/upcoming`. The admin hostname is protected in full by Cloudflare Access and is never embedded or publicly linked.

Worker routing must reject unknown or cross-boundary host/path combinations before application routing. Public framing and any cross-origin response use exact approved Tavern origins; wildcard origins are not allowed. Cloudflare Access Bypass policies are prohibited: separation comes from distinct hostnames, with Access covering the complete admin hostname. The admin application still verifies authenticated requests after Access.

Release evidence must show anonymous public embed success, anonymous public-host admin `404`, anonymous admin-host denial or Access redirect, and authenticated admin dashboard/API success. Domain, DNS, Worker routes, the admin Access application, public-feed enablement and deployment remain separate founder approval gates.

## Quality targets for Issue #4/#5

Mobile-first; semantic HTML; keyboard and visible-focus support; WCAG 2.2 AA target; reduced motion; responsive optimized images; lazy-load below fold; minimal JS; per-page metadata/Open Graph; form validation and safe error states. Define and measure Core Web Vitals budgets during design.

## Security and data

Environment variable names live in `.env.example`; values live only in approved provider secret stores. Apply least privilege, dependency review, output encoding, server-side validation, rate/spam controls, and no sensitive values in analytics or logs. The public repository must not store submissions.

## Delivery

Branch -> local checks -> draft review -> noindex custom-domain pre-launch deploy after approval -> hosted acceptance evidence -> founder launch decision. The current domain/host choice is accepted; material deployments, indexing changes, analytics activation, provider purchases, credential changes, commerce, collection, public alert-feed activation, and the hostname-wide admin Access application remain approval gates. Rollback is the last verified deploy plus disabling affected forms/links or removing the alerts embed variable and rebuilding to restore `frame-src 'none'`. Never use an Access Bypass policy as a rollback or availability measure.

## Open decisions

Fourthwall integration method, submission/email providers, analytics consent model, final Tavern and alerts hostnames, legal jurisdiction/business identity, content schema, and measurable performance budgets.
