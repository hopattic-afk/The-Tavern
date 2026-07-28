# Hosted QA evidence

## 2026-07-28 pre-launch review

- Target: `https://trashtavern.com`
- Environment: production-hosted, noindex pre-launch surface
- Release source observed before this review: stable branch `codex/issue-1-foundation`
- Result: **PARTIAL — CB-02 remains open pending deployment and retest of two local fixes**

### Passed hosted checks

- Homepage and 20 approved routes rendered; the custom 404 behaved correctly.
- Layouts were exercised at 320, 768, and 1200 CSS pixels.
- 39 internal links resolved in the hosted route/link pass.
- Canonical URL, Open Graph URL/image, and noindex metadata were present.
- Apex HTTPS and `www` redirect behavior passed.
- CSP and security headers kept frames, forms, and connections fail closed.
- Store, incident, contact, and email controls remained disabled.
- Responsive images, visible focus styling, and reduced-motion CSS were present.
- Lighthouse lab results: performance 99, accessibility 100, best practices 100; FCP 1.2s, LCP 1.3s, TBT 110ms, CLS 0, and Speed Index 1.5s.

The Lighthouse SEO score was 61 because the pre-launch site is intentionally not crawlable and does not publish a robots file or sitemap. Those are launch-gated behaviors, not defects to bypass while noindex remains required.

### Defects found

1. Skip-link activation reached `#main`, but the target was not programmatically focusable.
2. The disabled email fieldset caused horizontal overflow at 320 CSS pixels.

### Local remediation

- `src/layouts/BaseLayout.astro`: added `tabindex="-1"` to the main landmark.
- `src/styles/global.css`: constrained disabled form fieldsets and inputs to the available inline size.
- `tests/site.test.ts`: added regression coverage for both fixes.

### Required retest

- Deploy this reviewed branch only after founder approval.
- Repeat the 320/768/1200 hosted matrix, skip-link keyboard test, horizontal-overflow check, reduced-motion check, route/link scan, and console-error scan against the deployed SHA.
- Repeat Lighthouse after deployment. Field p75 Core Web Vitals require real field data and are not claimed here.
- Obtain independent Sentinel acceptance before closing CB-02.

## 2026-07-28 production retest

- Deploy: `6a691f5209cc5a00084e6579`
- Commit: `db1277dd8c48a06c3a9840bf734c55c557313ade`
- Result: **PARTIAL — CB-02 remains open pending one checkbox-layout fix and final retest**

The deployed skip-link now moves keyboard focus to `MAIN#main`. The `/submit/` page had no horizontal overflow at 320, 768, or 1200 CSS pixels; canonical/noindex metadata remained correct and the browser console had no warnings or errors.

The retest found that disabled checkboxes stretched to the grid track width at 320 CSS pixels. The follow-up fix assigns a compact explicit checkbox size and start alignment. It requires the same local checks, independent Sentinel acceptance, approved deployment, and a final hosted `/submit/` retest before CB-02 can close.

## 2026-07-28 final production retest

- Deploy: `6a692121f359e4000850ab26`
- Commit: `92a33cdaa52205fb5f158f7edac3e908ca6fde07`
- Result: **PASS — CB-02 closed**

At 320 CSS pixels, `/submit/` measured `clientWidth=320` and `scrollWidth=320`. All five disabled checkboxes measured approximately 17.6 × 17.6 CSS pixels. The homepage skip link set `#main` and moved focus to `MAIN#main`; the homepage also remained free of horizontal overflow at 320px.

Lighthouse was repeated against `https://trashtavern.com/` at `2026-07-28T21:51:13Z`: performance 97, accessibility 100, best practices 100, and intentionally noindex-limited SEO 61. Lab metrics were FCP 1.0s, LCP 1.2s, TBT 200ms, CLS 0, and Speed Index 1.4s.

The deployed code retains noindex metadata and fail-closed collection/commerce controls. No forms, analytics, social publishing, commerce, functions, or edge functions were activated. Lighthouse field p75 Core Web Vitals are not claimed; the final deployed lab run is the current performance baseline.
