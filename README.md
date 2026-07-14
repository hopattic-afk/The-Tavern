# The Tavern

The Tavern is an unofficial ALE alliance community brand: medieval trash pandas running a tavern in a dumpster-fire kingdom. It is intended for adult mobile-strategy gamers and alliance members through original web, merchandise, and short-form comedy experiences.

> An unofficial player-community project. The Tavern and ALE are not affiliated with or endorsed by Kingshot or CenturyGames.

## Project status

Issue #5 provisional local website build. Brand, roster, design, legal and commerce decisions remain pending. No public site, store, form, analytics or social account is launched from this repository without explicit founder approval.

## Repository map

- `docs/`: authoritative project, creative, technical, privacy, commerce, and launch rules.
- `content/`: repository-managed public-safe content; never store raw alliance submissions here.
- `public/`: approved original or properly licensed public assets only.
- `components/`: future reusable site components.
- `scripts/`: local validation and maintenance tools.

## Working here

1. Read `AGENTS.md`, `docs/PROJECT_BRIEF.md`, and the document relevant to your issue.
2. Confirm the issue's dependencies in `docs/ROADMAP.md` are complete.
3. Keep changes on a dedicated branch and use private previews only when approved.
4. Run `pwsh -File scripts/validate-foundation.ps1`.
5. Record durable decisions in `docs/DECISION_LOG.md`.

Website setup, content, private-preview gates and rollback are documented in `docs/SITE_OPERATIONS.md`.

Never commit secrets, private messages, coordinates, member identities, protected game assets, or unapproved submissions.
