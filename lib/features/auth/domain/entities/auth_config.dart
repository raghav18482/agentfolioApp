import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_config.freezed.dart';

/// A country in the dial-code picker.
@freezed
abstract class Country with _$Country {
  const factory Country({
    /// ISO 3166 alpha-2, e.g. `IN`.
    required String iso,

    /// Without the plus, e.g. `91`.
    required String dialCode,
    required String name,
  }) = _Country;

  const Country._();

  /// `+91`
  String get dialLabel => '+$dialCode';

  /// The country's flag, built from its ISO code's regional-indicator letters.
  String get flag => iso.length == 2
      ? String.fromCharCodes(iso.toUpperCase().codeUnits.map((c) => 0x1F1E6 + c - 0x41))
      : '';
}

/// What the login and link-account forms need: `GET /api/auth/config`.
@freezed
abstract class AuthConfig with _$AuthConfig {
  const factory AuthConfig({
    required List<Country> countries,
    required String defaultDialCode,
    required int minPasswordChars,
  }) = _AuthConfig;

  const AuthConfig._();

  Country get defaultCountry =>
      countries.firstWhere((c) => c.dialCode == defaultDialCode, orElse: () => countries.first);
}

/// A WhatsApp number as typed: a picked dial code plus the national part.
/// The server joins and normalises them, so spaces, dashes and a leading zero
/// are all fine.
@freezed
abstract class PhoneNumber with _$PhoneNumber {
  const factory PhoneNumber({required String dialCode, required String national}) = _PhoneNumber;

  const PhoneNumber._();

  bool get isBlank => national.trim().isEmpty;
}
