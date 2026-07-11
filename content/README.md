# Content

Store only approved, public-safe site copy and metadata here. Never store raw incident submissions, consent records, private messages, coordinates, strategy, account details, or member identities.

## Minimum record

Use Markdown with YAML front matter or JSON containing: `id`, `type`, `slug`, `title`, `summary`, `status`, `createdAt`, `updatedAt`, `privacyReview`, `ipReview`, and `founderApproval`. Add `publishAt` only for scheduled content and `rightsIds` for every associated asset. Review fields identify approval records, not personal consent data.

IDs and filenames use lowercase ASCII kebab-case: `<type>-<short-name>-<yyyy-mm-dd>` (for example `tale-missed-rally-2026-07-11.md`). Slugs are unique and stable. Dates use ISO 8601. Use only the canonical statuses defined in `docs/CONTENT_PIPELINE.md`. Public builds must exclude everything except `approved`, `scheduled`, or `published`.
