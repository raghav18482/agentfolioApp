import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/charts/time_series_chart.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/features/learn/presentation/screens/learn_screen.dart';
import 'package:agentfolio/features/learn/presentation/view_models/learn_view_model.dart';
import 'package:agentfolio/features/stock_detail/presentation/screens/stock_detail_screen.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../helpers/a11y.dart';
import '../../helpers/fake_portfolio_repository.dart';
import '../../helpers/fake_research_repository.dart';
import '../../helpers/recording_sink.dart';
import '../portfolio/portfolio_logic_test.dart' show holding;

class _MockPrefs extends Mock implements Prefs;

void main() {
  late Telemetry telemetry;
  late RecordingSink sink;
  late FakeResearchRepository research;
  late _MockPrefs prefs;

  setUp(() async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    (telemetry, sink) = await recordingTelemetry();
    research = FakeResearchRepository();
    prefs = _MockPrefs();
    when(() => prefs.hideBalances).thenReturn(false);
  });

  /// The real screens under a router, so "Read more" really navigates.
  Widget app({String initial = '/stock/RELIANCE-EQ'}) {
    final router = GoRouter(
      initialLocation: initial,
      routes: [
        GoRoute(
          path: Routes.stock,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => StockDetailViewModel(
              symbol: state.pathParameters['symbol']!,
              research: research,
              portfolio: FakePortfolioRepository([
                holding('RELIANCE-EQ', invested: 900, pnl: 120),
                holding('TCS-EQ', invested: 2000),
              ]),
              telemetry: telemetry,
            ),
            child: const StockDetailScreen(),
          ),
        ),
        GoRoute(
          path: Routes.learn,
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => LearnViewModel(research: research, telemetry: telemetry),
            child: LearnScreen(focus: state.uri.queryParameters[Routes.learnFocusParam]),
          ),
        ),
      ],
    );
    return MultiProvider(
      providers: [
        Provider<Telemetry>.value(value: telemetry),
        Provider(create: (_) => LinkOpener(telemetry)),
        ChangeNotifierProvider(create: (_) => PrivacyProvider(prefs)),
      ],
      child: MaterialApp.router(
        theme: AppTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: router,
      ),
    );
  }

  void phone(WidgetTester tester) {
    tester.view
      ..physicalSize = const Size(390 * 3, 844 * 3)
      ..devicePixelRatio = 3;
    addTearDown(tester.view.reset);
  }

  /// The visible tab's own scroll view (tabs are kept alive, so there are several).
  Finder tabScroll(String tab) => find
      .descendant(of: find.byKey(PageStorageKey<String>(tab)), matching: find.byType(Scrollable))
      .first;

  /// Scrolls [finder] to the middle of the screen, clear of the pinned header.
  Future<void> centre(WidgetTester tester, Finder finder) async {
    await Scrollable.ensureVisible(tester.element(finder), alignment: 0.5);
    await tester.pumpAndSettle();
  }

  /// Taps a tab, scrolling the tab bar to it first: the test font is far
  /// wider than the app's, so later tabs start off-screen.
  Future<void> openTab(WidgetTester tester, String label) async {
    final tab = find.descendant(of: find.byType(TabBar), matching: find.text(label));
    await tester.ensureVisible(tab);
    await tester.pumpAndSettle();
    await tester.tap(tab);
    await tester.pumpAndSettle();
  }

  /// Unmounts the screen so periodic timers (the regenerate countdown) stop.
  Future<void> unmount(WidgetTester tester) => tester.pumpWidget(const SizedBox());

  testWidgets('Overview: price, position, key stats and an honestly labelled outlook', (
    tester,
  ) async {
    phone(tester);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('RELIANCE'), findsWidgets);
    expect(find.text('₹1,020.00'), findsWidgets); // the broker LTP, preferred
    expect(find.text('HELD'), findsOneWidget);
    expect(find.text('Your position'), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('Direction outlook'),
      300,
      scrollable: tabScroll('overview'),
    );
    await tester.pumpAndSettle();
    expect(find.text('Rule-based score (no model)'), findsOneWidget);
    // The server's own caveat, verbatim.
    expect(find.textContaining('not a calibrated probability'), findsOneWidget);
    expect(research.calls, containsAllInOrder(['technicals', 'prediction']));
    expect(research.calls, isNot(contains('fundamentals')));
  });

  testWidgets('Fundamentals: score, metric sheet, and "Read more" lands on that metric in Learn', (
    tester,
  ) async {
    phone(tester);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await openTab(tester, 'Fundamentals');
    expect(find.text('C · Average'), findsOneWidget);
    expect(find.text(Disclaimers.scoreLimits), findsOneWidget);
    expect(
      sink.events.where((e) => e.name == EventName.uiChanged).map((e) => e.properties['selection']),
      contains('fundamentals'),
    );

    await centre(tester, find.text('P/E ratio'));
    await tester.tap(find.text('P/E ratio'));
    await tester.pumpAndSettle();
    expect(find.text('Price to Earnings'), findsOneWidget);
    expect(find.text('This stock: 24.1x — Fairly valued'), findsOneWidget);

    await tester.tap(find.text('Read more in the guide'));
    await tester.pumpAndSettle();
    expect(find.text('What the numbers actually mean'), findsOneWidget);
    // Scrolled to and on screen.
    final pe = tester.getRect(find.text('Price to Earnings').last);
    expect(pe.top, greaterThanOrEqualTo(0));
    expect(pe.bottom, lessThanOrEqualTo(844));

    await tester.pump(const Duration(seconds: 3)); // the highlight fades
  });

  testWidgets('AI: the summary, a regenerate countdown, and the Responsible AI text verbatim', (
    tester,
  ) async {
    phone(tester);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    await openTab(tester, 'AI');

    expect(find.textContaining('solid business', findRichText: true), findsOneWidget);
    expect(find.textContaining(RegExp(r'Regenerate in \d+s')), findsOneWidget);
    expect(find.text(Disclaimers.responsibleAiFineprint), findsOneWidget);
    await unmount(tester);
  });

  testWidgets('dragging across the chart reads out that day, and lifting restores the range', (
    tester,
  ) async {
    phone(tester);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    final chart = find.byType(TimeSeriesChart).first;
    final weekday = find.textContaining(RegExp('^(Mon|Tue|Wed|Thu|Fri|Sat|Sun), '));
    expect(find.text('in 3M'), findsOneWidget);
    expect(weekday, findsNothing);

    final gesture = await tester.startGesture(tester.getCenter(chart));
    await gesture.moveBy(const Offset(40, 0));
    await tester.pump();
    expect(weekday, findsOneWidget);
    expect(find.textContaining(RegExp(r'^Volume \d')), findsOneWidget);

    await gesture.up();
    await tester.pump();
    expect(weekday, findsNothing);
    expect(find.text('in 3M'), findsOneWidget);
  });

  testWidgets('a stock too new for indicators says so calmly, without a useless Retry', (
    tester,
  ) async {
    phone(tester);
    research.technicalsResult = const Err(
      UnavailableFailure('Not enough candle data (need at least 20 days)'),
    );
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('Not available for this stock'), findsWidgets);
    expect(find.textContaining('need at least 20 days'), findsWidgets);
    expect(find.text('Retry'), findsNothing);
    // The header still has a price, from the holding.
    expect(find.text('₹1,020.00'), findsWidgets);
  });

  testWidgets('a network failure offers Retry, which loads again', (tester) async {
    phone(tester);
    research.technicalsResult = const Err(NetworkFailure());
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    final before = research.calls.where((c) => c == 'technicals').length;

    expect(find.text('Retry'), findsOneWidget, reason: 'one error card for the shared request');
    await tester.tap(find.text('Retry').first);
    await tester.pumpAndSettle();
    expect(research.calls.where((c) => c == 'technicals').length, greaterThan(before));
  });

  testWidgets('a stock the user does not hold has no position card', (tester) async {
    phone(tester);
    await tester.pumpWidget(app(initial: '/stock/${Uri.encodeComponent('M&M-EQ')}'));
    await tester.pumpAndSettle();
    expect(find.text('M&M'), findsWidgets);
    expect(find.text('HELD'), findsNothing);
    expect(find.text('Your position'), findsNothing);
    expect(find.text('₹1,010.00'), findsWidgets); // the last close
  });

  testWidgets('on a tablet every tab lays out in two columns without overflow', (tester) async {
    tester.view
      ..physicalSize = const Size(1180 * 2, 820 * 2)
      ..devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    for (final tab in ['Fundamentals', 'Technicals', 'AI', 'Overview']) {
      await openTab(tester, tab);
    }
    expect(tester.takeException(), isNull);
    await unmount(tester);
  });

  testWidgets('Learn opened at the scoring anchor scrolls to it', (tester) async {
    phone(tester);
    await tester.pumpWidget(app(initial: Routes.learnAt(Routes.learnScoringAnchor)));
    await tester.pumpAndSettle();
    final limits = tester.getRect(find.text('It cannot see management quality.'));
    expect(limits.top, greaterThanOrEqualTo(0));
    expect(limits.bottom, lessThanOrEqualTo(844));
    await tester.pump(const Duration(seconds: 3));
  });

  testWidgets('accessible: every tab at 2× text', (tester) async {
    useLargeText(tester);
    phone(tester);
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();
    await expectAccessibleTapTargets(tester);
    for (final tab in ['Fundamentals', 'Technicals', 'AI']) {
      await openTab(tester, tab);
      expect(tester.takeException(), isNull, reason: tab);
    }
    await unmount(tester);
  });
}
