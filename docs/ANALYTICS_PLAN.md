# Analytics plan — inactive proposal

No analytics provider, script, cookie, identifier, or event transport is active. Activation requires founder approval of provider, consent model, retention, access, jurisdiction and privacy text.

## Event dictionary

| Event | Trigger | Allowed properties | Prohibited data |
|---|---|---|---|
| `nav_select` | Primary/footer navigation activation | destination route, placement | user/member ID, query/free text |
| `cta_select` | Approved CTA activation | CTA ID, destination, placement | names, message content |
| `view_merch` | Product card/detail visible | public product ID, placement | cart/payment/customer data |
| `fourthwall_handoff` | User activates outbound store link | public product ID, placement | referrer query, customer identity |
| `view_tale` | Tale detail rendered | public tale ID | submission/source identity |
| `play_tale` | User starts approved media | public tale ID, caption state | IP address override, member data |
| `view_character` | Character detail rendered | approved character ID | real-person mapping |
| `incident_form_unavailable` | Disabled intake notice viewed | placement | any incident/free text |
| `email_signup_start` | Approved provider flow starts | placement | email address |
| `email_signup_result` | Approved provider returns status | success/error code class | email, provider response body |
| `social_handoff` | Approved social link activated | platform, placement | profile visitor identity |
| `legal_view` | Legal/support page rendered | document type, version | user identity |
| `form_error` | Approved form validation fails | form ID, field key, error code | entered value/free text |

Events use allowlisted enums, never URLs containing query strings. No precise location, member/account identifiers, coordinates, private content, quotes, form values, consent records, fingerprinting or cross-site profiles. Development logs follow the same restrictions. Consent denial must prevent nonessential transport without degrading core access.
