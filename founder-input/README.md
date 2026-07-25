# Founder input — local working inbox

Use this folder to give Atlas source material for internal inspiration and review. Raw files and review state are intentionally ignored by Git and excluded from the Astro site.

## Where to put things

- Photos or visual references: `photos/raw/`
- Story notes or documents: `stories/raw/`
- Character notes or images: `characters/raw/`
- Private working review records: `review-state/`

Copy the matching template before adding an item:

- `photos/PHOTO_INPUT_TEMPLATE.md`
- `stories/STORY_INPUT_TEMPLATE.md`
- `characters/CHARACTER_INPUT_TEMPLATE.md`

The completed copy may sit beside the raw item or in `review-state/`; both locations are ignored. Do not add real inputs to `public/`, `src/`, `content/`, `design/`, `animation/`, `social/` or `merch/`.

## Default handling

1. Every input starts as **internal inspiration only**.
2. A file may guide mood, pose, material, palette, silhouette, story structure or character traits only after its source and permissions are recorded.
3. Inspiration/adaptation permission does not grant publication, merchandise, advertising or commercial rights.
4. No raw file moves into Git or a public build. Any derivative needs a new public-safe asset, its own rights-register row, privacy/similarity review, Sentinel acceptance and founder approval.
5. Never add protected Kingshot/CenturyGames assets, private alliance information, member identities, exact private quotes, coordinates, strategy, account details, credentials or recognizable human likenesses.
6. Story input is founder-local only. Issue #8 remains **NO COLLECTION**: there is no public/member submission channel.

Run `npm run content:scan` after adding or removing inputs. The scanner checks path isolation, supported extensions, effective Git tracking/ignore behavior, and exact relative-path copies in `public/` or `dist/`. It does not read image or document contents, make network calls, detect a renamed/manual derivative, or perform rights, privacy, likeness, protected-reference or content review.

## Approval meanings

- `internal-inspiration`: may inform private ideation only.
- `adaptation-approved`: a new original work may be developed within the recorded limits; publication is still blocked.
- `publication-cleared`: requires documented source/rights/privacy/similarity evidence, a rights-register row, Sentinel acceptance and founder approval.
- `commercial-cleared`: additionally covers merchandise/advertising/commercial scope; never infer this from upload or adaptation permission.
