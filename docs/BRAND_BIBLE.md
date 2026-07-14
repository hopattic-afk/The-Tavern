# Brand bible — provisional system

Status: **non-character identity remains provisional pending founder identity-gate approval**. Issue #2 owns this system. Issue #3 owns the character roster and mascot. Steve is the founder-selected private mascot direction; his final artwork/name clearance, all other character likenesses, and the ALE badge remain blocked.

## Position and audience

The Tavern is a polished unofficial community tavern for adult mobile-strategy gamers: bad plans, strong rallies, original trash-panda comedy, and loyal self-awareness. It is chaotic in voice but disciplined in readability, accessibility, privacy, and commerce. It must feel rough and handmade without becoming generic esports, childish, or visually dirty.

## Recommended direction: Crooked Tankard

Use the non-character wordmark and crooked tankard `T` monogram in `public/brand/recommended/`. The bent rim and offset handle communicate improvised tavern craft without a mascot, shield, flame, crown, game UI, or protected reference. This direction is recommended because it works at favicon size, remains distinctive in one color, and leaves Issue #3 free to develop the mascot.

Two alternatives remain documented concept studies, not fallback production marks:

- `direction-a-noticeboard.svg`: crooked noticeboard and nail; editorial/community emphasis.
- `direction-b-tankard.svg`: recommended tankard monogram; strongest small-size identity.
- `direction-c-dumpster-lid.svg`: abstract hinged-lid `T`; more industrial and less warm.

## Color system

Canonical values live in `public/brand/tokens.json` and `public/brand/tokens.css`.

| Token | Hex | Role |
|---|---|---|
| Soot 950 | `#171512` | Primary dark background |
| Soot 800 | `#2B2721` | Raised dark surface |
| Parchment 100 | `#F4E7C5` | Primary light surface/text |
| Parchment 50 | `#FFF8E8` | High-key surface |
| Ale Gold 500 | `#D9A441` | Primary accent and large display |
| Dumpster Green 500 | `#4F7A57` | Secondary accent |
| Ember 500 | `#C85A3A` | Limited warning/emphasis |
| Ink 900 | `#211D18` | Text on light surfaces |

### Contrast matrix

Ratios are deterministic sRGB calculations from `scripts/validate-brand.ps1`; re-run after any token change.

| Foreground / background | Ratio | Allowed use |
|---|---:|---|
| Parchment 50 / Soot 950 | 17.22:1 | All text, AAA |
| Parchment 100 / Soot 950 | 14.82:1 | All text, AAA |
| Ale Gold 500 / Soot 950 | 8.10:1 | All text, AAA |
| Dumpster Green 500 / Soot 950 | 3.69:1 | Large text/icons only; not body text |
| Ember 500 / Soot 950 | 4.32:1 | Large text/icons only; not body text |
| Ink 900 / Parchment 50 | 15.83:1 | All text, AAA |
| Ink 900 / Parchment 100 | 13.63:1 | All text, AAA |

Never place body text in green or ember on soot. White/black substitutions require a fresh contrast check.

## Typography

- Primary UI/body: **Atkinson Hyperlegible**, with `Arial, sans-serif` fallback. Its open forms support mobile readability.
- Display/editorial: **Spectral**, with `Georgia, serif` fallback. Use for short headings and pull quotes, never dense UI labels.
- Use sentence case; body line height at least 1.5; no all-caps paragraphs; do not fake distressed letterforms.

Both families are recommended, not vendored. Their canonical source is Google Fonts and upstream SIL Open Font License 1.1 distribution. Exact package/version/license evidence must be captured in `ASSET_RIGHTS_REGISTER.md` before downloading, bundling, or production use; current rows remain `blocked`.

## Marks and exports

- Wordmark: horizontal use at 220px CSS width or greater; maintain clear space equal to monogram handle width.
- Simplified mark: 32px and larger; one-color form is preferred.
- Favicon: dedicated 32×32 geometry; do not auto-crop the wordmark.
- Social-safe: 1080×1080 with central 760px safe area; platform avatars may crop to circles.
- Minimum stroke: 2 CSS px on screen and vendor-confirmed minimum for print/embroidery.
- Never rotate, stretch, add glow/drop shadow, outline in multiple colors, place over busy texture, or combine with unofficial shields/crowns.

## Texture and imagery

### Founder-approved imagery direction

- Use raccoons/trash pandas only for character and lifestyle imagery. Do not use human figures, silhouettes, faces, hands, models, or human-led photography.
- Keep characters feral, scrappy, wary, mischievous, scavenged, and weathered. High-end execution describes craft quality, not regal subject matter.
- Avoid crowns, thrones, armor, capes, polished noble clothing, heraldic pageantry, royal poses, or fantasy-warrior shortcuts.
- Steve is the approved mascot direction. Additional character likenesses remain open until founder-supplied imagery passes rights, privacy, originality, and protected-reference review.

