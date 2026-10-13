import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/view_state.dart';

/// One piece of server data on a screen, loaded stale-while-revalidate.
///
/// * First visit: skeleton, then data or an error with Retry.
/// * Data already cached elsewhere ([peek]): shown at once, refreshed quietly.
/// * Refresh (pull-to-refresh) with data on screen: the data stays, a thin
///   progress hint shows, and a failure becomes a non-blocking notice instead
///   of replacing good data with an error.
/// * Two loads racing: only the newest result is applied.
///
/// A view model owns one per data source and passes its own
/// `notifyListeners` as [onChanged]. Safe to start from `initState`.
class Loadable<T> {
  Loadable({required this.fetch, required this.onChanged, this.peek});

  /// Loads the data. `force` skips the cache's freshness check.
  final Future<Result<T>> Function({required bool force}) fetch;

  /// The last value the repository holds, fresh or not, for an instant paint.
  final T? Function()? peek;
  final void Function() onChanged;

  ViewState<T> state = const ViewIdle();
  int _sequence = 0;

  T? get data => state.dataOrNull;

  Future<void> load({bool force = false}) async {
    final sequence = ++_sequence;
    final current = state.dataOrNull ?? peek?.call();
    state = current == null ? const ViewLoading() : ViewData(current, refreshing: true);
    // Deferred to a microtask: screens start loads from initState, while the
    // widget tree is still building, and notifying then is an error. The
    // microtask runs as soon as the frame's build is done.
    scheduleMicrotask(() {
      if (sequence == _sequence) onChanged();
    });

    final result = await fetch(force: force);
    if (sequence != _sequence) return; // a newer load owns the state now

    state = switch (result) {
      Success(:final value) => ViewData(value, updatedAt: DateTime.now()),
      Err(failure: CancelledFailure()) when current != null => ViewData(current),
      Err(:final failure) when current != null => ViewData(current, refreshFailure: failure),
      Err(:final failure) => ViewError(failure),
    };
    onChanged();
  }

  /// Loads only if nothing has been loaded yet; for lazily revealed cards.
  Future<void> ensureLoaded() async {
    if (state is ViewIdle<T>) await load();
  }
}
