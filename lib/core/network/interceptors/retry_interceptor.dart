import 'dart:math';

import 'package:dio/dio.dart';

/// Retries a failed GET once, after a short backoff.
///
/// Only reads are retried. Writes never are: approving a proposal places a
/// real order, and a write that timed out may already have succeeded. Rate
/// limits (429) and broker refusals (502/503) are not retried either, because
/// hammering the broker is what caused them. Nor is a receive timeout: the
/// server was reachable but slow, and asking again would double the wait.
class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._dio, {this.maxRetries = 1, Random? random}) : _random = random ?? Random();

  final Dio _dio;
  final int maxRetries;
  final Random _random;

  static const _attemptKey = 'retry_attempt';
  static const _retryableStatuses = {500, 504};

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    final attempt = (options.extra[_attemptKey] as int?) ?? 0;
    if (!_shouldRetry(err) || attempt >= maxRetries) return handler.next(err);

    await Future<void>.delayed(_backoff(attempt));
    if (options.cancelToken?.isCancelled ?? false) return handler.next(err);

    options.extra[_attemptKey] = attempt + 1;
    try {
      handler.resolve(await _dio.fetch<dynamic>(options));
    } on DioException catch (e) {
      handler.next(e);
    }
  }

  bool _shouldRetry(DioException err) {
    if (err.requestOptions.method.toUpperCase() != 'GET') return false;
    return switch (err.type) {
      DioExceptionType.connectionError || DioExceptionType.connectionTimeout => true,
      DioExceptionType.badResponse => _retryableStatuses.contains(err.response?.statusCode),
      _ => false,
    };
  }

  /// 600 ms, 1.2 s, … with ±20% jitter so many clients don't retry in lockstep.
  Duration _backoff(int attempt) {
    final base = 600 * pow(2, attempt);
    final jitter = 0.8 + _random.nextDouble() * 0.4;
    return Duration(milliseconds: (base * jitter).round());
  }
}
