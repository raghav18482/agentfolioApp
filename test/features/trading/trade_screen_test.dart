import 'dart:async';

import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/market/market_stream.dart';
import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/security/device_auth.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/user_hash.dart';
import 'package:agentfolio/core/time/server_clock.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/presentation/screens/rebalancer_screen.dart';
import 'package:agentfolio/features/trading/presentation/screens/risk_profile_screen.dart';
import 'package:agentfolio/features/trading/presentation/screens/trade_screen.dart';
import 'package:agentfolio/features/trading/presentation/view_models/live_watch_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/premium_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/rebalancer_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/risk_profile_view_model.dart';
import 'package:agentfolio/features/trading/presentation/view_models/trade_view_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../helpers/a11y.dart';
import '../../helpers/fake_ai.dart';
import '../../helpers/fake_auth_repository.dart';
import '../../helpers/fake_portfolio_repository.dart';
import '../../helpers/fake_research_repository.dart';
import '../../helpers/fake_trading.dart';
import '../../helpers/recording_sink.dart';
import '../portfolio/portfolio_logic_test.dart' show holding;

void main() {
  late Telemetry telemetry;
  late Prefs prefs;
  late FakeTradingRepository trading;
  late FakeDeviceAuth deviceAuth;
  late FakePortfolioRepository portfolio;
  late MarketStream stream;

  setUp(() async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    (telemetry, _) = await recordingTelemetry();
    prefs = await memoryPrefs();
    trading = FakeTradingRepository(proposals: [proposal('a1b2c3d4')]);
    deviceAuth = FakeDeviceAuth();
    portfolio = FakePortfolioRepository([
      holding('TCS-EQ', invested: 30000, pnl: 4500),
      holding('INFY-EQ', invested: 20000, pnl: -1200),
    ]);
    // Never connects in tests: the opener waits forever.
    stream = MarketStream(
      ApiClient.withDio(Dio()),
      opener: (_, _) => Completer<Stream<List<int>>>().future,
    );
  });

  tearDown(() => stream.dispose());

  Future<FakeAuthRepository> pumpApp(
    WidgetTester tester, {
    bool premium = true,
    Size size = const Size(390, 844),
  }) async {
    tester.view
      ..physicalSize = size * 3
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final (SessionProvider session, FakeAuthRepository auth) = await signedInSession(
      telemetry,
      premium: premium,
    );
    final router = GoRouter(
      initialLocation: '/trade',
      routes: [
        GoRoute(
          path: '/trade',
          builder: (context, state) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => TradeViewModel(trading: trading, telemetry: telemetry),
              ),
              ChangeNotifierProvider(
                create: (_) => LiveWatchViewModel(
                  portfolio: portfolio,
                  research: FakeResearchRepository(),
                  stream: stream,
                  telemetry: telemetry,
                ),
              ),
              ChangeNotifierProvider(
                create: (_) => PremiumViewModel(
                  trading: trading,
                  auth: auth,
                  session: session,
                  telemetry: telemetry,
                ),
              ),
            ],
            child: const TradeScreen(),
          ),
        ),
        GoRoute(
          path: '/trade/profile',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => RiskProfileViewModel(
              trading: trading,
              telemetry: telemetry,
              initial: state.extra as RiskProfile?,
            ),
            child: const RiskProfileScreen(),
          ),
        ),
        GoRoute(
          path: '/rebalancer',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => RebalancerViewModel(portfolio: portfolio, telemetry: telemetry),
            child: const RebalancerScreen(),
          ),
        ),
        GoRoute(path: '/portfolio', builder: (context, state) => const Text('Portfolio tab')),
        GoRoute(path: '/agent', builder: (context, state) => const Text('Agent tab')),
        GoRoute(path: '/account', builder: (context, state) => const Text('Account')),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<Telemetry>.value(value: telemetry),
          Provider<Prefs>.value(value: prefs),
          Provider<DeviceAuth>.value(value: deviceAuth),
          Provider<ServerClock>.value(value: ServerClock()),
          Provider<BrokerRegistry>.value(value: BrokerRegistry()),
          Provider<LinkOpener>.value(value: LinkOpener(telemetry)),
          ChangeNotifierProvider(create: (_) => PrivacyProvider(prefs)),
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
    return auth;
  }

  /// Ticking countdowns never settle: pump a fixed while instead.
  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  /// Scrolls [finder] fully into view in the screen's main list.
  Future<void> reveal(WidgetTester tester, Finder finder) async {
    await tester.scrollUntilVisible(finder, 300, scrollable: find.byType(Scrollable).first);
    await tester.ensureVisible(finder);
    await settle(tester);
  }

  Future<void> acceptDisclosure() => prefs.setRiskDisclosureAccepted(hashUserId('A123'));

  testWidgets('without Premium: what it adds, and turning it on', (tester) async {
    final auth = await pumpApp(tester, premium: false);
    expect(find.text('Premium trading agent'), findsOneWidget);
    expect(find.text('Trade proposals'), findsNothing);

    await tester.tap(find.text('Activate Premium'));
    await tester.pump();
    expect(find.text('Enter your WhatsApp number.'), findsOneWidget);
    expect(trading.calls.where((c) => c.startsWith('premium')), isEmpty);

    auth.sessionResult = Success(signedInAs('A123', premium: true));
    await tester.enterText(find.byType(TextField).first, '9876543210');
    await tester.tap(find.text('Activate Premium'));
    await settle(tester);
    expect(trading.calls, contains('premium:91:9876543210'));
    expect(find.text('Trade proposals'), findsOneWidget);
  });

  testWidgets('approving: disclosure once, the order in full, the device check, the result', (
    tester,
  ) async {
    await pumpApp(tester);
    expect(find.textContaining('Expires in 4:'), findsOneWidget);

    await tester.tap(find.text('Approve'));
    await settle(tester);
    expect(find.text(Disclaimers.tradingRiskTitle), findsOneWidget);
    await tester.tap(find.text(Disclaimers.tradingRiskAccept));
    await tester.pump();
    await tester.tap(find.text('Continue'));
    await settle(tester);

    expect(find.text('Place this order?'), findsOneWidget);
    expect(find.text('₹3,500.00'), findsOneWidget);
    expect(find.text('₹35,000.00'), findsOneWidget, reason: 'value: 10 × ₹3,500');
    expect(find.text('Angel One · A123'), findsOneWidget);
    expect(trading.calls.where((c) => c.startsWith('approve')), isEmpty);

    await tester.tap(find.text('Confirm and place order'));
    await settle(tester);
    expect(deviceAuth.reasons, hasLength(1));
    expect(trading.calls, contains('approve:a1b2c3d4'));
    expect(find.text('Order placed'), findsOneWidget);
    expect(find.text('Order ID ORD1'), findsWidgets);
  });

  testWidgets('a phone with no screen lock holds a button instead', (tester) async {
    await acceptDisclosure();
    deviceAuth.result = DeviceAuthResult.unavailable;
    await pumpApp(tester);
    await tester.tap(find.text('Approve'));
    await settle(tester);
    await tester.tap(find.text('Confirm and place order'));
    await settle(tester);
    expect(find.text('Hold to place order'), findsOneWidget);

    // A tap is not enough.
    await tester.tap(find.text('Hold to place order'));
    await settle(tester);
    expect(trading.calls.where((c) => c.startsWith('approve')), isEmpty);

    final gesture = await tester.startGesture(tester.getCenter(find.text('Hold to place order')));
    for (var i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    await gesture.up();
    await settle(tester);
    expect(trading.calls, contains('approve:a1b2c3d4'));
  });

  testWidgets('an expired proposal cannot be approved', (tester) async {
    trading.list = [
      proposal('old', createdAt: DateTime.now().toUtc().subtract(const Duration(minutes: 6))),
    ];
    await pumpApp(tester);
    expect(find.text('EXPIRED'), findsOneWidget);
    expect(find.text('Approve'), findsNothing);
  });

  testWidgets('swiping rejects; it can never approve', (tester) async {
    await pumpApp(tester);
    await tester.drag(find.text('10 × TCS'), const Offset(-500, 0));
    await settle(tester);
    expect(trading.calls, contains('reject:a1b2c3d4'));
    expect(find.text('REJECTED'), findsOneWidget);
    expect(trading.calls.where((c) => c.startsWith('approve')), isEmpty);
  });

  testWidgets('a lost approval still with the broker points to Orders', (tester) async {
    await acceptDisclosure();
    trading.onApprove = (id) {
      trading.settle(id, ProposalStatus.approved);
      return const Err(UnknownOutcomeFailure());
    };
    await pumpApp(tester);
    await tester.tap(find.text('Approve'));
    await settle(tester);
    await tester.tap(find.text('Confirm and place order'));
    await settle(tester);
    expect(find.text('Sent to your broker'), findsOneWidget);
    await tester.tap(find.text('Open Orders'));
    await settle(tester);
    expect(find.text('Portfolio tab'), findsOneWidget);
  });

  testWidgets('no risk profile: set one up, and it shows', (tester) async {
    await pumpApp(tester);
    await reveal(tester, find.text('Set up risk profile'));
    await tester.tap(find.text('Set up risk profile'));
    await settle(tester);
    expect(find.text('Wealth creation'), findsOneWidget);

    await reveal(tester, find.text('Save risk profile'));
    await tester.tap(find.text('Save risk profile'));
    await settle(tester);
    expect(trading.calls, contains('saveProfile'));
    expect(find.text('Risk profile saved'), findsOneWidget);
    await reveal(tester, find.text('Max trades a day'));
    expect(find.text('₹5,00,000'), findsOneWidget);
  });

  for (final size in [const Size(320, 640), const Size(1280, 800)]) {
    testWidgets('fits at ${size.width.toInt()}pt', (tester) async {
      trading
        ..list = [
          proposal('a1b2c3d4', symbol: 'BAJAJ-AUTO-EQ', quantity: 12000, side: TradeSide.sell),
          proposal('e5f6a7b8', status: ProposalStatus.failed, error: 'Risk check failed: ' * 4),
        ]
        ..profile = RiskProfile.starter
        ..schedule = BriefingSchedule(id: 1, enabled: true, nextRun: DateTime.utc(2026, 10, 13, 3));
      await pumpApp(tester, size: size);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('the rebalancer simulates, and refuses to spend more than there is', (tester) async {
    await pumpApp(tester);
    await reveal(tester, find.text('What-if rebalancer'));
    await tester.tap(find.text('What-if rebalancer'));
    await settle(tester);

    // Sell all of TCS: its value is freed.
    final slider = find.byType(Slider).first;
    await tester.drag(slider, const Offset(1000, 0));
    await settle(tester);
    expect(find.text('100% sold'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, 'INFY'));
    await tester.enterText(find.byType(TextField), '99999999');
    await tester.tap(find.text('Apply'));
    await settle(tester);
    expect(find.textContaining('more than the'), findsOneWidget);
  });

  testWidgets('accessible: 2× text, labelled 48-point tap targets', (tester) async {
    useLargeText(tester);
    trading
      ..profile = RiskProfile.starter
      ..schedule = BriefingSchedule(id: 1, enabled: true, nextRun: DateTime.utc(2026, 10, 13, 3));
    await pumpApp(tester);
    await expectAccessibleTapTargets(tester);
    await scrollThrough(tester);
  });
}
