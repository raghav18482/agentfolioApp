import 'package:agentfolio/core/session/session_expiry_signal.dart';
import 'package:dio/dio.dart';

/// Tells the session layer when a signed-in request comes back 401: the
/// session ended mid-visit. A 401 from `/api/auth/*` is a wrong password,
/// not an expired session, so those are left alone.
class SessionInterceptor extends Interceptor {
  SessionInterceptor(this._signal);

  final SessionExpirySignal _signal;

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final path = err.requestOptions.path;
    if (err.response?.statusCode == 401 && !path.startsWith('/api/auth/')) _signal.notify();
    handler.next(err);
  }
}
