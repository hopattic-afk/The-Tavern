# Roadmap

## Delivery rules

An issue is ready when dependencies are accepted, inputs and owner are named, privacy/IP questions are resolved, and measurable acceptance criteria remain valid. It is done only when evidence is linked, checks pass, Sentinel has reviewed meaningful changes, and required founder approvals are recorded.

## Phases and dependencies

| Phase | Issue | Deliverable | Depends on | Blocks |
|---|---:|---|---|---|
| 0 Foundation | #1 | Repository operating system | None | #2-#10 |
| 1 Identity | #2 | Brand system and licensed asset register | #1 | #4, #5, #6, #7, #8, #9 |
| 1 Identity | #3 | Original character universe | #1; coordinate with #2 | #4, #6, #7, #9 |
| 2 Experience | #4 | Sitemap, journeys, wireframes, components, tokens | #2 and sufficient #3 content | #5 |
| 2 Governance | #8 | Consent-based incident workflow | #1 privacy rules, #2 voice | #7, #9 |
| 3 Build | #5 | Private-preview website and Fourthwall handoff | #2, #4, legal/privacy decisions | #9, #10 |
| 3 Commerce | #6 | Three-design Drop 01 and reviewed samples | #2, #3 | #9, #10 |
| 3 Content | #7 | Animation pipeline and three ready videos | #2, #3, #8 safeguards | #9, #10 |
| 4 Launch prep | #9 | Reviewed 30-day social package | #2, #3, #7; links/assets from #5/#6/#8 | #10 |
| 5 Gate | #10 | Evidence-based launch-readiness decision | #5-#9 | Public launch |

Critical path: `#1 -> (#2 + #3) -> #4 -> #5 -> #10`. Commerce: `#2 + #3 -> #6 -> #10`. Content: `#2 + #3 + #8 -> #7 -> #9 -> #10`.

## Phase gates

- Identity gate: founder approves positioning, logo direction, primary mascot, license evidence, and any member-derived references.
- Experience gate: founder approves sitemap/design architecture before large-scale implementation.
- Data gate: incident collection remains disabled until founder approves provider, consent text, access, retention, deletion, withdrawal, and breach-response workflow.
- Commerce gate: founder approves Fourthwall setup, products, prices, margins, and purchases; public sale waits for sample review.
- Content gate: IP/privacy review and commercial rights evidence complete before external publication.
- Preview gate: founder approves provider configuration, analytics, integrations, and any credential changes.
- Launch gate: Issue #10 has no critical blocker and founder explicitly approves public deployment/store/social publication.

Existing Issues #2-#10 provide the measurable acceptance criteria for their deliverables. This roadmap sequences them without weakening those criteria.

Issue #2/#3 checkpoint: Issue #2 may provisionally approve Tavern-only palette, typography, wordmark, and non-character mark. Final mascot lockup, character accents, and ALE badge stay blocked until Issue #3 and authority gates are complete.

Issue #3 handoff gate: the provisional seven-character universe and Bramble mascot recommendation do not unblock #6/#7/#9 production until name/trademark screening, similarity/privacy review, Sentinel review, founder roster/mascot approval, and #2 mascot-lockup review are recorded.

Issue #4 handoff gate: design evidence uses provisional #2/#3 placeholders and keeps incident collection, analytics, forms, providers and Fourthwall integration inactive. Issue #5 implementation is blocked until Sentinel and founder approve the design architecture; that approval does not authorize deployment or publication.

Issue #5 implementation checkpoint: a reversible local Astro build may use clearly labeled provisional #2/#3/#4 inputs. Completion still requires an approved private Netlify preview and verified Fourthwall handoff. Netlify linking/deployment, providers, credentials, collection, analytics, commerce activation and publication remain founder gates.

Issue #6 implementation checkpoint: Drop 01 has a provisional 10 → 5 → 3 concept package across four product types. D01/D02 remain blocked on #2; D03 remains blocked on #2/#3. Vendor specifications, costs, prices, margins, production/shipping facts, account/product creation, sample spending, physical QA and sale activation remain unresolved gates. #10 owns final store-opening approval.

Issue #7 implementation checkpoint: a synthetic-fiction 30 → 10 → 5 → 3 package, reusable SVG studies, captions and silent render candidates exist locally. Status cannot exceed `render-candidate` until #2/#3 identity/character approval, #8 safeguards, rights/privacy/manual QA, Sentinel and founder approval. #9 owns current platform packaging; #10/publication approval remains external.
