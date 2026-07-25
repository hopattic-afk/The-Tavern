# Technical architecture

## Decision

The Issue #5 provisional implementation uses Astro with static output and zero hydration for content pages. This remains a proposed product decision until design/Sentinel/founder acceptance. The commerce boundary is a fail-closed HTTPS outbound link to an approved `fourthwall.com` store; no custom cart, checkout, payment fields or payment storage exists.

## Boundaries

- GitHub: source and review history.
- Astro application: public presentation, content rendering, navigation, accessible forms, SEO, and outbound commerce handoff.
- Repository Markdown/JSON: approved public content at launch; no raw submissions or consent records.
- Fourthwall: product catalog, variants, cart/checkout, payment, taxes, fulfillment, shipping, and order support.
- Netlify: founder-approved host for the noindex pre-launch site at `https://trashtavern.com`; the reachable site is not private access control.
- Submission provider: undecided until data/privacy gate; must support consent evidence, restricted access, withdrawal, retention, and deletion.

## Quality targets for Issue #4/#5

Mobile-first; semantic HTML; keyboard and visible-focus support; WCAG 2.2 AA target; reduced motion; responsive optimized images; lazy-load below fold; minimal JS; per-page metadata/Open Graph; form validation and safe error states. Define and measure Core Web Vitals budgets during design.

## Security and data

Environment variable names live in `.env.example`; values live only in approved provider secret stores. Apply least privilege, dependency review, output encoding, server-side validation, rate/spam controls, and no sensitive values in analytics or logs. The public repository must not store submissions.

## Delivery

Branch -> local checks -> draft review -> noindex custom-domain pre-launch deploy after approval -> hosted acceptance evidence -> founder launch decision. The current domain/host choice is accepted; material deployments, indexing changes, analytics activation, provider purchases, credential changes, commerce and collection remain approval gates. Rollback is the last verified deploy plus disabling affected forms/links.

## Open decisions

Fourthwall integration method, submission/email providers, analytics consent model, domain, legal jurisdiction/business identity, content schema, and measurable performance budgets.
