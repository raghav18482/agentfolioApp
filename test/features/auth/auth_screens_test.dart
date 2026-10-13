import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/broker/brokers/angel_one.dart';
import 'package:agentfolio/core/config/env.dart';
import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/features/auth/domain/usecases/link_account.dart';
import 'package:agentfolio/features/auth/domain/usecases/login.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/auth/presentation/screens/link_account_screen.dart';
import 'package:agentfolio/features/auth/presentation/screens/login_screen.dart';
import 'package:agentfolio/features/auth/presentation/view_models/link_account_view_model.dart';
import 'package:agentfolio/features/auth/presentation/view_models/login_view_model.dart';
import 'package:agentfolio/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../helpers/fake_auth_repository.dart';
import '../../helpers/recording_sink.dart';

class _MockSession extends Mock implements SessionProvider;

class _MockPrefs extends Mock implements Prefs;

const _wrongPassword = "That WhatsApp number and password don't match.";

const _env = Env(
  flavor: Flavor.dev,
  apiBaseUrl: 'http://localhost',
  webBaseUrl: 'https://agentfolio.in',
  crashlyticsEnabled: false,
);

/// The compliance texts must appear exactly as written; these tests fail on
/// any rewording, so a change has to be deliberate.
void main() {
  late Telemetry telemetry;
  late FakeAuthRepository repo;
  late _MockSession session;

  setUp(() async {
    (telemetry, _) = await recordingTelemetry();
    repo = FakeAuthRepository();
    session = _MockSession();
    when(() => session.signedInNow()).thenAnswer((_) async => false);
    when(() => session.lastSignOut).thenReturn(null);
  });

  Widget app(Widget screen, {List<SingleChildWidget> extra = const []}) => MultiProvider(
    providers: [
      Provider<Telemetry>.value(value: telemetry),
      Provider<Env>.value(value: _env),
      Provider<BrokerRegistry>.value(value: BrokerRegistry()),
      Provider<LinkOpener>.value(value: LinkOpener(telemetry)),
      ChangeNotifierProvider<SessionProvider>.value(value: session),
      ...extra,
    ],
    child: MaterialApp(
      theme: AppTheme.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: screen,
    ),
  );

  testWidgets('Login shows the security notice verbatim and the form', (tester) async {
    await tester.pumpWidget(
      app(
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(
            repository: repo,
            login: Login(repo),
            session: session,
            telemetry: telemetry,
          ),
          child: const LoginScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('WhatsApp number'), findsOneWidget);
    expect(find.text('+91'), findsOneWidget);
    expect(find.text(Disclaimers.securityNotice('Angel One')), findsOneWidget);
  });

  testWidgets('Login shows the server message for a wrong password', (tester) async {
    repo.loginResult = failWith(const UnauthorizedFailure(_wrongPassword));
    await tester.pumpWidget(
      app(
        ChangeNotifierProvider(
          create: (_) => LoginViewModel(
            repository: repo,
            login: Login(repo),
            session: session,
            telemetry: telemetry,
          ),
          child: const LoginScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '9876543210');
    await tester.enterText(find.byType(TextField).last, 'wrong');
    await tester.tap(find.text('Log in').last);
    await tester.pumpAndSettle();

    expect(find.text(_wrongPassword), findsOneWidget);
  });

  testWidgets('Link account: step two shows the trade-off disclaimer verbatim', (tester) async {
    await tester.pumpWidget(
      app(
        ChangeNotifierProvider(
          create: (_) => LinkAccountViewModel(
            broker: angelOne,
            repository: repo,
            linkAccount: LinkAccount(repo),
            session: session,
            consentRequired: false,
            telemetry: telemetry,
          ),
          child: const LinkAccountScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Step one is generated from the broker's descriptor.
    for (final field in angelOne.credentialFields) {
      expect(find.text(field.label), findsOneWidget);
    }
    final fields = find.byType(TextField);
    for (var i = 0; i < angelOne.credentialFields.length; i++) {
      await tester.enterText(fields.at(i), 'value$i');
    }
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text(Disclaimers.linkAccountTradeOff), findsOneWidget);
    // No consent row until Terms and Privacy pages exist.
    expect(find.byType(Checkbox), findsNothing);
  });

  testWidgets('Onboarding ends on the Responsible AI statement, verbatim', (tester) async {
    final prefs = _MockPrefs();
    await tester.pumpWidget(
      app(const OnboardingScreen(), extra: [Provider<Prefs>.value(value: prefs)]),
    );
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.text(Disclaimers.responsibleAiTitle), findsOneWidget);
    expect(find.text(Disclaimers.responsibleAiBody), findsOneWidget);
    expect(find.text(Disclaimers.responsibleAiFineprint), findsOneWidget);
    expect(find.text('Set up your account'), findsOneWidget);
  });
}
