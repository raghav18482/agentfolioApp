import 'dart:async';

import 'package:agentfolio/core/broker/broker_descriptor.dart';
import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/session/session_epoch.dart';
import 'package:agentfolio/core/session/session_expiry_signal.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/features/accounts/domain/entities/broker_account.dart';
import 'package:agentfolio/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:agentfolio/features/auth/data/models/session_dto.dart';
import 'package:agentfolio/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:agentfolio/features/auth/domain/entities/session.dart';
import 'package:agentfolio/features/auth/domain/repositories/auth_repository.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/recording_sink.dart';

class _MockRepository extends Mock implements AuthRepository;

class _MockRemote extends Mock implements AuthRemoteDataSource;

const _signedOut = Session.signedOut();

void main() {
  late _MockRepository repository;
  late RequestCache cache;
  late SessionEpoch epoch;
  late SessionExpirySignal expiry;
  late RecordingSink sink;
  late SessionProvider provider;

  Session signedIn(String clientId) => Session.signedIn(
    user: AppUser(id: clientId, premium: const PremiumStatus(registered: true)),
    accounts: [
      BrokerAccount(id: clientId, brokerId: const BrokerId('angel_one'), clientCode: clientId),
    ],
    activeAccountId: clientId,
  );

  setUp(() async {
    repository = _MockRepository();
    cache = RequestCache();
    epoch = SessionEpoch();
    expiry = SessionExpirySignal();
    final (telemetry, recording) = await recordingTelemetry();
    sink = recording;
    provider = SessionProvider(
      repository: repository,
      cache: cache,
      epoch: epoch,
      telemetry: telemetry,
      expirySignal: expiry,
    );
  });

  test('a signed-in answer scopes the cache and identifies the user by hash', () async {
    when(() => repository.currentSession()).thenAnswer((_) async => Success(signedIn('AB1234')));
    await provider.refresh();

    expect(provider.status, SessionStatus.signedIn);
    expect(cache.scope, 'AB1234');
    expect(sink.users.single.id, isNot(contains('AB1234')));
    expect(sink.named(EventName.sessionRestored), hasLength(1));
  });

  test('the server being unreachable at launch is its own state', () async {
    when(() => repository.currentSession()).thenAnswer((_) async => const Err(NetworkFailure()));
    await provider.refresh();
    expect(provider.status, SessionStatus.unreachable);
  });

  test('a failed re-check keeps a signed-in user signed in', () async {
    when(() => repository.currentSession()).thenAnswer((_) async => Success(signedIn('AB1234')));
    await provider.refresh();
    when(() => repository.currentSession()).thenAnswer((_) async => const Err(TimeoutFailure()));
    await provider.refresh();
    expect(provider.status, SessionStatus.signedIn);
  });

  test('signing out wipes the cache, moves the epoch and forgets the user', () async {
    when(() => repository.currentSession()).thenAnswer((_) async => Success(signedIn('AB1234')));
    await provider.refresh();
    cache.put('portfolio', 'their holdings');
    final before = epoch.current;

    when(() => repository.currentSession()).thenAnswer((_) async => const Success(_signedOut));
    await provider.refresh();

    expect(provider.status, SessionStatus.signedOut);
    expect(cache.peek<String>('portfolio'), isNull);
    expect(epoch.current, greaterThan(before));
    expect(sink.resets, 1);
  });

  test('a burst of 401s causes exactly one re-check', () async {
    when(() => repository.currentSession()).thenAnswer((_) async => Success(signedIn('AB1234')));
    await provider.refresh();
    clearInteractions(repository);

    final gate = Completer<Result<Session>>();
    when(() => repository.currentSession()).thenAnswer((_) => gate.future);
    for (var i = 0; i < 5; i++) {
      expiry.notify();
    }
    gate.complete(const Success(_signedOut));
    await pumpEventQueue();

    verify(() => repository.currentSession()).called(1);
    expect(provider.status, SessionStatus.signedOut);
    expect(sink.named(EventName.sessionExpired), hasLength(1));
  });

  group('bootstrap mapping', () {
    late _MockRemote remote;
    setUp(() => remote = _MockRemote());

    test('anonymous is signed out, not an error', () async {
      when(remote.fetchSession).thenAnswer((_) async => const SessionDto(authenticated: false));
      final result = await AuthRepositoryImpl(remote, RequestCache()).currentSession();
      expect(result.valueOrNull, isA<SignedOut>());
    });

    test('one user with one linked account', () async {
      when(remote.fetchSession).thenAnswer(
        (_) async => const SessionDto(
          authenticated: true,
          clientId: 'AB1234',
          premium: PremiumDto(registered: true, whatsappNumber: '+910000000000'),
        ),
      );
      final session = (await AuthRepositoryImpl(
        remote,
        RequestCache(),
      ).currentSession()).valueOrNull!;
      final signedIn = session as SignedIn;
      expect(signedIn.user.premium.registered, isTrue);
      expect(signedIn.accounts.single.clientCode, 'AB1234');
      expect(signedIn.activeAccount.brokerId.value, 'angel_one');
    });

    test('authenticated without a client id is treated as signed out', () async {
      when(remote.fetchSession).thenAnswer((_) async => const SessionDto(authenticated: true));
      final result = await AuthRepositoryImpl(remote, RequestCache()).currentSession();
      expect(result.valueOrNull, isA<SignedOut>());
    });
  });
}
