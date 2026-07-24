# Site operations — Issue #5 provisional build

Status: local and deploy-ready only. The site, store, providers, forms and analytics are not active. Steve is the founder-selected private mascot direction; his public/commercial rights and the remaining roster, legal text and commerce remain unresolved.

## Local setup

Requirements: Node.js 22.12+ and npm. Run `npm ci`, then `npm run dev`. Run `npm run check`, `npm run lint`, `npm test`, `npm run validate`, and `npm run build` before review. The static output is `dist/`.

## Configuration

Only variable names belong in `.env.example`. `PUBLIC_SITE_URL` is the canonical approved preview/public origin. `PUBLIC_FOURTHWALL_STORE_URL` must be an HTTPS `fourthwall.com` host; missing or invalid values fail closed to “Store not connected.” `PUBLIC_CONTACT_URL` and `PUBLIC_INCIDENT_FORM_URL` are reserved and unused while collection is blocked.

Never place credentials, tokens, private alliance information, submissions, consent records or payment data in environment variables exposed with `PUBLIC_`, repository files, logs or analytics.

## Content updates

- Products and tales: `src/data/site.ts`; facts remain provisional until supplied by an approved source.
- Characters: `content/characters/characters.json`; expose only Steve on the website. Treat the other six records as archived decision evidence until founder-supplied imagery is reviewed. Steve still requires name, rights, similarity, and public/commercial clearance.
- Shared disclaimer and shell: `src/data/site.ts` and `src/layouts/BaseLayout.astro`.
- Brand tokens and original assets: `public/brand/` and `public/characters/`; update the rights register before public/commercial use.

Every update requires spelling/link review, responsive images with useful alt text or empty decorative alt, privacy/IP review, relevant checks and Sentinel acceptance.

## Private Netlify preview gate

No Netlify site has been linked or deployed. Founder approval is required before creating/linking a site, changing provider configuration or credentials, or deploying. After approval: connect the reviewed GitHub branch, use `npm run build` and `dist`, configure approved variables in Netlify, ensure access control makes the preview private, and verify response headers. A guessed or secret URL is not access control.

Preview evidence must include all routes, custom 404, keyboard/focus and reduced-motion checks, 320/768/1200 layouts, broken links, responsive/lazy images, metadata/social previews, noindex headers, Fourthwall origin/handoff, disabled form states, no secrets/private data/protected assets, and performance results. Hosted p75 Core Web Vitals cannot be claimed from a local build.

## Deployment and launch

Production deployment, public publication, domain/DNS, analytics, store opening, products, prices, legal text, providers and data collection each remain separate founder approval gates. Fourthwall owns products, variants, cart, checkout, payment, taxes, printing, fulfillment, shipping and order handling. Never add custom payment handling.

## Rollback

1. Mark the release no-go and notify the founder privately.
2. Restore the last verified deploy in Netlify after approval.
3. Disable affected outbound commerce links and any approved forms at provider and site layers.
4. Confirm the exact disclaimer, noindex/private-preview controls, routes and headers.
5. Preserve private diagnostic evidence without copying submissions or secrets into the repository.
6. Record cause, affected version, action, verifier and follow-up in the decision/launch evidence.
