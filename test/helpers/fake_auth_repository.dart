import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/domain/entities/link_account_request.dart';
import 'package:agentfolio/features/auth/domain/entities/session.dart';
import 'package:agentfolio/features/auth/domain/repositories/auth_repository.dart';

const testAuthConfig = AuthConfig(
  countries: [
    Country(iso: 'IN', dialCode: '91', name: 'India'),
    Country(iso: 'GB', dialCode: '44', name: 'United Kingdom'),
  ],
  defaultDialCode: '91',
  minPasswordChars: 8,
);

/// An [AuthRepository] whose answers each test sets.
class FakeAuthRepository implements AuthRepository {
  Result<AuthConfig> configResult = const Success(testAuthConfig);
  Result<void> loginResult = const Success(null);
  Result<void> linkResult = const Success(null);
  Result<Session> sessionResult = const Success(Session.signedOut());

  final logins = <({PhoneNumber phone, String password})>[];
  final links = <LinkAccountRequest>[];
  int logouts = 0;

  @override
  Future<Result<AuthConfig>> authConfig() async => configResult;

  @override
  Future<Result<Session>> currentSession() async => sessionResult;

  @override
  Future<Result<void>> login({required PhoneNumber phone, required String appPassword}) async {
    logins.add((phone: phone, password: appPassword));
    return loginResult;
  }

  @override
  Future<Result<void>> linkAccount(LinkAccountRequest request) async {
    links.add(request);
    return linkResult;
  }

  Result<void> deleteResult = const Success(null);
  final deletions = <String>[];

  @override
  Future<Result<void>> deleteAccount(String appPassword) async {
    deletions.add(appPassword);
    return deleteResult;
  }

  @override
  Future<void> logout() async => logouts++;
}

Err<void> failWith(Failure failure) => Err(failure);
