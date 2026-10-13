# Store privacy answers

Answers for Google Play's **Data safety** form and Apple's **App Privacy**
labels, taken from what the code does. Keep in step with
`ios/Runner/PrivacyInfo.xcprivacy` and the privacy policy.

General:
- Data is encrypted in transit: **yes** (HTTPS only).
- Users can request deletion: **yes**, in the app (Account → Delete account) and
  at `https://agentfolio.in/delete-account`.
- Data sold: **no**. Used for ads or tracking across apps: **no** (no IDFA, no
  App Tracking Transparency prompt needed).

| Data | Play category | Apple category | Collected | Shared* | Purpose | Optional |
|---|---|---|---|---|---|---|
| WhatsApp number | Personal info → Phone number | Contact info → Phone number | Yes | WhatsApp delivery service | Account, app functionality | No |
| Broker credentials (API key, client ID, PIN, TOTP secret) | Financial info → Other | Financial info → Other | Yes, encrypted | Broker (Angel One) | App functionality | No |
| Holdings, positions, orders, funds | Financial info → Other | Financial info → Other | Read live, not stored | AI provider (OpenRouter), as a summary | App functionality | No |
| Saved AI conversations | Messages → Other in-app messages | User content → Other | Yes (Premium) | AI provider | App functionality | Yes |
| Risk profile, brief schedule | Financial info → Other | Financial info → Other | Yes | — | App functionality | Yes |
| Crash reports | App info → Crash logs | Diagnostics → Crash data | Yes | Firebase (Google) | Stability | No |
| Screens, taps | App activity → App interactions | Usage data → Product interaction | Yes | Firebase (Google) | Analytics | **Yes** (Account → Privacy) |
| Request timings | App info → Diagnostics | Diagnostics → Performance data | Yes | Firebase (Google) | Analytics | Yes |
| Hashed account id | Device or other IDs | Identifiers → User ID | Yes | Firebase (Google) | Analytics, stability | No |

\* "Shared" in Play's sense means sent to a third party. Service providers
acting for us (hosting, database, Crashlytics) can be declared as not shared
under Play's service-provider exemption; the AI provider and broker receive
data to perform what the user asked for.

Not collected: location, contacts, photos, files, audio, health, browsing
history, advertising ID, payment card data.

Play **Financial features** declaration: the app shows portfolio data from a
third-party broker and can place orders through it after the user approves.
It is not itself a broker, lender or payment service.
