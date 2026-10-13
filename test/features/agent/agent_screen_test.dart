import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/security/device_auth.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/user_hash.dart';
import 'package:agentfolio/core/time/server_clock.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:agentfolio/features/agent/presentation/screens/agent_screen.dart';
import 'package:agentfolio/features/agent/presentation/view_models/agent_chat_view_model.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../helpers/a11y.dart';
import '../../helpers/fake_agent_repository.dart';
import '../../helpers/fake_ai.dart';
import '../../helpers/fake_trading.dart';
import '../../helpers/recording_sink.dart';

void main() {
  late Telemetry telemetry;
  late Prefs prefs;
  late PrivacyProvider privacy;
  late FakeAgentRepository finance;
  late FakeAgentRepository trading;
  late FakeDeviceAuth deviceAuth;

  setUp(() async {
    (telemetry, _) = await recordingTelemetry();
    prefs = await memoryPrefs();
    privacy = PrivacyProvider(prefs);
    finance = FakeAgentRepository(premium: false);
    trading = FakeAgentRepository(premium: false);
    deviceAuth = FakeDeviceAuth();
  });

  Future<void> pumpApp(
    WidgetTester tester, {
    bool premium = false,
    String location = '/agent',
    Size size = const Size(390, 844),
  }) async {
    tester.view
      ..physicalSize = size * 3
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final (SessionProvider session, _) = await signedInSession(telemetry, premium: premium);
    final router = GoRouter(
      initialLocation: location,
      routes: [
        GoRoute(
          path: '/agent',
          builder: (context, state) => AgentScreen(
            create: (type) => AgentChatViewModel(
              type: type,
              agent: type == AgentType.finance ? finance : trading,
              prefs: prefs,
              userId: 'A123',
              telemetry: telemetry,
            ),
            aboutSymbol: state.uri.queryParameters['about'],
          ),
        ),
        GoRoute(path: '/trade', builder: (context, state) => const Text('Trade tab')),
        GoRoute(path: '/account', builder: (context, state) => const Text('Account')),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<Telemetry>.value(value: telemetry),
          Provider<BrokerRegistry>.value(value: BrokerRegistry()),
          Provider<LinkOpener>.value(value: LinkOpener(telemetry)),
          Provider<Prefs>.value(value: prefs),
          Provider<DeviceAuth>.value(value: deviceAuth),
          Provider<ServerClock>.value(value: ServerClock()),
          ChangeNotifierProvider<PrivacyProvider>.value(value: privacy),
          ChangeNotifierProvider<SessionProvider>.value(value: session),
        ],
        child: MaterialApp.router(
          theme: AppTheme.dark(),
          routerConfig: router,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Finder composer() => find.byType(TextField);

  /// Types into the composer and taps Send, a frame apart as a person would.
  Future<void> typeAndSend(WidgetTester tester, String text) async {
    await tester.enterText(composer(), text);
    await tester.pump();
    await tester.tap(find.byTooltip('Send'));
    await tester.pumpAndSettle();
  }

  testWidgets('a starter sends, and the reply shows under it', (tester) async {
    finance.onSend = (m) => const Success(ChatReply(reply: 'Your **IT** weight is high.'));
    await pumpApp(tester);

    expect(find.text('What would you like to know?'), findsOneWidget);
    expect(find.textContaining("Conversations aren't saved"), findsOneWidget);
    await tester.tap(find.text("Where's my risk?"));
    await tester.pumpAndSettle();

    expect(finance.calls.last, startsWith('send:-:Where is my portfolio most concentrated'));
    expect(find.textContaining('Where is my portfolio most concentrated'), findsOneWidget);
    expect(find.textContaining('weight is high', findRichText: true), findsOneWidget);
  });

  testWidgets('typing and sending clears the composer; the footnote opens the AI statement', (
    tester,
  ) async {
    await pumpApp(tester);
    await typeAndSend(tester, '  What did I make today?  ');
    expect(finance.calls.last, 'send:-:What did I make today?');
    expect(tester.widget<TextField>(composer()).controller!.text, isEmpty);

    await tester.tap(find.textContaining('Not financial advice'));
    await tester.pumpAndSettle();
    expect(find.text(Disclaimers.responsibleAiFineprint), findsOneWidget);
  });

  testWidgets('a failed message offers Send again, which sends it once more', (tester) async {
    finance.onSend = (_) => const Err(NetworkFailure());
    await pumpApp(tester);
    await typeAndSend(tester, 'Hello');
    expect(find.text('Could not reach the server. Check your connection.'), findsOneWidget);

    finance.onSend = null;
    await tester.tap(find.text('Send again'));
    await tester.pumpAndSettle();
    expect(finance.calls.where((c) => c == 'send:-:Hello'), hasLength(2));
    expect(find.textContaining('Reply to: Hello', findRichText: true), findsOneWidget);
    expect(find.text('Send again'), findsNothing);
  });

  testWidgets('the trading agent is locked without Premium', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('Trading'));
    await tester.pumpAndSettle();
    expect(find.text('The trading agent is part of Premium'), findsOneWidget);
    expect(composer(), findsNothing);
    expect(trading.calls, isEmpty);

    await tester.tap(find.text('Go to Trade'));
    await tester.pumpAndSettle();
    expect(find.text('Trade tab'), findsOneWidget);
  });

  testWidgets('APPROVE goes through the full approval; cancelling keeps the text', (tester) async {
    trading.premium = true;
    await pumpApp(tester, premium: true);
    await tester.tap(find.text('Trading'));
    await tester.pumpAndSettle();
    expect(find.text('Proposals must be approved before execution.'), findsOneWidget);

    // First time: the risk disclosure, which must be ticked to continue.
    await typeAndSend(tester, 'APPROVE a1b2c3d4');
    expect(find.text(Disclaimers.tradingRiskTitle), findsOneWidget);
    await tester.tap(find.text(Disclaimers.tradingRiskAccept));
    await tester.pump();
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();

    expect(find.text('Place this order?'), findsOneWidget);
    expect(find.text('a1b2c3d4'), findsOneWidget);
    expect(find.textContaining('real order on your Angel One account'), findsOneWidget);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(trading.calls.where((c) => c.startsWith('send')), isEmpty);
    expect(tester.widget<TextField>(composer()).controller!.text, 'APPROVE a1b2c3d4');

    // Accepted once: straight to the sheet, then the device check.
    await tester.tap(find.byTooltip('Send'));
    await tester.pumpAndSettle();
    expect(find.text(Disclaimers.tradingRiskTitle), findsNothing);
    await tester.tap(find.text('Confirm and place order'));
    await tester.pumpAndSettle();
    expect(deviceAuth.reasons, hasLength(1));
    expect(trading.calls, containsAllInOrder(['create', 'send:100:APPROVE a1b2c3d4']));
  });

  testWidgets('a failed device check sends nothing', (tester) async {
    trading.premium = true;
    deviceAuth.result = DeviceAuthResult.cancelled;
    await prefs.setRiskDisclosureAccepted(hashUserId('A123'));
    await pumpApp(tester, premium: true);
    await tester.tap(find.text('Trading'));
    await tester.pumpAndSettle();
    await typeAndSend(tester, 'APPROVE a1b2c3d4');
    await tester.tap(find.text('Confirm and place order'));
    await tester.pumpAndSettle();
    expect(find.text('Place this order?'), findsOneWidget);
    expect(trading.calls.where((c) => c.startsWith('send')), isEmpty);
  });

  testWidgets('premium on a phone: conversations in a drawer, grouped and openable', (
    tester,
  ) async {
    final now = DateTime.now();
    finance = FakeAgentRepository(
      threads: [
        thread(1, 'Rebalancing ideas', at: now),
        thread(2, 'Dividend stocks', at: now.subtract(const Duration(days: 30))),
      ],
    )..history[2] = [said(ChatRole.user, 'Which pay dividends?')];
    await pumpApp(tester, premium: true);

    await tester.tap(find.byTooltip('Conversations'));
    await tester.pumpAndSettle();
    expect(find.text('TODAY'), findsOneWidget);
    expect(find.text('OLDER'), findsOneWidget);

    await tester.tap(find.text('Dividend stocks'));
    await tester.pumpAndSettle();
    expect(find.text('Which pay dividends?'), findsOneWidget);
    expect(find.byType(Drawer), findsNothing);
  });

  testWidgets('on a tablet the conversations stay beside the chat', (tester) async {
    finance = FakeAgentRepository(threads: [thread(1, 'Rebalancing ideas')]);
    await pumpApp(tester, premium: true, size: const Size(1280, 800));
    expect(find.text('Rebalancing ideas'), findsOneWidget);
    expect(find.byTooltip('Conversations'), findsNothing);
  });

  testWidgets('Hide balances masks amounts the agent writes', (tester) async {
    finance.onSend = (_) => const Success(ChatReply(reply: 'You are up Rs. 3,600 (6%).'));
    await pumpApp(tester);
    await typeAndSend(tester, 'P&L?');
    expect(find.textContaining('Rs. 3,600', findRichText: true), findsOneWidget);

    privacy.toggle();
    await tester.pumpAndSettle();
    expect(find.textContaining('Rs. 3,600', findRichText: true), findsNothing);
    expect(find.textContaining('Rs. •••• (6%)', findRichText: true), findsOneWidget);
  });

  testWidgets('Ask the agent from a stock fills the composer without sending', (tester) async {
    await pumpApp(tester, location: '/agent?about=TCS');
    expect(tester.widget<TextField>(composer()).controller!.text, startsWith('Tell me about TCS'));
    expect(finance.calls.where((c) => c.startsWith('send')), isEmpty);
  });

  testWidgets('fits a small phone with a long conversation', (tester) async {
    finance.onSend = (m) =>
        Success(ChatReply(reply: '${'A long answer. ' * 40}\n\n| a | b |\n|---|---|\n| 1 | 2 |'));
    await pumpApp(tester, size: const Size(320, 568));
    expect(tester.takeException(), isNull);
    await typeAndSend(tester, 'x' * 600);
    expect(tester.takeException(), isNull);
  });

  testWidgets('accessible: 2× text, labelled 48-point tap targets', (tester) async {
    useLargeText(tester);
    finance = FakeAgentRepository(threads: [thread(1, 'Rebalancing ideas')])
      ..history[1] = [said(ChatRole.user, 'Hi'), said(ChatRole.assistant, 'Hello ' * 40)];
    await pumpApp(tester, premium: true);
    await expectAccessibleTapTargets(tester);
    expect(tester.takeException(), isNull);
  });
}
