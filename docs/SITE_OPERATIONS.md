# Site operations — Issue #5 provisional build

Status: local and deploy-ready only. The site, store, providers, forms and analytics are not active. Steve is the founder-selected private mascot direction; his public/commercial rights and the remaining roster, legal text and commerce remain unresolved.

## Local setup

Requirements: Node.js 22.12+ and npm. Run `npm ci`, then `npm run dev`. Run `npm run check`, `npm run lint`, `npm test`, `npm run validate`, and `npm run build` before review. The static output is `dist/`.

## Configuration

Only variable names belong in `.env.example`. `PUBLIC_SITE_URL` is the canonical approved preview/public origin. `PUBLIC_FOURTHWALL_STORE_URL` must be an HTTPS `fourthwall.com` host; missing or invalid values fail closed to “Store not connected.” `PUBLIC_CONTACT_URL` and `PUBLIC_INCIDENT_FORM_URL` are reserved and unused while collection is blocked.

`PUBLIC_ALLIANCE_ALERTS_EMBED_URL` is a build-time public value, not a credential. It accepts only `https://alerts.<approved-domain>/embed`, with no credentials, query string or fragment. Missing or invalid values fail closed to an informative unavailable state and produce `frame-src 'none'`. A valid value produces a CSP `frame-src` containing only that URL's exact origin. The Tavern must never point this variable at `alerts-admin.<approved-domain>`, `/`, `/api/admin/*`, dashboard, delivery-history or diagnostic surfaces.

Never place credentials, tokens, private alliance information, submissions, consent records or payment data in environment variables exposed with `PUBLIC_`, repository files, logs or analytics.

## Content updates

- Products and tales: `src/data/site.ts`; facts remain provisional until supplied by an approved source.
- Characters: `content/characters/characters.json`; expose only Steve on the website. Treat the other six records as archived decision evidence until founder-supplied imagery is reviewed. Steve still requires name, rights, similarity, and public/commercial clearance.
- Shared disclaimer and shell: `src/data/site.ts` and `src/layouts/BaseLayout.astro`.
- Brand tokens and original assets: `public/brand/` and `public/characters/`; update the rights register before public/commercial use.

Every update requires spelling/link review, responsive images with useful alt text or empty decorative alt, privacy/IP review, relevant checks and Sentinel acceptance.

## Alliance Alerts domain topology

- Tavern site: the founder-approved apex and/or `www.<approved-domain>` on Netlify.
- Public reminder host: `alerts.<approved-domain>` routed to the existing Cloudflare Worker. It has no Cloudflare Access application and exposes only `/embed`, `/embed.css`, `/embed.js` and `/api/public/upcoming`.
- Private reminder host: `alerts-admin.<approved-domain>` routed to the same Worker, with the whole hostname protected by Cloudflare Access. It serves the dashboard and `/api/admin/*` and is never embedded or linked from public Tavern pages.

The Worker must enforce the exact public and admin hostnames before route handling. On the public hostname, every route outside the four public paths returns `404`; an admin route must never fall through to Access or application data. Public embed responses allow framing only from the approved Tavern apex/`www` origins, and any cross-origin response uses an exact approved origin rather than `*`. On the admin hostname, the Worker retains its authenticated admin checks in addition to the hostname-wide Access application.

Do not create Cloudflare Access Bypass policies. The public embed works because it is on a separate hostname with no Access application, not because an exception weakens the admin policy.

The Tavern iframe is sandboxed, sends no referrer and does not call the reminder API directly. The post-build `dist/_headers` file is generated from the same URL validator as the page, preserving all existing security and noindex headers while allowing only the configured public alerts origin.

## Private Netlify preview gate

No Netlify site has been linked or deployed. Founder approval is required before creating/linking a site, changing provider configuration or credentials, or deploying. After approval: connect the reviewed GitHub branch, use `npm run build` and `dist`, configure approved variables in Netlify, ensure access control makes the preview private, and verify response headers. A guessed or secret URL is not access control.

Before enabling Alliance Alerts, founder approval is also required for the domain/subdomain choice, DNS or Worker-route changes, `PUBLIC_UPCOMING_ENABLED`, the exact embed URL, the hostname-wide `alerts-admin` Access application and any preview or production publication. Sentinel must verify that the feed contains only approved public reminder fields and that private routes reject unauthenticated requests. No Bypass policy is permitted.

Release verification must record all four checks against the approved hostnames:

1. Anonymous public embed succeeds: `GET https://alerts.<approved-domain>/embed` returns the public surface, and its required public assets/API succeed without an Access challenge.
2. Anonymous public-host admin fails closed: a representative `/api/admin/*` request to `alerts.<approved-domain>` returns `404` with no dashboard data and no Access redirect.
3. Anonymous admin-host access is denied: `GET https://alerts-admin.<approved-domain>/` is denied or redirected to Cloudflare Access.
4. Authenticated admin succeeds: an approved Access-authenticated request to `alerts-admin.<approved-domain>` reaches the dashboard and representative admin API.

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
