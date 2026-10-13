import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/domain/entities/link_account_request.dart';
import 'package:agentfolio/features/auth/domain/entities/session.dart';

abstract interface class AuthRepository {
  /// Asks the server who this device is signed in as. Anonymous is an
  /// answer, not a failure; failures mean the server could not be asked.
  Future<Result<Session>> currentSession();

  /// Countries, the default dial code and the password rule. Static for the
  /// server's lifetime, so cached after the first answer.
  Future<Result<AuthConfig>> authConfig();

  /// Signs in. On success the device holds a session; ask [currentSession]
  /// for who it belongs to.
  Future<Result<void>> login({required PhoneNumber phone, required String appPassword});

  /// Verifies the broker credentials with the broker, stores them encrypted,
  /// sets the app password and signs in. Re-running it overwrites the stored
  /// credentials, which is also how a forgotten app password is reset.
  Future<Result<void>> linkAccount(LinkAccountRequest request);

  /// Permanently deletes the account after re-checking [appPassword]. A wrong
  /// password is a `ValidationFailure` on `app_password`; the session stays.
  Future<Result<void>> deleteAccount(String appPassword);

  /// Ends the session on the server and forgets it on this device. The
  /// device is signed out even if the server cannot be reached.
  Future<void> logout();
}
