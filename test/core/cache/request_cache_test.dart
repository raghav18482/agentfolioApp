import 'dart:async';

import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DateTime now;
  late RequestCache cache;
  late int loads;

  Future<String> load([String value = 'v']) async {
    loads++;
    return value;
  }

  setUp(() {
    now = DateTime(2026, 10, 11, 10);
    cache = RequestCache(clock: () => now);
    loads = 0;
  });

  test('a fresh entry is served without loading again', () async {
    await cache.fetch('k', ttl: const Duration(minutes: 1), load: load);
    now = now.add(const Duration(seconds: 59));
    await cache.fetch('k', ttl: const Duration(minutes: 1), load: load);
    expect(loads, 1);
  });

  test('a stale entry is loaded again, but peek still returns it', () async {
    await cache.fetch('k', ttl: const Duration(minutes: 1), load: () => load('old'));
    now = now.add(const Duration(minutes: 2));
    expect(cache.peek<String>('k'), 'old');
    final value = await cache.fetch('k', ttl: const Duration(minutes: 1), load: () => load('new'));
    expect(value, 'new');
    expect(loads, 2);
  });

  test('concurrent callers share one in-flight load', () async {
    final gate = Completer<String>();
    var calls = 0;
    Future<String> slow() {
      calls++;
      return gate.future;
    }

    final a = cache.fetch('k', ttl: Duration.zero, load: slow);
    final b = cache.fetch('k', ttl: Duration.zero, load: slow);
    final c = cache.fetch('k', ttl: Duration.zero, load: slow, force: true);
    gate.complete('shared');

    expect(await Future.wait([a, b, c]), ['shared', 'shared', 'shared']);
    expect(calls, 1);
  });

  test('force bypasses a fresh entry', () async {
    await cache.fetch('k', ttl: const Duration(hours: 1), load: load);
    await cache.fetch('k', ttl: const Duration(hours: 1), load: load, force: true);
    expect(loads, 2);
  });

  test('failures are not cached and the next call tries again', () async {
    await expectLater(
      cache.fetch<String>('k', ttl: const Duration(hours: 1), load: () => Future.error('boom')),
      throwsA('boom'),
    );
    final value = await cache.fetch('k', ttl: const Duration(hours: 1), load: load);
    expect(value, 'v');
    expect(loads, 1);
  });

  test('scopes isolate accounts from each other', () async {
    cache.scope = 'account-a';
    await cache.fetch('portfolio', ttl: const Duration(hours: 1), load: () => load('A'));
    cache.scope = 'account-b';
    expect(cache.peek<String>('portfolio'), isNull);
    final value = await cache.fetch(
      'portfolio',
      ttl: const Duration(hours: 1),
      load: () => load('B'),
    );
    expect(value, 'B');
  });

  test('a load that finishes after clear() does not repopulate the cache', () async {
    final gate = Completer<String>();
    final pending = cache.fetch('k', ttl: const Duration(hours: 1), load: () => gate.future);
    cache.clear();
    gate.complete('previous user');
    await pending;
    expect(cache.peek<String>('k'), isNull);
  });

  test('after clear(), a late old load does not drop the new in-flight load', () async {
    final oldGate = Completer<String>();
    final newGate = Completer<String>();
    final old = cache.fetch('k', ttl: Duration.zero, load: () => oldGate.future);
    cache.clear();
    final fresh = cache.fetch('k', ttl: Duration.zero, load: () => newGate.future);

    oldGate.complete('old');
    await old;
    // Still shared: a second caller must join the new load, not start a third.
    var extra = 0;
    final joined = cache.fetch(
      'k',
      ttl: Duration.zero,
      load: () {
        extra++;
        return Future.value('third');
      },
    );
    newGate.complete('new');
    expect(await fresh, 'new');
    expect(await joined, 'new');
    expect(extra, 0);
  });

  test('shouldCache can refuse a value', () async {
    await cache.fetch<List<int>>(
      'k',
      ttl: const Duration(hours: 1),
      load: () async => [],
      shouldCache: (v) => v.isNotEmpty,
    );
    expect(cache.peek<List<int>>('k'), isNull);
  });

  test('invalidate removes matching keys in the current scope only', () async {
    cache.scope = 'a';
    await cache.fetch('portfolio/holdings', ttl: const Duration(hours: 1), load: load);
    await cache.fetch('news', ttl: const Duration(hours: 1), load: load);
    cache.invalidate('portfolio');
    expect(cache.peek<String>('portfolio/holdings'), isNull);
    expect(cache.peek<String>('news'), 'v');
  });
}
