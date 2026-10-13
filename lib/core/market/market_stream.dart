import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/network/failure_mapper.dart';
import 'package:agentfolio/core/network/json_fields.dart';
import 'package:agentfolio/core/network/sse.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// One price update from `GET /api/market/stream`.
@immutable
class MarketTick {
  const MarketTick({
    required this.symbol,
    required this.price,
    required this.at,
    this.volume,
    this.bid,
    this.ask,
    this.fromFeed = true,
  });

  final String symbol;
  final double price;

  /// When this device received it: staleness is about what the user sees.
  final DateTime at;
  final double? volume;
  final double? bid;
  final double? ask;

  /// From the broker's WebSocket feed, rather than the server polling.
  final bool fromFeed;
}

enum StreamPhase {
  /// Nothing is being watched.
  idle,
  connecting,
  live,

  /// The connection dropped; trying again shortly.
  reconnecting,

  /// The server refused these symbols or the feed; not retried until the
  /// symbols change.
  unavailable,

  /// The app is in the background.
  paused,
}

@immutable
class StreamStatus {
  const StreamStatus(this.phase, {this.message});

  final StreamPhase phase;
  final String? message;
}

/// Opens the raw stream; replaced in tests.
typedef StreamOpener = Future<Stream<List<int>>> Function(
  Map<String, Object?> query,
  CancelToken cancel,
);

/// What a screen holds while it shows a live price. [cancel] it on dispose.
class LiveQuote {
  LiveQuote._(this._stream, this.symbol, this.tick);

  final MarketStream _stream;
  final String symbol;
  final ValueListenable<MarketTick?> tick;
  bool _cancelled = false;

  ValueListenable<StreamStatus> get status => _stream.status;

  void cancel() {
    if (_cancelled) return;
    _cancelled = true;
    _stream._release(symbol);
  }
}

/// The app's single live-price connection.
///
/// * Screens [watch] symbols; one Server-Sent Events stream carries them all.
///   The set is reference-counted, capped at the server's 12 (most recently
///   watched first), and changes are debounced so scrolling through stocks
///   does not churn the connection.
/// * A silent connection (no tick and no heartbeat for `idleTimeout`) is
///   replaced. Drops reconnect with exponential backoff.
/// * [pause] in the background, [resume] on return. Nothing watched, no
///   connection.
class MarketStream {
  MarketStream(ApiClient api, {Duration? debounce, Duration? idleTimeout, StreamOpener? opener})
    : _debounce = debounce ?? const Duration(milliseconds: 300),
      _idleTimeout = idleTimeout ?? const Duration(seconds: 45),
      _open =
          opener ??
          ((query, cancel) =>
              api.openStream('/api/market/stream', query: query, cancelToken: cancel));

  static const maxSymbols = 12;
  static final _log = Logger('MarketStream');

  final Duration _debounce;
  final Duration _idleTimeout;
  final StreamOpener _open;

  final ValueNotifier<StreamStatus> _status = ValueNotifier(const StreamStatus(StreamPhase.idle));
  ValueListenable<StreamStatus> get status => _status;

  final Map<String, _Watch> _watches = {};
  int _order = 0;
  bool _paused = false;

  Timer? _debounceTimer;
  Timer? _retryTimer;
  Timer? _idleTimer;
  int _attempt = 0;

  CancelToken? _cancel;
  StreamSubscription<String>? _subscription;
  List<String> _connectedSymbols = const [];
  final Map<String, String> _tokenToSymbol = {};

  /// Starts receiving [symbol]'s price. [brokerToken] lets the server skip a
  /// lookup when it is known.
  LiveQuote watch(String symbol, {String? brokerToken}) {
    final w = _watches.putIfAbsent(symbol, _Watch.new)
      ..count += 1
      ..order = ++_order;
    if (brokerToken != null && RegExp(r'^\d+$').hasMatch(brokerToken)) w.token = brokerToken;
    _scheduleReconnect();
    return LiveQuote._(this, symbol, w.tick);
  }

  void _release(String symbol) {
    final w = _watches[symbol];
    if (w == null) return;
    w.count -= 1;
    if (w.count <= 0) {
      _watches.remove(symbol);
      w.tick.dispose();
    }
    if (_watches.isEmpty) {
      // Nothing left to watch: close now rather than after the debounce. A
      // new watch in the same turn (switching stocks) still lands first.
      _debounceTimer?.cancel();
      scheduleMicrotask(_reconcile);
    } else {
      _scheduleReconnect();
    }
  }

  /// The symbols a connection should carry: the most recently watched.
  @visibleForTesting
  List<String> get wanted {
    final entries = _watches.entries.toList()
      ..sort((a, b) => b.value.order.compareTo(a.value.order));
    return [for (final e in entries.take(maxSymbols)) e.key]..sort();
  }

  void pause() {
    if (_paused) return;
    _paused = true;
    _debounceTimer?.cancel();
    _retryTimer?.cancel();
    _disconnect();
    if (_watches.isNotEmpty) _status.value = const StreamStatus(StreamPhase.paused);
  }

  void resume() {
    if (!_paused) return;
    _paused = false;
    _attempt = 0;
    _connectedSymbols = const [];
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(_debounce, _reconcile);
  }

