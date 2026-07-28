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
