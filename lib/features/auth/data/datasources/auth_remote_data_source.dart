import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/network/json.dart';
import 'package:agentfolio/features/auth/data/models/auth_config_dto.dart';
import 'package:agentfolio/features/auth/data/models/session_dto.dart';

/// `/api/session/*` and `/api/auth/*`. One method per endpoint.
class AuthRemoteDataSource {
  AuthRemoteDataSource(this._api);

  final ApiClient _api;

  Future<SessionDto> fetchSession() => _api.get(
    '/api/session/bootstrap',
    decode: (json) => SessionDto.fromJson(asJsonMap(json)),
    // The first call after a backend restart logs in to the broker again,
    // which takes seconds, but launch must not hang on it for a minute.
    timeout: const Duration(seconds: 30),
  );

  Future<AuthConfigDto> fetchConfig() =>
      _api.get('/api/auth/config', decode: (json) => AuthConfigDto.fromJson(asJsonMap(json)));

  /// `200 {ok, client_id}` · `400 {error, field}` · `401` no match ·
  /// `429` throttled, with `Retry-After` · `502` broker rejected stored creds.
  Future<void> login({
    required String countryCode,
    required String whatsappNumber,
    required String appPassword,
  }) => _api.post(
    '/api/auth/login',
    body: {
      'country_code': countryCode,
      'whatsapp_number': whatsappNumber,
      'app_password': appPassword,
    },
    decode: ignoreBody,
    // A successful login also logs in to the broker.
    timeout: ApiTimeouts.slow,
  );

  /// `200 {ok, client_id}` · `400 {error, field?}` · `409` number taken.
  /// The server proves the credentials with the broker before storing them.
  Future<void> enroll(Map<String, String> body) =>
      _api.post('/api/auth/enroll', body: body, decode: ignoreBody, timeout: ApiTimeouts.slow);

  /// Deletes the account on the server, which also ends its session. The
  /// app password proves it is the owner, not just someone holding the phone.
  Future<void> deleteAccount(String appPassword) =>
      _api.delete('/api/account', body: {'app_password': appPassword}, decode: ignoreBody);

  /// Clears the device's cookies whether or not the server answered, so a
  /// failed request can never leave the user half signed-in.
  Future<void> logout() async {
    try {
      await _api.post('/api/auth/logout', decode: ignoreBody);
    } finally {
      await _api.clearCookies();
    }
  }
}