Texture is optional and subordinate: maximum 8% opacity behind text, no texture in clear space, and never encode meaning with texture alone. Use original wood grain, scratched iron, parchment, soot, dented tankards, paw-print abstractions, and damaged heraldry only after rights clearance. Do not imitate game art, interfaces, logos, characters, screenshots, marketing layouts, or generic esports neon.

## Concrete usage

Do:

- Use Parchment-on-Soot for reading surfaces and Gold for clear emphasis.
- Keep the mark flat, reproducible, and surrounded by quiet space.
- Use one controlled joke with one literal call to action.
- Test favicon, mobile header, monochrome, light/dark, and embroidery before approval.

Do not:

- Put green body text on soot or text over distressed imagery.
- Add mascot features to the tankard mark; Issue #3 owns character design.
- use flames, crowns, crossed weapons, aggressive animal eyes, or neon shield compositions as shortcuts.
- Generate with protected names, artists, franchises, screenshots, or reference assets.

## Website usage

- Use Parchment 50/100 and Soot 950 as primary reading surfaces; reserve texture for non-text decoration at no more than 8% opacity.
- Use Atkinson Hyperlegible for navigation, controls, forms, prices, and body copy; Spectral is limited to short headings and editorial pull quotes.
- Use the horizontal wordmark in headers at 220px or larger and the simplified mark below that threshold. Favicon uses only the dedicated favicon asset.
- Buttons use literal labels and visible focus states; Gold-on-Soot or Ink-on-Parchment are the default accessible combinations. Green/Ember are not body-text colors.
- Keep the legal disclaimer in mandatory locations, provide reduced-motion alternatives, and never load blocked fonts/assets in production.

## Merchandise usage

- Apparel uses a restrained front treatment: micro mark, tonal embroidery, or quiet left-chest Tavern identifier.
- The back may carry one considered Tavern-related illustration or composition. It must still feel wearable at normal social distance.
- Avoid oversized front logos, billboard slogans, sponsor layouts, event graphics, calls to action, URLs, QR codes, or promotional clutter.
- Favor premium heavyweight blanks, durable inks or stitching, limited colors, and product-detail evidence. A private concept is not vendor or sample approval.

- Start from one-color or two-color Tavern-only marks; verify vendor minimum line width, print area, color profile, and embroidery stitch limits for every product.
- Use the simplified mark for small embroidery and the wordmark only where its clear space and minimum size survive production.
- Product names, sizes, care, shipping, and returns remain literal; one short approved joke may follow factual copy.
- Every print file and mockup requires a cleared rights-register ID and sample review. Do not place the disclaimer in artwork unless legal review requires it, but include it on product/store policy surfaces.
- ALE-branded products and mascot merchandise remain blocked; concept mockups must visibly say `NOT FOR SALE — PROVISIONAL`.

## Animation usage

- Use palette and typography for title cards, captions, lower thirds, and end cards; characters themselves remain Issue #3 work.
- Captions use Atkinson fallback-safe styling, high-contrast Parchment-on-Soot, mobile-safe margins, and no texture behind text.
- The simplified mark may appear on end cards; keep it static or use reduced-motion-safe opacity transitions. Do not animate distortion, flames, or character features into the mark.
- Every font, sound, prop, background, and motion asset needs a cleared rights ID. Provisional brand and character assets may be used only in private review renders labeled `PROVISIONAL`.

## Social usage

- Use `social-safe.svg` for avatar studies and preserve its central crop-safe area; platform-specific exports require visual crop checks.
- Use one recognizable mark, one short headline, and one focal image per thumbnail. Keep captions/subtitles inside platform safe zones and readable without audio.
- Bios and link-in-bio pages carry the required unofficial-project disclaimer; post descriptions include it when the platform permits.
- Apply the channel voice rules in `VOICE_GUIDE.md`; never confirm private alliance events, quotes, or identities in replies.
- Nothing is posted, scheduled, or used as a live profile until IP/privacy review, rights clearance, Sentinel review, and founder publication approval are recorded.

## Blocked work

- **ALE badge and ALE-branded merchandise:** blocked until commercial-use authority is documented.
- **Mascot mark and final character interface:** blocked until Issue #3 originality review and founder roster/mascot approval.
- **Production font use:** blocked until exact package/version/license evidence is recorded.
- **Public or commercial use:** blocked until Sentinel review and founder identity-gate approval.

Required disclaimer placements remain defined in `IP_AND_PRIVACY_RULES.md`.
