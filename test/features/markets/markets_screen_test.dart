import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/features/markets/data/models/markets_dtos.dart';
import 'package:agentfolio/features/markets/domain/entities/markets.dart';
import 'package:agentfolio/features/markets/domain/repositories/markets_repository.dart';
import 'package:agentfolio/features/markets/presentation/screens/markets_screen.dart';
import 'package:agentfolio/features/markets/presentation/view_models/markets_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../helpers/a11y.dart';
import '../../helpers/fake_portfolio_repository.dart';
import '../../helpers/recording_sink.dart';
import '../portfolio/portfolio_logic_test.dart' show holding;
import 'markets_fixtures.dart';

class _MockPrefs extends Mock implements Prefs;

class FakeMarketsRepository implements MarketsRepository {
  final calls = <String>[];
  Result<List<SectorExposure>> sectorsResult = Success([
    for (final s in sectorsJson()['sectors']! as List)
      SectorExposureDto.fromJson(s as Map<String, dynamic>).toEntity(),
  ]);
  Result<NewsSentiment> sentimentResult = Success(
    SentimentDto.fromJson(sentimentJson()).toEntity(),
  );
  NewsSentiment? _sentiment;
  bool emptyNews = false;

  @override
  Future<Result<PortfolioNews>> portfolioNews(NewsPeriod period, {bool force = false}) async {
    calls.add('news:${period.wire}');
    return Success(
      PortfolioNews(
        period: period,
        sectors: [
          for (final s in portfolioNewsJson()['sectors']! as List)
            SectorNewsDto.fromJson(s as Map<String, dynamic>).toEntity(),
        ].map((s) => emptyNews ? s.copyWith(articles: const []) : s).toList(),
      ),
    );
  }

  @override
  Future<Result<NewsSentiment>> sentiment(PortfolioNews news) async {
    calls.add('sentiment');
    _sentiment = sentimentResult.valueOrNull;
    return sentimentResult;
  }

  @override
  NewsSentiment? cachedSentiment(NewsPeriod period) => _sentiment;

  @override
  Future<Result<List<NewsArticle>>> search(String query, NewsPeriod period) async {
    calls.add('search');
    return Success(
      query == 'nothing' ? const [] : [ArticleDto.fromJson(article('Found $query')).toEntity()],
    );
  }

  @override
  Future<Result<MarketBreadth>> breadth({bool force = false}) async {
    calls.add('breadth');
    return Success(BreadthDto.fromJson(breadthJson()).toEntity());
  }

  @override
  Future<Result<List<SectorExposure>>> sectors({bool force = false}) async {
    calls.add('sectors');
    return sectorsResult;
  }
}

