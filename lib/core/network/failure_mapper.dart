import 'package:agentfolio/core/error/failure.dart';
import 'package:dio/dio.dart';

/// Turns a [DioException] into the [Failure] the UI understands.
///
/// Every FastAPI endpoint answers errors as `{error: string}`, the auth ones
/// add `field`, and validation errors use `detail`. The server's text is kept
/// as the message, like the web client does.
Failure mapDioException(DioException e) {
  final isWrite = e.requestOptions.method.toUpperCase() != 'GET';
  switch (e.type) {
    case DioExceptionType.cancel:
      return const CancelledFailure();
    case DioExceptionType.connectionTimeout:
      // Never connected, so even a write is known not to have happened.
      return const TimeoutFailure();
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.badCertificate:
      return const NetworkFailure('The secure connection could not be verified.');
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
    case DioExceptionType.unknown:
      // The request may have reached the server. For a write, that is an
      // unknown outcome, never a plain failure the user would retry.
      if (isWrite) return const UnknownOutcomeFailure();
      return e.type == DioExceptionType.unknown ? const NetworkFailure() : const TimeoutFailure();
    case DioExceptionType.badResponse:
      return _fromResponse(e.response!);
  }
}

Failure _fromResponse(Response<dynamic> response) {
  final status = response.statusCode ?? 0;
  final body = response.data;
  final message = _message(body, status);
  final field = body is Map && body['field'] is String ? body['field'] as String : null;

  return switch (status) {
    401 => UnauthorizedFailure(message),
    403 => PremiumRequiredFailure(message),
    400 || 409 || 422 => ValidationFailure(message, field: field),
    404 => UnavailableFailure(message),
    429 => RateLimitedFailure(message, retryAfter: _retryAfter(response)),
    502 || 503 => BrokerFailure(message, statusCode: status),
    _ => ServerFailure(message, statusCode: status),
  };
}

String _message(Object? body, int status) {
  if (body is Map) {
    for (final key in const ['error', 'detail']) {
      final value = body[key];
      if (value is String && value.isNotEmpty) return value;
    }
  }
  // No message: usually the hosting gateway, not the app (a 502 while the
  // server restarts or a request outlives the proxy's limit).
  return switch (status) {
    502 || 503 || 504 => 'The server is busy or restarting. Try again in a moment.',
    >= 500 => 'Something went wrong on the server. Try again in a moment.',
    _ => 'Request failed ($status)',
  };
}

Duration? _retryAfter(Response<dynamic> response) {
  final seconds = int.tryParse(response.headers.value('retry-after') ?? '');
  return seconds == null ? null : Duration(seconds: seconds);
}
