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

## Publication

Issue #9 prepares content but does not publish it. Every item completes IP/privacy review and founder approval before an external action.