void main() {
  late Telemetry telemetry;
  late RecordingSink sink;
  late FakeMarketsRepository repo;
  late _MockPrefs prefs;

  setUp(() async {
    (telemetry, sink) = await recordingTelemetry();
    repo = FakeMarketsRepository();
    prefs = _MockPrefs();
    when(() => prefs.hideBalances).thenReturn(false);
  });

  MarketsViewModel vm() => MarketsViewModel(
    markets: repo,
    portfolio: FakePortfolioRepository([holding('TCS-EQ', invested: 9000), holding('ITC-EQ')]),
    telemetry: telemetry,
  );

  group('view model', () {
    test("opening loads this period's news only", () async {
      final model = vm();
      await model.load();
      expect(repo.calls, ['news:7d']);
    });

    test('sectors load the first time that segment is shown, once', () async {
      final model = vm()
        ..selectView(MarketsView.sectors)
        ..selectView(MarketsView.news)
        ..selectView(MarketsView.sectors);
      await pumpEventQueue();
      expect(repo.calls.where((c) => c == 'sectors'), hasLength(1));
      expect(repo.calls.where((c) => c == 'breadth'), hasLength(1));
      expect(model.sectors.data, hasLength(2));
    });

    test('a period read before is shown again without a request', () async {
      final model = vm();
      await model.load();
      model
        ..selectPeriod(NewsPeriod.month)
        ..selectPeriod(NewsPeriod.week);
      await pumpEventQueue();
      expect(repo.calls, ['news:7d', 'news:1m']);
      expect(model.news.data!.period, NewsPeriod.week);
    });

    test('sentiment runs only on request, then tones replace the plain sectors', () async {
      final model = vm();
      await model.load();
      expect(repo.calls, isNot(contains('sentiment')));
      expect(model.newsSectors.first.sentiment, isNull);
      await model.readSentiment();
      expect(model.newsSectors.first.sentiment!.mood, Mood.bullish);
      expect(model.sentiment.data!.overall.total, 3);
    });

    test('search trims and collapses spaces, ignores repeats, and clears back to news', () async {
      final model = vm();
      await model.load();
      model.submitSearch('  reliance   industries ');
      await pumpEventQueue();
      expect(model.query, 'reliance industries');
      model.submitSearch('reliance industries');
      await pumpEventQueue();
      expect(repo.calls.where((c) => c == 'search'), hasLength(1));
      model.clearSearch();
      expect(model.searching, isFalse);
    });

    test("suggestions start with the user's largest holdings", () {
      expect(vm().suggestions.first, 'TCS');
    });
  });

  group('screen', () {
    Widget app() => MultiProvider(
      providers: [
        Provider<Telemetry>.value(value: telemetry),
        Provider(create: (_) => LinkOpener(telemetry)),
        ChangeNotifierProvider(create: (_) => PrivacyProvider(prefs)),
      ],
      child: MaterialApp(
        theme: AppTheme.dark(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: ChangeNotifierProvider(create: (_) => vm(), child: const MarketsScreen()),
      ),
    );

    void size(WidgetTester tester, Size logical) {
      tester.view
        ..physicalSize = logical * 3
        ..devicePixelRatio = 3;
      addTearDown(tester.view.reset);
    }

    testWidgets('accessible: news and sectors at 2× text', (tester) async {
      useLargeText(tester);
      size(tester, const Size(390, 844));
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      await expectAccessibleTapTargets(tester);
      await scrollThrough(tester, steps: 8);
      await tester.tap(find.text('Sectors'));
      await tester.pumpAndSettle();
      await expectAccessibleTapTargets(tester);
    });

    testWidgets('news: sector groups, the first open, and sentiment on request', (tester) async {
      size(tester, const Size(390, 844));
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      expect(find.text('IT'), findsOneWidget);
      expect(find.text('TCS wins deal'), findsOneWidget, reason: 'the first sector starts open');
      expect(find.text('Oil slips'), findsNothing, reason: 'the others start closed');
      expect(find.text('Sentiment pulse'), findsOneWidget);
      expect(repo.calls, isNot(contains('sentiment')));

      await tester.tap(find.text('Read the mood'));
      await tester.pumpAndSettle();
      expect(repo.calls, contains('sentiment'));
      expect(find.text('BULLISH'), findsOneWidget, reason: 'IT gets its mood pill');
      expect(find.text('from 3 headlines'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('a server without a sentiment model says so plainly, without Retry', (
      tester,
    ) async {
      size(tester, const Size(390, 844));
      repo.sentimentResult = const Err(
        BrokerFailure('Sentiment analysis requires transformers and torch.', statusCode: 503),
      );
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Read the mood'));
      await tester.pumpAndSettle();
      expect(find.textContaining("isn't available"), findsOneWidget);
      expect(find.textContaining('torch'), findsNothing);
    });

    testWidgets('search: suggestions on focus, results, and the query is never reported', (
      tester,
    ) async {
      size(tester, const Size(390, 844));
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();
      expect(find.widgetWithText(ActionChip, 'TCS'), findsOneWidget);

      await tester.enterText(find.byType(TextField), 'secret query');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle();
      expect(find.text('Found secret query'), findsOneWidget);
      expect(
        sink.events.every((e) => !e.properties.values.any((v) => '$v'.contains('secret'))),
        isTrue,
        reason: 'user-entered text must not reach analytics',
      );

      await tester.tap(find.byTooltip('Clear search'));
      await tester.pumpAndSettle();
      expect(find.text('IT'), findsOneWidget);
    });

    testWidgets("sectors: breadth, movers and the user's sectors", (tester) async {
      size(tester, const Size(390, 844));
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sectors'));
      await tester.pumpAndSettle();

      expect(find.text('India VIX'), findsOneWidget);
      expect(find.text('13.42'), findsOneWidget);
      expect(find.text('40 / 22'), findsOneWidget);
      expect(find.text('Nifty IT'), findsOneWidget);
      expect(find.text('+0.55'), findsOneWidget, reason: 'no live VIX move, so the points change');
      expect(
        sink.events
            .where((e) => e.name == EventName.uiChanged)
            .map((e) => e.properties['selection']),
        contains('sectors'),
      );

      await tester.scrollUntilVisible(find.text('Your sectors'), 300);
      await tester.pumpAndSettle();
      expect(find.text('Index: NIFTY IT'), findsOneWidget, reason: 'the first sector starts open');
      expect(tester.takeException(), isNull);
    });

    testWidgets('every sector empty: says the news source may be down, with Retry', (tester) async {
      size(tester, const Size(390, 844));
      repo.emptyNews = true;
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      expect(find.text('No headlines came back'), findsOneWidget);
      final before = repo.calls.where((c) => c.startsWith('news')).length;
      await tester.tap(find.text('Retry'));
      await tester.pumpAndSettle();
      expect(repo.calls.where((c) => c.startsWith('news')).length, before + 1);
    });

    testWidgets('no holdings: an empty state, not an error', (tester) async {
      size(tester, const Size(390, 844));
      repo.sectorsResult = const Success([]);
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sectors'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.text('No sectors yet'), 300);
      expect(find.text('No sectors yet'), findsOneWidget);
    });

    testWidgets('lays out without overflow on a small phone and a tablet', (tester) async {
      for (final s in const [Size(320, 640), Size(1180, 820)]) {
        size(tester, s);
        // A fresh screen per size, so each starts from News.
        await tester.pumpWidget(KeyedSubtree(key: ValueKey(s), child: app()));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Read the mood'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Sectors'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: '$s');
      }
    });
  });
}
