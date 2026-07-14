# Merchandise plan

## Model

Fourthwall is the system of record for products, variants, checkout, payments, taxes, printing, fulfillment, shipping, and order handling. The custom site may display or link products only through a currently supported, documented method. No payment data is stored by The Tavern.

## Drop 01

Issue #6 develops ten concepts, refines five, and launches three across no more than five product types: premium T-shirt, hoodie, embroidered hat/beanie, mug/tumbler, and sticker pack.

Each selected design needs original source files, rights evidence, print specifications, mockups, light/dark behavior, product copy, sizing/care details, base cost, recommended price, estimated margin, production/shipping expectations, and sample review evidence.

### Provisional package

Canonical records are in `merch/drop-01/`. The package contains exactly ten scored concepts, five refinements, and three provisional selections: D01 Crooked Tankard, D02 Bad Plans Pennant, and D03 Structural Tab. Product types are capped at four: premium T-shirt, hoodie, mug, and sticker pack. Hat/beanie work is deferred; D10 is an unselected geometry study only.

The five refinements are D01, D02, D03, D05, and D09: the five highest scores. Score ties prefer fewer unresolved identity/character dependencies, then the stable order declared in `concepts.json`. D09 therefore ranks ahead of equally scored D05 because it depends on Issue #2 only, while D05 also depends on an Issue #3 character. Selection remains a separate portfolio decision: D01 brand mark, D02 copy-led rally mark, and conditional D03 character-led mark.

D01/D02 depend on Issue #2 founder and rights approval. D03 also depends on Issue #3 roster/mascot, name, similarity, and rights approval. All masters and mockups are internal production candidates, not approved print-ready or sale assets. Mockups are neutral placement evidence labeled `NOT FOR SALE — PROVISIONAL`.

The production manifest targets 300 DPI for future raster exports but blocks exports until the exact approved Fourthwall product provides print dimensions, file format, color profile, safe area, and other requirements. Vector masters do not waive vendor requirements.

### Pricing model

`pricing-scenarios.csv` calculates unit margin as sale price minus base/production cost, verified per-order fees, seller-funded discount, and shipping subsidy. Margin percentage is unit margin divided by sale price. Every current value is `TBD`; a row becomes verified only from the exact approved product/variant/settings with currency, region, evidence reference, and access date. Taxes and customer-paid shipping may be excluded only when dated vendor evidence confirms pass-through treatment. Scenario arithmetic is not a price, promise, or expected profit.

## Gates

Founder approval is required before connecting accounts, purchasing samples, changing products/prices, or opening sales. Samples must be received and approved for color, print/embroidery quality, sizing, and packaging before public sale. Do not use protected game assets.

Any ALE badge, name-forward design, or ALE-branded product is **BLOCKED** until the founder documents authority for commercial use. This does not block original Tavern-only concept work.

`merch/drop-01/SAMPLE_QA.md` is the mandatory spend, physical review, revision/resample, and founder release record. Issue #6 cannot be complete before physical sample evidence exists. Issue #10 still owns the public-sale go/no-go.