  /// Brings the connection in line with what is wanted.
  void _reconcile() {
    if (_paused) return;
    final symbols = wanted;
    if (symbols.isEmpty) {
      _disconnect();
      _status.value = const StreamStatus(StreamPhase.idle);
      return;
    }
    // Already connected, or connecting, to exactly these.
    if (listEquals(symbols, _connectedSymbols) && (_subscription != null || _cancel != null)) {
      return;
    }
    _retryTimer?.cancel();
    _attempt = 0;
    unawaited(_connect(symbols));
  }

  Future<void> _connect(List<String> symbols) async {
    _disconnect();
    _connectedSymbols = symbols;
    _status.value = StreamStatus(_attempt == 0 ? StreamPhase.connecting : StreamPhase.reconnecting);
    final cancel = _cancel = CancelToken();
    final tokens = [for (final s in symbols) _watches[s]?.token ?? ''];
    try {
      final bytes = await _open({
        'symbols': symbols.join(','),
        if (tokens.any((t) => t.isNotEmpty)) 'tokens': tokens.join(','),
      }, cancel);
      if (cancel.isCancelled) return;
      final parser = SseParser();
      _armIdle();
      _subscription = bytes
          .cast<List<int>>()
          .transform(const Utf8Decoder(allowMalformed: true))
          .listen(
            (chunk) {
              _armIdle();
              parser.add(chunk).forEach(_onEvent);
            },
            onError: (Object e) => _onDrop(cancel, e),
            onDone: () => _onDrop(cancel, null),
            cancelOnError: true,
          );
    } on DioException catch (e) {
      if (cancel.isCancelled) return;
      final failure = mapDioException(e);
      switch (failure) {
        case CancelledFailure():
          return;
        case UnauthorizedFailure():
          // The session layer handles sign-out; nothing to retry.
          _status.value = StreamStatus(StreamPhase.unavailable, message: failure.message);
        case UnavailableFailure() || ValidationFailure():
          _status.value = StreamStatus(StreamPhase.unavailable, message: failure.message);
        default:
          _retryLater(failure.message);
      }
    } on Object catch (e) {
      if (!cancel.isCancelled) _retryLater(e.toString());
    }
  }

  void _onEvent(SseEvent event) {
    final Object? json;
    try {
      json = jsonDecode(event.data);
    } on FormatException {
      return;
    }
    if (json is! Map) return;
    switch (event.event) {
      case 'subscribed':
        _attempt = 0;
        _tokenToSymbol.clear();
        final unresolved = jsonStringList(json['unresolved']);
        for (final s in json['symbols'] is List ? json['symbols'] as List : const []) {
          if (s is! Map) continue;
          final token = jsonString(s['symboltoken']);
          final traded = jsonString(s['tradingsymbol']);
          // Match what was asked for, whatever form the server echoes back.
          final asked = _connectedSymbols.where((x) => x == traded || _watches[x]?.token == token);
          _tokenToSymbol[token] = asked.firstOrNull ?? traded;
        }
        _status.value = StreamStatus(
          StreamPhase.live,
          message: unresolved.isEmpty ? null : unresolved.join(', '),
        );
      case 'tick':
        final symbol = _tokenToSymbol[jsonString(json['symbol_token'])];
        final price = jsonNumOrNull(json['ltp']);
        if (symbol == null || price == null || price <= 0) return;
        _watches[symbol]?.tick.value = MarketTick(
          symbol: symbol,
          price: price,
          at: DateTime.now(),
          volume: jsonNumOrNull(json['volume']),
          bid: jsonNumOrNull(json['bid']),
          ask: jsonNumOrNull(json['ask']),
          fromFeed: json['source'] != 'poll',
        );
    }
  }

  void _armIdle() {
    _idleTimer?.cancel();
    _idleTimer = Timer(_idleTimeout, () {
      _log.info('No data for ${_idleTimeout.inSeconds}s; reconnecting');
      _onDrop(_cancel, 'idle');
    });
  }

  void _onDrop(CancelToken? which, Object? error) {
    if (which == null || which != _cancel || which.isCancelled) return;
    _retryLater(error?.toString());
  }

  void _retryLater(String? reason) {
    _disconnect(keepSymbols: true);
    if (_paused || _watches.isEmpty) return;
    _attempt += 1;
    final seconds = math.min(60, math.pow(2, _attempt).toInt());
    _log.info('Stream dropped ($reason); retrying in ${seconds}s');
    _status.value = const StreamStatus(StreamPhase.reconnecting);
    _retryTimer?.cancel();
    _retryTimer = Timer(Duration(seconds: seconds), () {
      if (!_paused && wanted.isNotEmpty) unawaited(_connect(wanted));
    });
  }

  void _disconnect({bool keepSymbols = false}) {
    _idleTimer?.cancel();
    _cancel?.cancel('replaced');
    _cancel = null;
    unawaited(_subscription?.cancel());
    _subscription = null;
    if (!keepSymbols) _connectedSymbols = const [];
  }

  void dispose() {
    _debounceTimer?.cancel();
    _retryTimer?.cancel();
    _disconnect();
    for (final w in _watches.values) {
      w.tick.dispose();
    }
    _watches.clear();
    _status.dispose();
  }
}

class _Watch {
  int count = 0;
  int order = 0;
  String? token;
  final tick = ValueNotifier<MarketTick?>(null);
}
