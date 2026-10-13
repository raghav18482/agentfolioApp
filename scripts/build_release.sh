#!/usr/bin/env bash
# Builds store-ready release artefacts for one platform.
#
#   scripts/build_release.sh android     # → build/app/outputs/bundle/prodRelease/app-prod-release.aab
#   scripts/build_release.sh ios         # → build/ios/ipa/*.ipa (needs signing set up in Xcode)
#
# Dart code is obfuscated; its symbols go to build/symbols/<platform> and are
# uploaded to Crashlytics so stack traces stay readable. Keep that folder for
# every released build (CI artefact), or crashes from it cannot be decoded.
set -euo pipefail

platform="${1:?usage: build_release.sh android|ios}"
cd "$(dirname "$0")/.."

symbols="build/symbols/$platform"
common=(--release --flavor prod --dart-define-from-file=config/prod.json
        --obfuscate "--split-debug-info=$symbols" --extra-gen-snapshot-options=--strip)

flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter analyze
flutter test

case "$platform" in
  android)
    # Release signing comes from android/key.properties (never committed).
    if [ ! -f android/key.properties ]; then
      echo "android/key.properties is missing: this build would be signed with the debug key." >&2
      exit 1
    fi
    flutter build appbundle "${common[@]}"
    app_id="1:151342190258:android:f692758bdd8ec2460683ab"
    ;;
  ios)
    flutter build ipa "${common[@]}"
    app_id="1:151342190258:ios:61a708db3487ba290683ab"
    ;;
  *)
    echo "unknown platform: $platform" >&2
    exit 2
    ;;
esac

if command -v firebase >/dev/null; then
  firebase crashlytics:symbols:upload --app="$app_id" "$symbols"
else
  echo "firebase CLI not found: upload Dart symbols later with" >&2
  echo "  firebase crashlytics:symbols:upload --app=$app_id $symbols" >&2
fi
