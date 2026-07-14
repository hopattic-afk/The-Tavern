# Incident submission system — local NO COLLECTION design

Status: **NO COLLECTION**. Provider, region, operator identity, legal jurisdiction, consent text, retention durations, withdrawal channel and breach contacts are all `TBD`. The site and internal prototype contain no form action, endpoint, script, storage, analytics or live submission control.

## Architecture

After separate founder approvals, a public-safe UI would send directly over TLS to a restricted provider with server-side validation, rate/spam protection and request-body logging disabled. The provider would create an opaque random incident ID, versioned consent evidence and timestamps. Narrative, identity/contact and consent evidence should be separated where supported. Raw data never enters Git, public builds, analytics, application logs or issue trackers.

An intake custodian quarantines and minimizes; a privacy reviewer verifies per-person name/likeness and per-speaker quote permissions, then independently authors `generalizedEvent`, `reviewedWhyFunny`, and `paraphrasedPunchline`. Writer briefs are created only from those reviewed fields and never from raw `whatHappened`, `whyFunny`, identities, or submitted punchlines. Writers receive only the `writer-brief.schema.json` fields. A submitter cannot grant third-party rights without recorded proof/direct confirmation. Fictional dialogue is adaptation, never a real quotation.

## Roles and status

`incident-system/policy.json` is canonical for transitions and least-privilege roles. Submitters create/withdraw their own record; custodians triage raw records; privacy reviewers redact/approve/reject/withdraw; writers read minimized briefs only; animators read approved scripts; publishers read approved public packages; administrators configure but do not routinely read content; Sentinel sees redacted audit evidence. Named accounts, MFA where supported, access review, audit logs and break-glass review are provider requirements.

No status can jump from `received` to writing/publication. Every active unpublished status, including `approved` and `scheduled`, permits immediate transition to `withdrawn`; this freezes downstream use and triggers deletion/anonymization under the approved policy. `published` can transition only to `takedown-review`; do not falsely promise deletion from caches/copies.

## Rejection and privacy review

Reject/quarantine credentials, account details, coordinates, live strategy, private-message dumps, harassment/threats, sensitive/minor/sexual content, doxxing, protected game media, unverifiable allegations, unapproved identifiable people/quotes, and material that cannot be safely anonymized. Initial scope has no uploads or links.

Review: adaptation consent mandatory; submitter name/quote checkboxes are requests, never proof. Only privacy-reviewer-derived `verified-parties` and `verified-speakers` states may permit names or exact quotes. A private-event or change-identities flag always forces anonymization and paraphrase. Coordinates/account/strategy/contact values are rejected before handoff; timing/location is generalized; the writer brief contains no contact/raw/consent fields; withdrawal state is checked before every handoff.

## Retention, withdrawal, breach and provider gates

All numeric durations remain `TBD` in policy until founder/legal approval. The eventual system must automate expiry and distinguish active records, derived briefs, backups, audit evidence and legal hold. Withdrawal uses opaque high-entropy token plus approved verification without revealing arbitrary record existence. Lost-token recovery requires privacy review.

On suspected breach: disable intake, preserve restricted evidence, notify founder/privacy owner, contain access, assess provider/records/region, follow approved legal notification obligations, rotate credentials only with authority, process deletions/corrections and document remediation. Never copy raw data into Git or chat.

Provider rubric: data region/subprocessors, encryption, MFA/RBAC/audit, no body logging, export/correction/delete, automated retention/backups, breach terms, abuse controls, accessibility, availability, cost, DPA/legal fit and tested withdrawal. Every value/provider remains `TBD`.

## Approval gates

1. Founder/legal approve operator/jurisdiction, exact privacy/consent text, numeric retention, withdrawal promises and breach process.
2. Founder approves provider/region/subprocessors/cost/access and any purchase.
3. Sentinel validates schema, state/RBAC, threat model and synthetic tests.
4. Founder separately approves accounts, credentials and private integration preview.
5. Synthetic-only end-to-end test; founder explicitly approves activation. Real collection remains off until then.
6. #7 receives only approved minimized briefs; #9 only approved public-safe packages; #10 controls public launch.
