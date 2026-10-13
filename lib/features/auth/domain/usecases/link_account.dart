import 'package:agentfolio/core/broker/broker_descriptor.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/domain/entities/link_account_request.dart';
import 'package:agentfolio/features/auth/domain/repositories/auth_repository.dart';

/// Links a broker account and sets the app password, after checking
/// everything the device can check. The server checks it all again; this
/// only saves a round trip, and a broker login, on an obvious mistake.
class LinkAccount {
  const LinkAccount(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call(LinkAccountRequest request, AuthConfig config) async {
    final problem =
        validateBrokerCredentials(request.broker, request.brokerCredentials) ??
        validateSignIn(
          phone: request.phone,
          appPassword: request.appPassword,
          appPasswordConfirm: request.appPasswordConfirm,
          minPasswordChars: config.minPasswordChars,
        );
    if (problem != null) return Err(problem);
    return await _repository.linkAccount(request);
  }
}

/// The first missing broker credential, named by its field key.
ValidationFailure? validateBrokerCredentials(BrokerDescriptor broker, Map<String, String> values) {
  for (final field in broker.credentialFields) {
    final value = values[field.key] ?? '';
    final length = field.kind == CredentialKind.secret ? value.length : value.trim().length;
    if (length < field.minLength) {
      return ValidationFailure('Enter your ${field.label}.', field: field.key);
    }
  }
  return null;
}

/// The sign-in half of linking: number, password length, and the two
/// passwords matching. Same rules and wording as the server.
ValidationFailure? validateSignIn({
  required PhoneNumber phone,
  required String appPassword,
  required String appPasswordConfirm,
  required int minPasswordChars,
}) {
  if (phone.isBlank) {
    return const ValidationFailure('Enter your WhatsApp number.', field: 'whatsapp_number');
  }
  if (appPassword.length < minPasswordChars) {
    return ValidationFailure(
      'Choose an app password of at least $minPasswordChars characters. '
      'It will be the only thing standing in front of your trading account.',
      field: 'app_password',
    );
  }
  if (appPassword != appPasswordConfirm) {
    return const ValidationFailure(
      'The two passwords do not match.',
      field: 'app_password_confirm',
    );
  }
  return null;
}
