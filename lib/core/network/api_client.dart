import 'dart:convert';

import 'package:agentfolio/core/network/interceptors/retry_interceptor.dart';
import 'package:agentfolio/core/network/interceptors/session_interceptor.dart';
import 'package:agentfolio/core/network/interceptors/telemetry_interceptor.dart';
import 'package:agentfolio/core/network/secure_cookie_storage.dart';
import 'package:agentfolio/core/session/session_expiry_signal.dart';
import 'package:agentfolio/core/storage/secure_store.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/time/server_clock.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';

/// How long a request may wait for its answer.
abstract final class ApiTimeouts {
  static const standard = Duration(seconds: 20);

  /// Endpoints that fetch history per holding (beta), and the first call after
  /// a backend restart, which logs in to the broker again.
  static const slow = Duration(seconds: 60);

  /// LLM-backed endpoints: insights, ask, research summary.
  static const ai = Duration(seconds: 90);

  /// An agent turn: the model calls tools (holdings, quotes, indicators) one
  /// after another before it answers, so it runs longer than a single call.
  static const agent = Duration(seconds: 150);
}

/// Decodes a JSON body into a typed value.
typedef JsonDecoder<T> = T Function(Object? json);

/// The single HTTP client. Data sources call this; nothing else touches Dio.
///
/// Methods throw [DioException] on failure. Repositories wrap calls in
/// `guardApi`, which turns that into a `Failure`.
class ApiClient {
  ApiClient._(this._dio, this._cookieJar);

  factory ApiClient.create({
    required String baseUrl,
    required SecureStore secureStore,
    required Telemetry telemetry,
    required SessionExpirySignal sessionExpiry,
    required ServerClock serverClock,
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: ApiTimeouts.standard,
        receiveTimeout: ApiTimeouts.standard,
        contentType: Headers.jsonContentType,
        headers: {'Accept': 'application/json'},
      ),
    );
    final cookieJar = PersistCookieJar(storage: SecureCookieStorage(secureStore));
    dio.interceptors.addAll([
      CookieManager(cookieJar),
      ServerClockInterceptor(serverClock),
      TelemetryInterceptor(telemetry),
      RetryInterceptor(dio),
      SessionInterceptor(sessionExpiry),
    ]);
    return ApiClient._(dio, cookieJar);
  }

  /// For tests: a client over a Dio whose adapter is faked.
  factory ApiClient.withDio(Dio dio) => ApiClient._(dio, CookieJar());

  final Dio _dio;
  final CookieJar _cookieJar;

  Future<T> get<T>(
    String path, {
    required JsonDecoder<T> decode,
    Map<String, Object?>? query,
    CancelToken? cancelToken,
    Duration? timeout,
  }) => _send(
    path,
    method: 'GET',
    decode: decode,
    query: query,
    cancelToken: cancelToken,
    timeout: timeout,
  );

  Future<T> post<T>(
    String path, {
    required JsonDecoder<T> decode,
    Object? body,
    CancelToken? cancelToken,
    Duration? timeout,
  }) => _send(
    path,
    method: 'POST',
    decode: decode,
    body: body,
    cancelToken: cancelToken,
    timeout: timeout,
  );

  Future<T> patch<T>(String path, {required JsonDecoder<T> decode, Object? body}) =>
      _send(path, method: 'PATCH', decode: decode, body: body);

  Future<T> delete<T>(String path, {required JsonDecoder<T> decode, Object? body}) =>
      _send(path, method: 'DELETE', decode: decode, body: body);

  /// Opens a long-lived `GET` whose body arrives as it is written (Server-Sent
  /// Events). Cookies authenticate it like any other request.
  ///
  /// An error answer is read in full first, so its `{error}` reaches the
  /// failure mapper instead of an unread stream.
  Future<Stream<List<int>>> openStream(
    String path, {
    Map<String, Object?>? query,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<ResponseBody>(
        path,
        queryParameters: query == null ? null : ({...query}..removeWhere((_, v) => v == null)),
        cancelToken: cancelToken,
        options: Options(
          responseType: ResponseType.stream,
          headers: {'Accept': 'text/event-stream'},
          // Silence is watched by the caller, which knows the heartbeat.
          receiveTimeout: Duration.zero,
        ),
      );
      return response.data!.stream;
    } on DioException catch (e) {
      final body = e.response?.data;
      if (e.type != DioExceptionType.badResponse || body is! ResponseBody) rethrow;
      final text = await utf8.decodeStream(body.stream).catchError((_) => '');
      Object? decoded;
      try {
        decoded = jsonDecode(text);
      } on FormatException {
        decoded = text;
      }
      throw e.copyWith(
        response: Response<Object?>(
          requestOptions: e.requestOptions,
          statusCode: e.response!.statusCode,
          headers: e.response!.headers,
          data: decoded,
        ),
      );
    }
  }

  /// Signs this device out locally. The server session is ended separately by
  /// the logout endpoint; this makes sure nothing is left behind if that fails.
  Future<void> clearCookies() => _cookieJar.deleteAll();

  Future<T> _send<T>(
    String path, {
    required String method,
    required JsonDecoder<T> decode,
    Map<String, Object?>? query,
    Object? body,
    CancelToken? cancelToken,
    Duration? timeout,
  }) async {
    final response = await _dio.request<Object?>(
      path,
      data: body,
      queryParameters: query == null ? null : ({...query}..removeWhere((_, v) => v == null)),
      cancelToken: cancelToken,
      options: Options(method: method, receiveTimeout: timeout),
    );
    return decode(response.data);
  }
}
