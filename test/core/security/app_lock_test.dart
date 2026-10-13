import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/security/app_lock.dart';
import 'package:agentfolio/core/security/device_auth.dart';
import 'package:agentfolio/core/session/session_epoch.dart';
import 'package:agentfolio/core/session/session_expiry_signal.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/features/auth/domain/entities/session.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_ai.dart';
import '../../helpers/fake_auth_repository.dart';
import '../../helpers/fake_trading.dart';
import '../../helpers/recording_sink.dart';

void main() {
  late Telemetry telemetry;
  late Prefs prefs;
  late FakeDeviceAuth auth;
  late DateTime now;

  setUp(() async {
    (telemetry, _) = await recordingTelemetry();
    prefs = await memoryPrefs();
    auth = FakeDeviceAuth();
    now = DateTime(2026, 10, 12, 10);
  });

  AppLock lockFor(SessionProvider session) =>
      AppLock(prefs: prefs, auth: auth, session: session, telemetry: telemetry, clock: () => now);

  test('off unless turned on, and turning it on needs the device check', () async {
    final (session, _) = await signedInSession(telemetry);
    final lock = lockFor(session);
    expect(lock.enabled, isFalse);
    expect(lock.locked, isFalse);

    auth.result = DeviceAuthResult.unavailable;
    expect(await lock.setEnabled(enabled: true, reason: 'r'), EnableResult.noScreenLock);
    expect(lock.enabled, isFalse);

    auth.result = DeviceAuthResult.confirmed;
    expect(await lock.setEnabled(enabled: true, reason: 'r'), EnableResult.enabled);
    expect(lock.enabled, isTrue);
  });

  test('a session restored at launch is locked; a fresh sign-in is not', () async {
    await prefs.setAppLockEnabled(enabled: true);
    final (restored, _) = await signedInSession(telemetry);
    expect(lockFor(restored).locked, isTrue);

    final auth0 = FakeAuthRepository();
    final fresh = SessionProvider(
      repository: auth0,
      cache: RequestCache(),
      epoch: SessionEpoch(),
      telemetry: telemetry,
      expirySignal: SessionExpirySignal(),
    );
    await fresh.refresh(); // signed out at launch
    final lock = lockFor(fresh);
    auth0.sessionResult = Success(signedInAs('A123'));
    await fresh.signedInNow(); // typed the password
    expect(lock.locked, isFalse);
  });

  test('locks again only after a minute in the background', () async {
    await prefs.setAppLockEnabled(enabled: true);
    final (session, _) = await signedInSession(telemetry);
    final lock = lockFor(session);
    expect(await lock.unlock('r'), UnlockResult.unlocked);

    lock.onBackground();
    now = now.add(const Duration(seconds: 30));
    lock.onForeground();
    expect(lock.locked, isFalse, reason: 'a quick switch away');

    lock.onBackground();
    now = now.add(const Duration(minutes: 2));
    lock.onForeground();
    expect(lock.locked, isTrue);
  });

  test('a failed check stays locked; a removed screen lock turns it off', () async {
    await prefs.setAppLockEnabled(enabled: true);
    final (session, _) = await signedInSession(telemetry);
    final lock = lockFor(session);

    auth.result = DeviceAuthResult.cancelled;
    expect(await lock.unlock('r'), UnlockResult.stillLocked);
    expect(lock.locked, isTrue);

    auth.result = DeviceAuthResult.unavailable;
    expect(await lock.unlock('r'), UnlockResult.lockRemoved);
    expect(lock.locked, isFalse);
    expect(lock.enabled, isFalse);
  });

  test('signing out unlocks and turns the lock off', () async {
    await prefs.setAppLockEnabled(enabled: true);
    final (session, _) = await signedInSession(telemetry);
    final lock = lockFor(session);
    expect(lock.locked, isTrue);
    await session.signOut();
    expect(lock.locked, isFalse);
    expect(lock.enabled, isFalse);
  });

  test('deleting the account wipes the device and remembers why', () async {
    final (session, auth0) = await signedInSession(telemetry);
    final wiped = <String>[];
    session.onSignOut((id) async => wiped.add(id));

    auth0.deleteResult = failWith(
      const ValidationFailure("That password isn't right.", field: 'app_password'),
    );
    expect((await session.deleteAccount('wrong')).failureOrNull, isNotNull);
    expect(session.isSignedIn, isTrue);
    expect(wiped, isEmpty);

    auth0.deleteResult = const Success(null);
    expect(await session.deleteAccount('right'), isA<Success<void>>());
    expect(session.isSignedIn, isFalse);
    expect(session.lastSignOut, SignOutReason.accountDeleted);
    expect(wiped, ['A123']);
    expect(auth0.logouts, 1, reason: 'the cookies are cleared too');
    expect(session.session, const Session.signedOut());
  });
}
