import 'dart:async';

/// Fired when any request learns the session has ended (a 401).
///
/// Many requests can fail at once when a session expires; the session layer
/// listens here and re-checks the session only once for the whole burst.
class SessionExpirySignal {
  final _controller = StreamController<void>.broadcast(sync: true);

  Stream<void> get stream => _controller.stream;

  void notify() => _controller.add(null);

  Future<void> dispose() => _controller.close();
}
