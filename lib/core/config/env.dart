import 'package:flutter/services.dart' show appFlavor;

/// Which build this is.
enum Flavor { dev, prod }

/// Build-time configuration. Nothing here is secret: it ships inside the app.
class Env {
  const Env({
    required this.flavor,
    required this.apiBaseUrl,
    required this.webBaseUrl,
    required this.crashlyticsEnabled,
    this.termsUrl,
    this.privacyUrl,
  });

  /// Reads the values passed with `--dart-define-from-file`.
  ///
  /// The flavor itself comes from the native build (`--flavor`), because that
  /// decides the bundle ID and the Firebase app. The config file must agree:
  /// see [resolveFlavor].
  factory Env.fromEnvironment() => Env(
    flavor: resolveFlavor(
      native: appFlavor,
      configured: const bool.hasEnvironment('FLAVOR')
          ? const String.fromEnvironment('FLAVOR')
          : null,
    ),
    apiBaseUrl: const String.fromEnvironment('API_BASE_URL', defaultValue: 'https://agentfolio.in'),
    webBaseUrl: const String.fromEnvironment('WEB_BASE_URL', defaultValue: 'https://agentfolio.in'),
    crashlyticsEnabled: const bool.fromEnvironment('CRASHLYTICS_ENABLED', defaultValue: true),
    termsUrl: _optionalUri(const String.fromEnvironment('TERMS_URL')),
    privacyUrl: _optionalUri(const String.fromEnvironment('PRIVACY_URL')),
  );

  static Uri? _optionalUri(String value) => value.isEmpty ? null : Uri.tryParse(value);

  /// The build's flavor, from the native flavor ([native]) and the config
  /// file's `FLAVOR` ([configured]).
  ///
  /// When both are given they must match. `--flavor dev` with
  /// `config/prod.json` would be the dev app, reporting to the dev Firebase
  /// app, while talking to the production API. That is a build mistake, so it
  /// fails on launch instead of quietly mixing the two.
  ///
  /// With neither, the build is prod, so a forgotten flag never points an app
  /// at a developer's laptop.
  static Flavor resolveFlavor({required String? native, required String? configured}) {
    final nativeFlavor = _parse(native, source: '--flavor');
    final configFlavor = _parse(configured, source: 'FLAVOR in the config file');
    if (nativeFlavor != null && configFlavor != null && nativeFlavor != configFlavor) {
      throw StateError(
        'Build flavor mismatch: --flavor ${nativeFlavor.name} with '
        'config/${configFlavor.name}.json. Pass the same flavor to both, e.g. '
        '`flutter run --flavor dev --dart-define-from-file=config/dev.json`.',
      );
    }
    return nativeFlavor ?? configFlavor ?? Flavor.prod;
  }

  static Flavor? _parse(String? value, {required String source}) {
    if (value == null || value.isEmpty) return null;
    for (final flavor in Flavor.values) {
      if (flavor.name == value) return flavor;
    }
    throw StateError('Unknown flavor "$value" from $source; expected dev or prod.');
  }

  final Flavor flavor;

  /// The FastAPI backend every `/api/*` call goes to.
  final String apiBaseUrl;

  /// Public pages (guides, legal) opened in the in-app browser.
  final String webBaseUrl;

  /// Off in dev so test crashes never mix with production reports.
  final bool crashlyticsEnabled;

  /// Published Terms and Privacy Policy. Until both exist, sign-up shows no
  /// consent checkbox: agreeing to a page that does not exist means nothing.
  /// Once they are set, the checkbox appears and is required.
  final Uri? termsUrl;
  final Uri? privacyUrl;

  bool get hasLegalPages => termsUrl != null && privacyUrl != null;

  bool get isDev => flavor == Flavor.dev;

  Uri webPage(String path) => Uri.parse(webBaseUrl).resolve(path);
}
