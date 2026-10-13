import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('first load: loading, then data', () async {
    final l = Loadable<int>(fetch: ({required force}) async => const Success(1), onChanged: () {});
    final future = l.load();
    expect(l.state, isA<ViewLoading<int>>());
    await future;
    expect(l.data, 1);
  });

  test('does not notify synchronously, so it can start during a build', () async {
    var notified = 0;
    final l = Loadable<int>(
      fetch: ({required force}) => Completer<Result<int>>().future,
      onChanged: () => notified++,
    );
    unawaited(l.load());
    expect(notified, 0);
    await Future<void>.delayed(Duration.zero);
    expect(notified, 1);
  });

  test('cached data paints at once and refreshes quietly', () async {
    final l = Loadable<int>(
      fetch: ({required force}) async => const Success(2),
      peek: () => 1,
      onChanged: () {},
    );
    final future = l.load();
    expect(l.state, isA<ViewData<int>>());
    expect((l.state as ViewData<int>).refreshing, isTrue);
    expect(l.data, 1);
    await future;
    expect(l.data, 2);
  });

  test('a failed refresh keeps the data and explains why', () async {
    var fail = false;
    final l = Loadable<int>(
      fetch: ({required force}) async => fail ? const Err(NetworkFailure()) : const Success(7),
      onChanged: () {},
    );
    await l.load();
    fail = true;
    await l.load(force: true);
    final state = l.state as ViewData<int>;
    expect(state.data, 7);
    expect(state.refreshFailure, isA<NetworkFailure>());
  });

  test('a first load that fails shows the error', () async {
    final l = Loadable<int>(
      fetch: ({required force}) async => const Err(TimeoutFailure()),
      onChanged: () {},
    );
    await l.load();
    expect(l.state, isA<ViewError<int>>());
  });

  test('a slow older load cannot overwrite a newer one', () async {
    final slow = Completer<Result<int>>();
    var calls = 0;
    final l = Loadable<int>(
      fetch: ({required force}) => ++calls == 1 ? slow.future : Future.value(const Success(2)),
      onChanged: () {},
    );
    final first = l.load();
    await l.load(force: true);
    slow.complete(const Success(1));
    await first;
    expect(l.data, 2);
  });
}
