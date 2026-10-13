import 'package:agentfolio/core/broker/broker_descriptor.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:meta/meta.dart';

/// Everything needed to link a broker account and set how the user signs in.
///
/// [brokerCredentials] is keyed by each `CredentialField.key` of the broker's
/// descriptor, so the same request shape works for any credential broker.
@immutable
class LinkAccountRequest {
  const LinkAccountRequest({
    required this.broker,
    required this.brokerCredentials,
    required this.phone,
    required this.appPassword,
    required this.appPasswordConfirm,
  });

  final BrokerDescriptor broker;
  final Map<String, String> brokerCredentials;
  final PhoneNumber phone;
  final String appPassword;
  final String appPasswordConfirm;

  /// Credentials tidied the way each field asks: identifiers and keys are
  /// trimmed and, where the broker treats them case-insensitively,
  /// upper-cased. Passwords and PINs are left exactly as typed.
  Map<String, String> get normalizedCredentials => {
    for (final field in broker.credentialFields)
      field.key: _normalize(field, brokerCredentials[field.key] ?? ''),
  };

  static String _normalize(CredentialField field, String value) {
    if (field.kind == CredentialKind.secret) return value;
    final trimmed = value.trim().replaceAll(RegExp(r'\s+'), '');
    return field.uppercase ? trimmed.toUpperCase() : trimmed;
  }
}

/// Which link-account field a server error belongs to, so the form can take
/// the user back to the right step and mark the right input.
enum LinkAccountField { brokerCredentials, phone, appPassword, appPasswordConfirm }

LinkAccountField? linkAccountFieldFor(String? serverField) => switch (serverField) {
  null => null,
  'whatsapp_number' || 'country_code' => LinkAccountField.phone,
  'app_password' => LinkAccountField.appPassword,
  'app_password_confirm' => LinkAccountField.appPasswordConfirm,
  _ => LinkAccountField.brokerCredentials,
};
