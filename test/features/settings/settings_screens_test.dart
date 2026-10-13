import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/config/env.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/security/app_lock.dart';
import 'package:agentfolio/core/security/app_shield.dart';
import 'package:agentfolio/core/security/device_auth.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/features/ai/presentation/providers/ai_key_provider.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/settings/presentation/screens/account_screen.dart';
import 'package:agentfolio/features/settings/presentation/screens/delete_account_screen.dart';
import 'package:agentfolio/features/settings/presentation/view_models/delete_account_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../helpers/a11y.dart';
import '../../helpers/fake_ai.dart';
import '../../helpers/fake_auth_repository.dart';
import '../../helpers/fake_trading.dart';
import '../../helpers/recording_sink.dart';

void main() {
  late Telemetry telemetry;
  late Prefs prefs;
  late FakeDeviceAuth deviceAuth;
  late SessionProvider session;
  late FakeAuthRepository auth;
  late AppLock lock;

  setUp(() async {
    (telemetry, _) = await recordingTelemetry();
    prefs = await memoryPrefs();
    deviceAuth = FakeDeviceAuth();
  });

  Future<void> pump(WidgetTester tester, Widget home) async {
    tester.view
      ..physicalSize = const Size(390, 844) * 3
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    (session, auth) = await signedInSession(telemetry);
    lock = AppLock(prefs: prefs, auth: deviceAuth, session: session, telemetry: telemetry);
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<Telemetry>.value(value: telemetry),
          Provider<Prefs>.value(value: prefs),
          Provider<Env>.value(
            value: Env(
              flavor: Flavor.prod,
              apiBaseUrl: 'https://api.test',
              webBaseUrl: 'https://agentfolio.in',
              crashlyticsEnabled: false,
              privacyUrl: Uri.parse('https://agentfolio.in/privacy'),
              termsUrl: Uri.parse('https://agentfolio.in/terms'),
            ),
          ),
          Provider<BrokerRegistry>.value(value: BrokerRegistry()),
          Provider<LinkOpener>.value(value: LinkOpener(telemetry)),
          Provider<DeviceAuth>.value(value: deviceAuth),
          ChangeNotifierProvider(create: (_) => PrivacyProvider(prefs)),
          ChangeNotifierProvider<SessionProvider>.value(value: session),
          ChangeNotifierProvider<AppLock>.value(value: lock),
          ChangeNotifierProvider(
            create: (_) => AiKeyProvider(
              repository: FakeAiKeyRepository(),
              session: session,
              telemetry: telemetry,
            ),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.dark(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) => AppShield(child: child!),
          home: home,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> reveal(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(finder, 300, scrollable: find.byType(Scrollable).first);
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
  }

  group('Account', () {
    testWidgets('privacy switches: hide balances, app lock (checked), analytics', (tester) async {
      await pump(tester, const AccountScreen());
      await reveal(tester, find.text('App lock'));
      await tester.tap(find.text('App lock'));
      await tester.pumpAndSettle();
      expect(deviceAuth.reasons, hasLength(1), reason: 'turning it on proves the phone can unlock');
      expect(prefs.appLockEnabled, isTrue);

      await tester.tap(find.text('Share usage analytics'));
      await tester.pumpAndSettle();
      expect(prefs.analyticsEnabled, isFalse);
      expect(telemetry.analyticsEnabled, isFalse);

      await reveal(tester, find.text('Terms of use'));
      expect(find.text('Privacy policy'), findsOneWidget);
      await reveal(tester, find.text('Delete account'));
    });

    testWidgets('no screen lock on the phone: the app lock stays off and says why', (tester) async {
      deviceAuth.result = DeviceAuthResult.unavailable;
      await pump(tester, const AccountScreen());
      await reveal(tester, find.text('App lock'));
      await tester.tap(find.text('App lock'));
      await tester.pumpAndSettle();
      expect(prefs.appLockEnabled, isFalse);
      expect(find.textContaining('Set a screen lock'), findsOneWidget);
    });
  });

  group('Delete account', () {
    Widget screen() => ChangeNotifierProvider(
      create: (_) => DeleteAccountViewModel(session: session, telemetry: telemetry),
      child: const DeleteAccountScreen(),
    );

    testWidgets('needs the password and the acknowledgement before asking', (tester) async {
      await pump(tester, Builder(builder: (_) => screen()));
      await reveal(tester, find.text('Delete my account'));
      await tester.tap(find.text('Delete my account'));
      await tester.pumpAndSettle();
      expect(find.text("Enter your app password to confirm it's you."), findsOneWidget);
      expect(find.text('Tick this to continue.'), findsOneWidget);
      expect(auth.deletions, isEmpty);
    });

    testWidgets('a wrong password is shown on the field; nothing is wiped', (tester) async {
      await pump(tester, Builder(builder: (_) => screen()));
      auth.deleteResult = failWith(
        const ValidationFailure("That password isn't right.", field: 'app_password'),
      );
      await tester.enterText(find.byType(TextField), 'nope');
      await reveal(tester, find.text('Delete my account'));
      await tester.tap(find.text("I understand this can't be undone"));
      await tester.tap(find.text('Delete my account'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete permanently'));
      await tester.pumpAndSettle();
      expect(auth.deletions, ['nope']);
      expect(find.text("That password isn't right."), findsOneWidget);
      expect(session.isSignedIn, isTrue);
    });

    testWidgets('the right password deletes and signs out', (tester) async {
      await pump(tester, Builder(builder: (_) => screen()));
      await tester.enterText(find.byType(TextField), 'correct-horse');
      await reveal(tester, find.text('Delete my account'));
      await tester.tap(find.text("I understand this can't be undone"));
      await tester.tap(find.text('Delete my account'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Delete permanently'));
      await tester.pumpAndSettle();
      expect(auth.deletions, ['correct-horse']);
      expect(session.isSignedIn, isFalse);
      expect(session.lastSignOut, SignOutReason.accountDeleted);
    });
  });

  testWidgets('a locked app shows only the lock screen, which asks at once', (tester) async {
    await prefs.setAppLockEnabled(enabled: true);
    deviceAuth.result = DeviceAuthResult.cancelled;
    await pump(tester, const AccountScreen());
    expect(find.text('Agentfolio is locked'), findsOneWidget);
    expect(deviceAuth.reasons, hasLength(1));
    expect(find.text('Not unlocked. Try again.'), findsOneWidget);

    deviceAuth.result = DeviceAuthResult.confirmed;
    await tester.tap(find.text('Unlock'));
    await tester.pumpAndSettle();
    expect(find.text('Agentfolio is locked'), findsNothing);
    expect(find.text('Account'), findsOneWidget);
  });

  testWidgets('accessible: Account at 2× text, labelled 48-point tap targets', (tester) async {
    useLargeText(tester);
    await pump(tester, const AccountScreen());
    await expectAccessibleTapTargets(tester);
    await scrollThrough(tester);
  });
}
