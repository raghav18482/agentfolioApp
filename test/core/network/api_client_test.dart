import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/network/guard_api.dart';
import 'package:agentfolio/core/network/interceptors/retry_interceptor.dart';
import 'package:agentfolio/core/network/interceptors/session_interceptor.dart';
import 'package:agentfolio/core/network/interceptors/telemetry_interceptor.dart';
import 'package:agentfolio/core/network/json.dart';
import 'package:agentfolio/core/session/session_expiry_signal.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import '../../helpers/recording_sink.dart';

void main() {
  late FakeHttpAdapter adapter;
  late ApiClient api;
  late RecordingSink sink;
  late SessionExpirySignal expiry;
  late int expiries;

  setUp(() async {
    adapter = FakeHttpAdapter((o) async => jsonBody({'ok': true}));
    final (telemetry, recording) = await recordingTelemetry();
    sink = recording;
    expiry = SessionExpirySignal();
    expiries = 0;
    expiry.stream.listen((_) => expiries++);

    final dio = Dio(BaseOptions(baseUrl: 'https://api.test'))..httpClientAdapter = adapter;
    dio.interceptors.addAll([
      TelemetryInterceptor(telemetry),
      RetryInterceptor(dio),
      SessionInterceptor(expiry),
    ]);
    api = ApiClient.withDio(dio);
  });

  Future<Result<JsonMap>> getJson(String path) => guardApi(() => api.get(path, decode: asJsonMap));

  Future<Result<JsonMap>> postJson(String path) =>
      guardApi(() => api.post(path, decode: asJsonMap));

  group('error mapping', () {
    Future<Failure> failureFor(
      int status,
      Object body, {
      Map<String, List<String>>? headers,
    }) async {
      adapter.handler = (o) async => jsonBody(body, status: status, headers: headers);
      return (await getJson('/api/x')).failureOrNull!;
    }

    test('keeps the server message and the field at fault', () async {
      final failure = await failureFor(400, {'error': 'Enter a valid number', 'field': 'phone'});
      expect(failure, isA<ValidationFailure>());
      expect(failure.message, 'Enter a valid number');
      expect((failure as ValidationFailure).field, 'phone');
    });

    test('falls back to `detail`, then to the status', () async {
      expect((await failureFor(404, {'detail': 'Not here'})).message, 'Not here');
      expect((await failureFor(418, {'other': 1})).message, 'Request failed (418)');
      // A gateway error has no body of the app's own: say it plainly.
      expect(
        (await failureFor(502, {'other': 1})).message,
        'The server is busy or restarting. Try again in a moment.',
      );
    });

    test('401 403 429 502 map to their own kinds', () async {
      expect(await failureFor(401, {'error': 'x'}), isA<UnauthorizedFailure>());
      expect(await failureFor(403, {'error': 'x'}), isA<PremiumRequiredFailure>());
      final limited = await failureFor(
        429,
        {'error': 'Slow down'},
        headers: {
          'retry-after': ['30'],
        },
      );
      expect((limited as RateLimitedFailure).retryAfter, const Duration(seconds: 30));
      expect(await failureFor(502, {'error': 'Broker said no'}), isA<BrokerFailure>());
    });

    test('a body of the wrong shape is a ParseFailure, not a crash', () async {
      adapter.handler = (o) async => jsonBody(['not', 'a', 'map']);
      expect((await getJson('/api/x')).failureOrNull, isA<ParseFailure>());
    });

    test('a write that loses its connection mid-flight has an unknown outcome', () async {
      adapter.handler = (o) =>
          throw DioException(requestOptions: o, type: DioExceptionType.receiveTimeout);
      expect(
        (await postJson('/api/trading/proposals/p1/approve')).failureOrNull,
        isA<UnknownOutcomeFailure>(),
      );
    });

    test('a write that never connected is a plain network failure', () async {
      adapter.handler = connectionError;
      expect((await postJson('/api/x')).failureOrNull, isA<NetworkFailure>());
    });
  });

  group('retries', () {
    test('a GET that cannot connect is retried once', () async {
      var attempt = 0;
      adapter.handler = (o) async {
        if (attempt++ == 0) connectionError(o);
        return jsonBody({'ok': true});
      };
      expect((await getJson('/api/x')).isSuccess, isTrue);
      expect(adapter.requests, hasLength(2));
    });

    test('gives up after one retry', () async {
      adapter.handler = connectionError;
      expect((await getJson('/api/x')).failureOrNull, isA<NetworkFailure>());
      expect(adapter.requests, hasLength(2));
    });

    test('writes are never retried', () async {
      adapter.handler = connectionError;
      await postJson('/api/trading/proposals/p1/approve');
      expect(adapter.requests, hasLength(1));
    });

    test('broker refusals and rate limits are not retried', () async {
      for (final status in [429, 502, 503]) {
        adapter.requests.clear();
        adapter.handler = (o) async => jsonBody({'error': 'no'}, status: status);
        await getJson('/api/x');
        expect(adapter.requests, hasLength(1), reason: 'HTTP $status');
      }
    });
  });

  group('session expiry', () {
    test('a 401 on a signed-in endpoint signals expiry', () async {
      adapter.handler = (o) async => jsonBody({'error': 'Not authenticated'}, status: 401);
      await getJson('/api/portfolio/analytics');
      expect(expiries, 1);
    });

    test('a 401 from /api/auth/* is a wrong password, not an expiry', () async {
      adapter.handler = (o) async => jsonBody({'error': 'Wrong password'}, status: 401);
      await postJson('/api/auth/login');
      expect(expiries, 0);
    });
  });

  group('telemetry', () {
    test('records method, path template and status, never the query', () async {
      await guardApi(
        () => api.get('/api/agent/threads/42', decode: asJsonMap, query: {'symbol': 'TCS'}),
      );
      final event = sink.named(EventName.apiRequested).single;
      expect(event.properties['method'], 'GET');
      expect(event.properties['path'], '/api/agent/threads/:id');
      expect(event.properties['status'], 200);
      expect(event.properties.toString(), isNot(contains('TCS')));
    });

    test('path templates collapse ids but keep words', () {
      expect(
        TelemetryInterceptor.pathTemplate('/api/trading/proposals/a1b2c3d4/approve'),
        '/api/trading/proposals/:id/approve',
      );
      expect(TelemetryInterceptor.pathTemplate('/api/agent/new-chat'), '/api/agent/new-chat');
      expect(TelemetryInterceptor.pathTemplate('/api/session/bootstrap'), '/api/session/bootstrap');
    });

    test('an unexpected 5xx is reported as an error', () async {
      adapter.handler = (o) async => jsonBody({'error': 'boom'}, status: 500);
      await getJson('/api/x');
      expect(sink.errors, isNotEmpty);
    });
  });
}
