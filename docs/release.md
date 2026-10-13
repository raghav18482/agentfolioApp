# Releasing Agentfolio

## Before the first store submission

1. **Backend** (MyFinancesMCP branch `feat/account-deletion-legal`): deploy it, so
   `/privacy`, `/terms`, `/risk-disclosure`, `/delete-account` and
   `DELETE /api/account` are live. Set `LEGAL_CONTACT_EMAIL` on the server.
2. **Legal review**: the four pages and the in-app risk disclosure
   (`lib/core/constants/disclaimers.dart`, `tradingRisk*`) are drafts. Have
   them reviewed, then remove the "Draft" banner in `legal/_base.html`.
3. **Turn on consent**: set `TERMS_URL` and `PRIVACY_URL` in
   `config/prod.json` (`https://agentfolio.in/terms`, `/privacy`). Sign-up then
   requires the consent checkbox, and Account → Legal links to both.
4. **Reviewer account**: stores need a working login. See
   `docs/store/reviewer-notes.md`; this needs a demo user with a fake broker
   on the backend (not built yet).
5. **iOS strategy** for App Store guideline 3.2.1(viii) (apps that trade must
   come from the licensed institution): decide whether the iOS build ships
   with trading turned off. See the plan, §12.2.

## Every release

```bash
scripts/build_release.sh android   # .aab for Play
scripts/build_release.sh ios       # .ipa for App Store Connect
```

The script runs codegen, analyze and every test, then builds with Dart
obfuscation (`--obfuscate --split-debug-info`) and `--strip`. Symbols land in
`build/symbols/<platform>`; **keep them** (attach to the release) or crashes
from that build can never be decoded.

Crash symbolication, three parts:
- **Dart**: the script uploads `build/symbols/*` with the Firebase CLI
  (`firebase crashlytics:symbols:upload`). Without the CLI it prints the
  command to run.
- **Android native/Java**: the Crashlytics Gradle plugin uploads the R8
  mapping during the release build.
- **iOS**: the "Upload Crashlytics symbols" build phase uploads the dSYM on
  every non-Debug build, and never fails the build if it cannot.

Bump `version:` in `pubspec.yaml` (`1.2.3+45`: name + build number; the build
number must increase for every upload).

## Checks before submitting

- [ ] `flutter analyze` clean, `flutter test` green (goldens included)
- [ ] Release build on a real Android phone and iPhone: sign in, Home, a stock,
      Agent, Trade (approve flow up to the device check, then cancel)
- [ ] App switcher shows the cover, not a portfolio
- [ ] App lock: turn on, background > 1 min, reopen → locked
- [ ] Account → Delete account against a throwaway account
- [ ] Hide balances masks amounts on every tab, including AI text
- [ ] Data safety (Play) and App Privacy (Apple) still match
      `docs/store/data-safety.md` and `ios/Runner/PrivacyInfo.xcprivacy`
