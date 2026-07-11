# Technical architecture

## Decision

Use Astro as the default frontend candidate for Issue #5: the expected site is content-heavy and mostly static, so Astro supports minimal client JavaScript, component reuse, responsive images, and Netlify previews. Validate the choice against Issue #4 designs and Fourthwall's current supported integration before scaffolding; record any change in the decision log.

## Boundaries

- GitHub: source and review history.
- Astro application: public presentation, content rendering, navigation, accessible forms, SEO, and outbound commerce handoff.
- Repository Markdown/JSON: approved public content at launch; no raw submissions or consent records.
- Fourthwall: product catalog, variants, cart/checkout, payment, taxes, fulfillment, shipping, and order support.
- Netlify: preferred private previews and, only after approval, hosting.
- Submission provider: undecided until data/privacy gate; must support consent evidence, restricted access, withdrawal, retention, and deletion.

## Quality targets for Issue #4/#5

Mobile-first; semantic HTML; keyboard and visible-focus support; WCAG 2.2 AA target; reduced motion; responsive optimized images; lazy-load below fold; minimal JS; per-page metadata/Open Graph; form validation and safe error states. Define and measure Core Web Vitals budgets during design.

## Security and data

Environment variable names live in `.env.example`; values live only in approved provider secret stores. Apply least privilege, dependency review, output encoding, server-side validation, rate/spam controls, and no sensitive values in analytics or logs. The public repository must not store submissions.

## Delivery

Branch -> local checks -> review -> approved private preview -> acceptance evidence -> founder launch decision. Production deployment, domain/DNS, analytics activation, provider purchases, and credential changes are approval gates. Rollback is the last verified deploy plus disabling affected forms/links.

## Open decisions

Fourthwall integration method, submission/email providers, analytics consent model, domain, legal jurisdiction/business identity, content schema, and measurable performance budgets.
