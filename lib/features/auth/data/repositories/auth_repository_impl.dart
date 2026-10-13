import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/network/guard_api.dart';
import 'package:agentfolio/features/accounts/domain/entities/broker_account.dart';
import 'package:agentfolio/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:agentfolio/features/auth/data/models/session_dto.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/domain/entities/link_account_request.dart';
import 'package:agentfolio/features/auth/domain/entities/session.dart';
import 'package:agentfolio/features/auth/domain/repositories/auth_repository.dart';
import 'package:logging/logging.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote, this._cache);

  final AuthRemoteDataSource _remote;
  final RequestCache _cache;
  static final _log = Logger('AuthRepository');

  /// The config only changes with a server deploy.
  static const _configTtl = Duration(hours: 12);

  @override
  Future<Result<Session>> currentSession() async =>
      (await guardApi(_remote.fetchSession)).map(_toSession);

  @override
  Future<Result<AuthConfig>> authConfig() => guardApi(
    () => _cache.fetch(
      'auth/config',
      ttl: _configTtl,
      load: () async => (await _remote.fetchConfig()).toEntity(),
      shouldCache: (config) => config.countries.isNotEmpty,
    ),
  );

  @override
  Future<Result<void>> login({required PhoneNumber phone, required String appPassword}) => guardApi(
    () => _remote.login(
      countryCode: phone.dialCode,
      whatsappNumber: phone.national.trim(),
      appPassword: appPassword,
    ),
  );

  @override
  Future<Result<void>> linkAccount(LinkAccountRequest request) => guardApi(
    () => _remote.enroll({
      ...request.normalizedCredentials,
      'country_code': request.phone.dialCode,
      'whatsapp_number': request.phone.national.trim(),
      'app_password': request.appPassword,
      'app_password_confirm': request.appPasswordConfirm,
    }),
  );

  @override
  Future<Result<void>> deleteAccount(String appPassword) async {
    final result = await guardApi(() => _remote.deleteAccount(appPassword));
    return switch (result) {
      // The endpoint is not deployed yet: say so, rather than "Not Found".
      Err(failure: UnavailableFailure()) => const Err(
        UnavailableFailure(
          'Account deletion is not available yet. Try again after the next update.',
        ),
      ),
      _ => result,
    };
  }

  @override
  Future<void> logout() async {
    final result = await guardApi(_remote.logout);
    if (result.failureOrNull case final failure?) {
      // Cookies are already gone, so the device is signed out regardless.
      // The server session ends on its own when it expires.
      _log.info('Server logout failed (${failure.message}); signed out locally');
    }
  }

  /// Today's bootstrap describes one user with one Angel One account, both
  /// identified by the broker client code. The domain already models a user
  /// with many accounts, so only this mapping changes when the backend does.
  static Session _toSession(SessionDto dto) {
    final clientId = dto.clientId;
    if (!dto.authenticated || clientId == null || clientId.isEmpty) {
      return const Session.signedOut();
    }
    final account = BrokerAccount(
      id: clientId,
      brokerId: BrokerRegistry.defaultBrokerId,
      clientCode: clientId,
    );
    return Session.signedIn(
      user: AppUser(
        id: clientId,
        premium: PremiumStatus(
          registered: dto.premium?.registered ?? false,
          whatsappNumber: dto.premium?.whatsappNumber,
        ),
      ),
      accounts: [account],
      activeAccountId: account.id,
    );
  }
}
