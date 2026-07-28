# Site operations — Issue #5 pre-launch build

Status as of 2026-07-24: the founder-authorized pre-launch site is reachable at `https://trashtavern.com` on Netlify. HTTPS, apex hosting, `www` redirect, noindex headers and disabled commerce/forms were observed. This is not a completed public launch: the store, forms, analytics and social publishing are inactive, the launch matrix remains **NO-GO**, and Steve's commercial rights, remaining roster, final legal text and commerce remain unresolved.

## Local setup

Requirements: Node.js 22.12+ and npm. Run `npm ci`, then `npm run dev`. Run `npm run check`, `npm run lint`, `npm test`, `npm run content:scan`, `npm run validate`, and `npm run build` before review. The static output is `dist/`.

## Configuration

Only variable names belong in `.env.example`. Production `npm run build` pins the canonical origin to `https://trashtavern.com`; `astro.config.mjs` validates HTTP/HTTPS site origins and uses the custom domain as its safe default. `PUBLIC_SITE_URL` remains available for explicit non-production review origins. `PUBLIC_FOURTHWALL_STORE_URL` must be an HTTPS `fourthwall.com` host; missing or invalid values fail closed to “Store not connected.” `PUBLIC_CONTACT_URL` and `PUBLIC_INCIDENT_FORM_URL` are reserved and unused while collection is blocked.

Never place credentials, tokens, private alliance information, submissions, consent records or payment data in environment variables exposed with `PUBLIC_`, repository files, logs or analytics.

## Content updates

- Products and tales: `src/data/site.ts`; facts remain provisional until supplied by an approved source.
- Characters: `content/characters/characters.json`; expose only Steve on the website. Treat the other six records as archived decision evidence until founder-supplied imagery is reviewed. Steve still requires name, rights, similarity, and public/commercial clearance.
- Founder inspiration: drop raw photos/stories/character references only in `founder-input/*/raw/`; complete the matching local template and run `npm run content:scan`. Raw input never enters Git or the public build.
- Shared disclaimer and shell: `src/data/site.ts` and `src/layouts/BaseLayout.astro`.
- Brand tokens and original assets: `public/brand/` and `public/characters/`; update the rights register before public/commercial use.

Every update requires spelling/link review, responsive images with useful alt text or empty decorative alt, privacy/IP review, relevant checks and Sentinel acceptance.

## Netlify pre-launch evidence gate

The custom-domain deployment is publicly reachable and must never be described as private or access-controlled. It remains a founder-authorized pre-launch review surface protected by noindex—not confidentiality. No secrets, private alliance material or uncleared raw founder input may be placed on it.

Release evidence still needs all routes, custom 404, keyboard/focus and reduced-motion checks, 320/768/1200 layouts, broken links, responsive/lazy images, canonical metadata/social previews, noindex headers, Fourthwall origin/handoff, disabled form states, no secrets/private data/protected assets, and performance results. Hosted p75 Core Web Vitals cannot be claimed without field evidence.

The 2026-07-28 hosted passes are recorded in `docs/HOSTED_QA_EVIDENCE.md`. Production deploy `6a692121f359e4000850ab26` closed CB-02 after the route/link/metadata/header, Lighthouse, keyboard-focus, 320/768/1200 layout and corrected disabled-form checks passed.

## Deployment and launch

Netlify continuous deployment is founder-authorized from the GitHub repository `hopattic-afk/The-Tavern`, using build command `npm run build` and publish directory `dist`. PR #22 merged as merge commit `175bf0f`, and the founder approved switching the Netlify production branch from `codex/atlas-content-readiness` to the stable branch `codex/issue-1-foundation`. Stable deploy `6a64f72dc2debf7ff30ba672` is ready from commit `175bf0f`. Every push to `codex/issue-1-foundation` can now update the production site and must be treated as a production deployment.

The custom domain and current pre-launch Netlify deployment are accepted decisions. Beyond the completed PR #22 merge and founder-approved production-branch switch recorded above, no additional merge, provider-setting change, new provider, credential/configuration change, launch-indexing change or other launch gate is approved. Keep noindex and all existing pre-launch controls. Analytics, store opening, products, prices, legal text, forms, providers and data collection remain separate founder gates. Fourthwall owns products, variants, cart, checkout, payment, taxes, printing, fulfillment, shipping and order handling. Never add custom payment handling.

## Rollback

1. Mark the release no-go and notify the founder privately.
2. Restore the last verified deploy in Netlify after approval.
3. Disable affected outbound commerce links and any approved forms at provider and site layers.
4. Confirm the exact disclaimer, noindex/private-preview controls, routes and headers.
5. Preserve private diagnostic evidence without copying submissions or secrets into the repository.
6. Record cause, affected version, action, verifier and follow-up in the decision/launch evidence.
