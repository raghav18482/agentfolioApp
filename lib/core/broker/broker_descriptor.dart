import 'package:meta/meta.dart';

/// A broker's stable identifier, as the backend names it (`angel_one`).
extension type const BrokerId(String value) implements Object;

/// How a broker account is linked.
enum BrokerAuthMethod {
  /// The user types credentials into a form, which the backend verifies with
  /// the broker and stores encrypted (Angel One).
  credentials,

  /// The user signs in on the broker's own page and is redirected back
  /// (Zerodha, Upstox). Tokens typically expire daily.
  oauth,
}

/// What kind of input a credential field is. Drives keyboard, obscuring,
/// autofill and the paste affordance.
enum CredentialKind {
  /// An identifier the user can see: client id, user id.
  identifier,

  /// A long generated key, usually pasted: API key.
  apiKey,

  /// A password or PIN.
  secret,

  /// A base32 TOTP seed, always pasted.
  totpSecret,
}

/// One field of a broker's link-account form.
@immutable
class CredentialField {
  const CredentialField({
    required this.key,
    required this.label,
    required this.kind,
    this.hint,
    this.helpText,
    this.uppercase = false,
    this.minLength = 1,
  });

  /// The JSON key the backend expects, e.g. `totp_secret`.
  final String key;
  final String label;
  final CredentialKind kind;

  /// Placeholder inside the field.
  final String? hint;

  /// Shown under the field: where to find this value.
  final String? helpText;

  /// Client ids are case-insensitive at the broker, but users type them in
  /// mixed case. Normalised before sending.
  final bool uppercase;
  final int minLength;

  bool get obscured => kind == CredentialKind.secret || kind == CredentialKind.totpSecret;

  bool get pasteFriendly => kind == CredentialKind.apiKey || kind == CredentialKind.totpSecret;
}

/// What a broker integration can do. Screens check these rather than the
/// broker's name, so a new broker with fewer features degrades gracefully.
@immutable
class BrokerCapabilities {
  const BrokerCapabilities({
    required this.holdings,
    required this.trading,
    required this.liveStream,
    required this.candles,
  });

  final bool holdings;

  /// Orders can be placed (proposal approval). Also gated by a store-policy
  /// flag on platforms where execution is turned off.
  final bool trading;

  /// Live ticks over the market stream. Without it, prices come from polling.
  final bool liveStream;

  /// Historical OHLC for charts and indicators.
  final bool candles;
}

/// Everything the app knows about one broker. Adding a broker means adding
/// one of these and registering it in `BrokerRegistry`; no screen changes.
@immutable
class BrokerDescriptor {
  const BrokerDescriptor({
    required this.id,
    required this.displayName,
    required this.authMethod,
    required this.credentialFields,
    required this.capabilities,
    this.accountOpeningUrl,
    this.developerPortalUrl,
    this.credentialsGuidePath,
  });

  final BrokerId id;

  /// Used in all copy: "Live from Angel One", "Angel One rejected…".
  final String displayName;
  final BrokerAuthMethod authMethod;

  /// Form fields for [BrokerAuthMethod.credentials]; empty for OAuth.
  final List<CredentialField> credentialFields;
  final BrokerCapabilities capabilities;

  /// "Don't have an account?" link.
  final Uri? accountOpeningUrl;

  /// Where the user creates API credentials.
  final Uri? developerPortalUrl;

  /// Agentfolio's own step-by-step guide, relative to the web base URL.
  final String? credentialsGuidePath;
}
