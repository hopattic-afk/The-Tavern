# Content pipeline

## Flow

`consented incident -> privacy review -> anonymized story brief -> script -> IP/privacy review -> storyboard -> production -> caption/accessibility check -> founder approval -> platform publication -> archive/withdrawal handling`

Issue #8 locally defines this process but remains `NO COLLECTION`. Writers may receive only fields allowed by `incident-system/schemas/writer-brief.schema.json`; the raw record, contact reference, consent record and identity fields are forbidden.

Raw submissions are not repository content. Writers receive only approved, minimized briefs. A withdrawal request stops unpublished use and triggers deletion according to the approved retention policy.

## Status vocabulary

Use only these canonical statuses for public-safe story records: `draft`, `privacy-review`, `ip-review`, `founder-review`, `approved`, `scheduled`, `published`, `withdrawn`, `rejected`, `archived`. Raw intake systems may use Tavern-flavored display labels, but must map them to one canonical value. Only `approved`, `scheduled`, and `published` records may feed public builds.

## Animation contract

Issue #7 uses reusable 2D cutout characters, backgrounds, and props for 9:16, caption-readable, sound-independent videos, generally 15-45 seconds. Scripts contain hook, setup, escalation, conflict, and punchline. Rights for voices, music, sounds, artwork, and fonts must be recorded.

The provisional local package in `animation/` contains 30 synthetic premises, 10 timed scripts, 5 storyboards, and three silent SVG render candidates (S01, S02, S07). Its maximum status is `render-candidate`: character/brand approvals, rights review, Issue #8 safeguards, manual muted/mobile QA, Sentinel, founder approval, platform verification and publication remain blocked. Audio is intentionally absent and recorded as such.

## Repository content

Only founder-approved, public-safe copy and metadata belongs in `content/`; see `content/README.md` for the minimum schema and naming rules. Do not include member identities, private quotes, coordinates, strategy, account details, or consent records.

## Founder input inbox

`founder-input/` is the local working inbox for founder-supplied photos, story notes and character references. Its raw and review-state folders are Git-ignored and must never enter `content/`, `public/`, `src/`, `design/`, `animation/`, `social/`, `merch/` or `dist/`. Run `npm run content:scan` after changes.

The scanner verifies path isolation, supported extensions, effective Git tracking/ignore behavior, and exact relative-path copies in `public/` or `dist/`. It cannot detect a renamed or manually recreated derivative and does not perform rights, privacy, likeness, protected-reference or content review.

Every input starts as internal inspiration only. The matching template records source, ownership, permissions, privacy/likeness, protected references, intended use and adaptation limits. Inspiration/adaptation permission is distinct from publication or commercial clearance. A derivative needs a new public-safe asset, rights-register row, privacy/similarity review, Sentinel acceptance and founder approval.

Story source types are `synthetic`, `founder-memory` and `member-derived`. Founder-memory material is private by default. Member-derived raw material is blocked from this inbox and content pipeline while Issue #8 remains **NO COLLECTION**.

## Publication

Issue #9 prepares content but does not publish it. Every item completes IP/privacy review and founder approval before an external action.

The local Issue #9 package in `social/` remains draft/internal-review with null URLs, account and schedule IDs and `publicationAuthorized: false`. Live platform rules, every dependency and every per-item review remain blocked.
