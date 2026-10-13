import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/features/ai/presentation/providers/ai_key_provider.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ai_insights_view_model.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ask_view_model.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ask_sheet.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:agentfolio/features/portfolio/presentation/screens/home_screen.dart';
import 'package:agentfolio/features/portfolio/presentation/screens/portfolio_screen.dart';
import 'package:agentfolio/features/portfolio/presentation/view_models/home_view_model.dart';
import 'package:agentfolio/features/portfolio/presentation/view_models/portfolio_view_model.dart';
import 'package:agentfolio/features/portfolio/presentation/widgets/hero_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../helpers/a11y.dart';
import '../../helpers/fake_ai.dart';
import '../../helpers/recording_sink.dart';
import 'portfolio_logic_test.dart' show holding;

class _MockPrefs extends Mock implements Prefs;

class _FakeRepo implements PortfolioRepository {
  Result<PortfolioSnapshot> snapshotResult = Success(
    PortfolioSnapshot(
      holdings: [
        holding('TCS-EQ', invested: 30000, pnl: 4500),
        holding('INFY-EQ', invested: 20000, pnl: -1200),
        holding('ITC-EQ', invested: 10000, pnl: 300),
      ],
      summary: const PortfolioSummary(
        totalInvested: 60000,
        currentValue: 63600,
        overallPnl: 3600,
        overallPnlPercent: 6,
        dayPnl: 250,
      ),
      funds: const Funds(availableCash: 15000, net: 78600),
      fetchedAt: DateTime.now(),
    ),
  );

  @override
  Future<Result<PortfolioSnapshot>> snapshot({bool force = false}) async => snapshotResult;
  @override
  PortfolioSnapshot? cachedSnapshot() => null;
  @override
  Future<Result<Positions>> positions({bool force = false}) async =>
      const Success(Positions(positions: [], totalPnl: 0));
  @override
  Positions? cachedPositions() => null;
  @override
  Future<Result<List<Order>>> orders({bool force = false}) async => const Success([]);
  @override
  List<Order>? cachedOrders() => null;
  @override
  Future<Result<List<Trade>>> trades({bool force = false}) async => const Success([]);
  @override
  List<Trade>? cachedTrades() => null;
  @override
  Future<Result<BenchmarkComparison>> benchmark({int days = 90, bool force = false}) async =>
      const Err(ServerFailure('Could not fetch NIFTY 50 data'));
  @override
  Future<Result<SectorMap>> sectorMap() async => const Success({'TCS-EQ': 'IT', 'INFY-EQ': 'IT'});
}

void main() {
  late Telemetry telemetry;
  late _FakeRepo repo;
  late _MockPrefs prefs;
  late AiKeyProvider aiKey;
  late FakeAiRepository ai;

  setUp(() async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    (telemetry, _) = await recordingTelemetry();
    final (session, _) = await signedInSession(telemetry);
    aiKey = AiKeyProvider(
      repository: FakeAiKeyRepository(),
      session: session,
      telemetry: telemetry,
    );
    ai = FakeAiRepository();
    repo = _FakeRepo();
    prefs = _MockPrefs();
    when(() => prefs.hideBalances).thenReturn(false);
    when(() => prefs.setHideBalances(hide: any(named: 'hide'))).thenAnswer((_) async {});
  });

  Widget app(Widget child) => MultiProvider(
    providers: [
      Provider<Telemetry>.value(value: telemetry),
      ChangeNotifierProvider(create: (_) => PrivacyProvider(prefs)),
      ChangeNotifierProvider<AiKeyProvider>.value(value: aiKey),
    ],
    child: MaterialApp(
      theme: AppTheme.dark(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: child,
    ),
  );

  Widget home() => app(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(repository: repo, telemetry: telemetry),
        ),
        ChangeNotifierProvider(
          create: (_) => AiInsightsViewModel(ai: ai, aiKey: aiKey, telemetry: telemetry),
        ),
        Provider<AskViewModelFactory>.value(
          value: () => AskViewModel(ai: ai, aiKey: aiKey, telemetry: telemetry),
        ),
      ],
      child: const HomeScreen(),
    ),
  );

  testWidgets('Home shows the value, both P&Ls, funds and the heatmap', (tester) async {
    await tester.pumpWidget(home());
    await tester.pumpAndSettle();

    // Counted up to the final value; the donut's centre shows it too.
    expect(
      find.descendant(of: find.byType(HeroCard), matching: find.text('₹63,600')),
      findsOneWidget,
    );
    expect(find.text('+₹3,600.00'), findsOneWidget);
    expect(find.text('+₹250.00'), findsOneWidget);
    expect(find.text('₹15,000'), findsOneWidget);
    expect(find.text('P&L heatmap'), findsOneWidget);
  });

  testWidgets('Hide balances masks every amount', (tester) async {
    await tester.pumpWidget(home());
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Hide balances'));
    await tester.pumpAndSettle();

    expect(find.text('₹63,600'), findsNothing);
    expect(find.text('₹ ••••'), findsWidgets);
  });

  testWidgets('a failed refresh keeps the data and says how old it is', (tester) async {
    await tester.pumpWidget(home());
    await tester.pumpAndSettle();
    repo.snapshotResult = const Err(NetworkFailure());
    await tester.fling(find.byType(CustomScrollView), const Offset(0, 400), 1000);
    await tester.pumpAndSettle();

    expect(
      find.descendant(of: find.byType(HeroCard), matching: find.text('₹63,600')),
      findsOneWidget,
    );
    expect(find.textContaining("Couldn't refresh"), findsOneWidget);
  });

  testWidgets('Holdings can be searched, and positions show their empty state', (tester) async {
    await tester.pumpWidget(
      app(
        ChangeNotifierProvider(
          create: (_) => PortfolioViewModel(repository: repo, telemetry: telemetry),
          child: const PortfolioScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('TCS'), findsOneWidget);
    expect(find.text('INFY'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'inf');
    await tester.pumpAndSettle();
    expect(find.text('TCS'), findsNothing);
    expect(find.text('INFY'), findsOneWidget);

    await tester.tap(find.text('Positions'));
    await tester.pumpAndSettle();
    expect(find.text('No open positions today'), findsOneWidget);
  });

  testWidgets('long-pressing a holding peeks at it, without overflowing a phone', (tester) async {
    tester.view
      ..physicalSize = const Size(402 * 3, 874 * 3)
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      app(
        ChangeNotifierProvider(
          create: (_) => PortfolioViewModel(repository: repo, telemetry: telemetry),
          child: const PortfolioScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.longPress(find.text('TCS'));
    await tester.pumpAndSettle();
    expect(find.text('Open full details'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('accessible: Home at 2× text, labelled 48-point tap targets', (tester) async {
    useLargeText(tester);
    tester.view
      ..physicalSize = const Size(390, 844) * 3
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(home());
    await tester.pumpAndSettle();
    await expectAccessibleTapTargets(tester);
    await scrollThrough(tester);
  });
}
