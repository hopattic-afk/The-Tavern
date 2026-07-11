# Content pipeline

## Flow

`consented incident -> privacy review -> anonymized story brief -> script -> IP/privacy review -> storyboard -> production -> caption/accessibility check -> founder approval -> platform publication -> archive/withdrawal handling`

Raw submissions are not repository content. Writers receive only approved, minimized briefs. A withdrawal request stops unpublished use and triggers deletion according to the approved retention policy.

## Status vocabulary

Use only these canonical statuses for public-safe story records: `draft`, `privacy-review`, `ip-review`, `founder-review`, `approved`, `scheduled`, `published`, `withdrawn`, `rejected`, `archived`. Raw intake systems may use Tavern-flavored display labels, but must map them to one canonical value. Only `approved`, `scheduled`, and `published` records may feed public builds.

## Animation contract

Issue #7 uses reusable 2D cutout characters, backgrounds, and props for 9:16, caption-readable, sound-independent videos, generally 15-45 seconds. Scripts contain hook, setup, escalation, conflict, and punchline. Rights for voices, music, sounds, artwork, and fonts must be recorded.

## Repository content

Only founder-approved, public-safe copy and metadata belongs in `content/`; see `content/README.md` for the minimum schema and naming rules. Do not include member identities, private quotes, coordinates, strategy, account details, or consent records.

## Publication

Issue #9 prepares content but does not publish it. Every item completes IP/privacy review and founder approval before an external action.
