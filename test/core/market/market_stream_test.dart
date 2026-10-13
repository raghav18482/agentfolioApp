import 'dart:async';
import 'dart:convert';

import 'package:agentfolio/core/market/market_stream.dart';
import 'package:agentfolio/core/network/api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// A fake server: records each connection and lets the test write frames.
class _Server {
  final connections = <({Map<String, Object?> query, StreamController<List<int>> body})>[];
  DioException? refuseWith;

  Future<Stream<List<int>>> open(Map<String, Object?> query, CancelToken cancel) async {
    if (refuseWith case final e?) throw e;
    final body = StreamController<List<int>>();
    cancel.whenCancel.then((_) => body.close()).ignore();
    connections.add((query: query, body: body));
    return body.stream;
  }

  void send(String event, Map<String, Object?> data, {int connection = -1}) {
    final c = connection < 0 ? connections.last : connections[connection];
    c.body.add(utf8.encode('event: $event\ndata: ${jsonEncode(data)}\n\n'));
  }

  void subscribed(List<(String, String)> symbols) => send('subscribed', {
    'symbols': [
      for (final (s, t) in symbols) {'tradingsymbol': s, 'symboltoken': t},
    ],
    'unresolved': <String>[],
  });
}

void main() {
  late _Server server;
  late MarketStream stream;

  setUp(() {
    server = _Server();
    stream = MarketStream(
      ApiClient.withDio(Dio()),
      debounce: const Duration(milliseconds: 10),
      idleTimeout: const Duration(milliseconds: 200),
      opener: server.open,
    );
  });

  tearDown(() => stream.dispose());

  Future<void> wait([int ms = 30]) => Future<void>.delayed(Duration(milliseconds: ms));

  test('one connection for every symbol watched, ticks routed by token', () async {
    final tcs = stream.watch('TCS-EQ', brokerToken: '11536');
    final infy = stream.watch('INFY-EQ');
    await wait();
    expect(server.connections, hasLength(1));
    expect(server.connections.single.query, {'symbols': 'INFY-EQ,TCS-EQ', 'tokens': ',11536'});

    server
      ..subscribed([('INFY-EQ', '1594'), ('TCS-EQ', '11536')])
      ..send('tick', {'symbol_token': '11536', 'ltp': 3500.5, 'source': 'ws'});
    await wait();
    expect(stream.status.value.phase, StreamPhase.live);
    expect(tcs.tick.value?.price, 3500.5);
    expect(infy.tick.value, isNull);
    tcs.cancel();
    infy.cancel();
  });

  test('watching the same symbol twice shares it; the last cancel closes', () async {
    final a = stream.watch('TCS-EQ');
    final b = stream.watch('TCS-EQ');
    await wait();
    a.cancel();
    await wait();
    expect(server.connections, hasLength(1));
    b.cancel();
    await wait();
    expect(stream.status.value.phase, StreamPhase.idle);
    expect(server.connections.single.body.isClosed, isTrue);
  });

  test('quick changes are debounced into one reconnect', () async {
    final a = stream.watch('A');
    final b = stream.watch('B');
    final c = stream.watch('C');
    await wait();
    expect(server.connections, hasLength(1));
    expect(server.connections.single.query['symbols'], 'A,B,C');
    for (final q in [a, b, c]) {
      q.cancel();
    }
  });

  test('at most twelve symbols, the most recently watched', () async {
    final quotes = [for (var i = 0; i < 14; i++) stream.watch('S$i')];
    await wait();
    final asked = (server.connections.last.query['symbols']! as String).split(',');
    expect(asked, hasLength(MarketStream.maxSymbols));
    expect(asked, isNot(contains('S0')));
    expect(asked, contains('S13'));
    for (final q in quotes) {
      q.cancel();
    }
  });

  test('a silent connection is replaced', () async {
    final q = stream.watch('TCS-EQ');
    await wait();
    server.subscribed([('TCS-EQ', '1')]);
    await wait(250); // past the idle timeout, no heartbeat
    expect(stream.status.value.phase, StreamPhase.reconnecting);
    q.cancel();
  });

  test('symbols the server cannot resolve are not retried', () async {
    server.refuseWith = DioException(
      requestOptions: RequestOptions(path: '/api/market/stream'),
      type: DioExceptionType.badResponse,
      response: Response(
        requestOptions: RequestOptions(path: '/api/market/stream'),
        statusCode: 404,
        data: {'error': 'Could not resolve any of: NOPE'},
      ),
    );
    final q = stream.watch('NOPE');
    await wait();
    expect(stream.status.value.phase, StreamPhase.unavailable);
    expect(stream.status.value.message, contains('NOPE'));
    q.cancel();
  });

  test('backgrounding closes the stream; returning reopens it', () async {
    final q = stream.watch('TCS-EQ');
    await wait();
    stream.pause();
    await wait();
    expect(stream.status.value.phase, StreamPhase.paused);
    expect(server.connections.single.body.isClosed, isTrue);
    stream.resume();
    await wait();
    expect(server.connections, hasLength(2));
    q.cancel();
  });
}
