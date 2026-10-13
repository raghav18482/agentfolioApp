/// An in-memory response cache with time-to-live and in-flight sharing.
///
/// * **TTL**: a value younger than its TTL is returned without a request.
/// * **De-duplication**: callers asking for the same key while a request is in
///   flight all await that one request.
/// * **Stale-while-revalidate**: [peek] returns the last value even when
///   stale, so a screen can paint it at once while [fetch] refreshes.
/// * **Account scope**: keys are prefixed with [scope], so two broker accounts
///   can never read each other's entries.
///
/// Shared loads are deliberately not cancellable. If a screen that started a
/// load goes away, the load still finishes and fills the cache for whoever
/// asks next. Screens ignore results they no longer want instead.
class RequestCache {
  RequestCache({DateTime Function()? clock}) : _now = clock ?? DateTime.now;

  final DateTime Function() _now;
  final Map<String, _Entry> _entries = {};
  final Map<String, Future<Object?>> _inFlight = {};

  /// Bumped by [clear]. A load that started before a clear must not write
  /// into the cache afterwards: it belongs to the previous user.
  int _generation = 0;

  /// The active broker account, or `anon` before sign-in.
  String scope = 'anon';

  String _key(String key) => '$scope|$key';

  /// The cached value for [key] if fresh, else the result of [load].
  ///
  /// [force] skips the freshness check (pull-to-refresh) but still shares an
  /// in-flight request. [shouldCache] lets a caller refuse to keep a value,
  /// e.g. an empty answer the server may fill in a moment later.
  Future<T> fetch<T>(
    String key, {
    required Duration ttl,
    required Future<T> Function() load,
    bool force = false,
    bool Function(T value)? shouldCache,
  }) {
    final scoped = _key(key);
    final entry = _entries[scoped];
    if (!force && entry != null && _now().difference(entry.storedAt) < ttl) {
      return Future.value(entry.value as T);
    }

    final pending = _inFlight[scoped];
    if (pending != null) return pending.then((value) => value as T);

    final generation = _generation;
    final future = load().then((value) {
      if (generation == _generation && (shouldCache?.call(value) ?? true)) {
        _entries[scoped] = _Entry(value, _now());
      }
      return value;
    });
    _inFlight[scoped] = future;
    // Remove the in-flight marker however the load ends, unless a clear has
    // already replaced it with a newer load. The error itself propagates to
    // callers through `future`.
    future.whenComplete(() {
      _inFlight.removeWhere((key, value) => key == scoped && identical(value, future));
    }).ignore();
    return future;
  }

  /// The last value stored for [key], fresh or not.
  T? peek<T>(String key) => _entries[_key(key)]?.value as T?;

  /// When [key] was last stored, for "Updated 3m ago".
  DateTime? storedAt(String key) => _entries[_key(key)]?.storedAt;

  /// Store a value directly, e.g. one returned by a mutation.
  void put<T>(String key, T value) => _entries[_key(key)] = _Entry(value, _now());

  /// Forget every entry in the current scope whose key starts with [prefix].
  void invalidate(String prefix) {
    final scoped = _key(prefix);
    _entries.removeWhere((key, _) => key.startsWith(scoped));
  }

  /// Forget everything, in every scope. On logout.
  void clear() {
    _generation++;
    _entries.clear();
    _inFlight.clear();
  }
}

class _Entry {
  _Entry(this.value, this.storedAt);

  final Object? value;
  final DateTime storedAt;
}
