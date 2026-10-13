import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/features/markets/data/datasources/markets_remote_data_source.dart';
import 'package:agentfolio/features/markets/data/models/markets_dtos.dart';
import 'package:agentfolio/features/markets/data/repositories/markets_repository_impl.dart';
import 'package:agentfolio/features/markets/domain/entities/markets.dart';
import 'package:agentfolio/features/markets/domain/logic/markets_logic.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'markets_fixtures.dart';

void main() {
  group('DTOs', () {
    test('gnews dates parse as RFC 1123, then ISO, else stay raw', () {
      expect(parseNewsDate('Sun, 11 Oct 2026 07:00:00 GMT'), DateTime.utc(2026, 10, 11, 7));
      expect(parseNewsDate('2026-10-11T07:00:00Z'), DateTime.utc(2026, 10, 11, 7));
      expect(parseNewsDate('yesterday'), isNull);
      expect(parseNewsDate(''), isNull);
    });

    test('only real web links are kept', () {
      expect(webLink('https://news.google.com/x'), isNotNull);
      expect(webLink('#'), isNull);
      expect(webLink('javascript:alert(1)'), isNull);
      expect(webLink('mailto:a@b.c'), isNull);
    });

    test('portfolio news parses sectors and articles, dropping untitled ones', () {
      final dto = SectorNewsDto.fromJson({
        'name': 'IT',
        'invested': '1200.5',
        'news': [
          article('Real'),
          {'title': '  ', 'link': '#'},
        ],
      });
      final s = dto.toEntity();
      expect(s.invested, 1200.5);
      expect(s.articles.map((a) => a.title), ['Real']);
      expect(s.articles.single.publishedAt, DateTime.utc(2026, 10, 11, 7));
    });

    test('sentiment parses tones, sector moods and the overall mood', () {
      final r = SentimentDto.fromJson(sentimentJson()).toEntity();
      expect(r.overall.mood, Mood.neutral);
      expect(r.overall.total, 3);
      expect(r.sectors.first.sentiment!.mood, Mood.bullish);
      expect(r.sectors.first.articles.first.sentiment!.tone, ArticleTone.positive);
      expect(r.sectors.last.sentiment!.score, -1);
    });

    test('the sentiment request echoes the articles back as the server expects', () {
      // The web app sends only sector names, which the server cannot analyse.
      final news = PortfolioNews(
        period: NewsPeriod.week,
        sectors: [
          for (final s in portfolioNewsJson()['sectors']! as List)
            SectorNewsDto.fromJson(s as Map<String, dynamic>).toEntity(),
        ],
      );
      final body = sentimentRequest(news);
      final first = (body['sectors']! as List).first as Map;
      expect(first['name'], 'IT');
      expect(first['invested'], 32000.5);
      final a = (first['news'] as List).first as Map;
      expect(a.keys, containsAll(['title', 'link', 'date', 'description', 'source']));
      expect(a['date'], 'Sun, 11 Oct 2026 07:00:00 GMT', reason: 'the raw date, unchanged');
    });

    test('breadth reads VIX, advances, 52-week counts and skips nameless indices', () {
      final b = BreadthDto.fromJson(breadthJson()).toEntity();
      expect((b.vix, b.vixChange), (13.42, 0.55));
      expect((b.advances, b.declines, b.week52Highs, b.week52Lows), (40, 22, 31, 9));
      expect(b.indices, hasLength(4));
      expect(b.vixChangePercent, isNull);
    });

    test('India VIX is taken out of the movers and its live move kept for the tile', () {
      final json = breadthJson();
      (json['sector_heatmap']! as List).add({'name': 'INDIA VIX', 'change': 5.98});
      final b = BreadthDto.fromJson(json).toEntity();
      expect(b.indices.map((i) => i.name), isNot(contains('INDIA VIX')));
      expect(b.vixChangePercent, 5.98);
    });

    test('sector overview: "No index for X" means no index, and gaps stay null', () {
      final sectors = [
        for (final s in sectorsJson()['sectors']! as List)
          SectorExposureDto.fromJson(s as Map<String, dynamic>).toEntity(),
      ];
      expect(sectors.first.indexName, 'NIFTY IT');
      expect(sectors.first.indexReturns!.quarter, isNull);
      expect(sectors.first.indexReturns!.year, 14);
      expect(sectors.first.holdings.first.symbol, 'TCS-EQ');
      expect(sectors.last.indexName, isNull);
      expect(sectors.last.indexReturns, isNull);
    });
  });

  group('logic', () {
    test('topMoves splits risers from fallers, biggest first, without flat ones', () {
      final moves = topMoves(const [
        IndexMove(name: 'A', changePercent: 1),
        IndexMove(name: 'B', changePercent: -3),
        IndexMove(name: 'C', changePercent: 2),
        IndexMove(name: 'D', changePercent: 0),
        IndexMove(name: 'E', changePercent: -1),
      ], count: 1);
      expect(moves.up.map((m) => m.name), ['C']);
      expect(moves.down.map((m) => m.name), ['B']);
    });

    test("moodOf uses the server's 20-point margin", () {
      expect(moodOf(bullish: 6, bearish: 3, neutral: 1), Mood.bullish);
      expect(moodOf(bullish: 2, bearish: 1, neutral: 7), Mood.neutral);
      expect(moodOf(bullish: 0, bearish: 3, neutral: 1), Mood.bearish);
      expect(moodOf(bullish: 0, bearish: 0, neutral: 0), Mood.neutral);
    });

    test('index names read naturally, acronyms and codes kept', () {
      expect(indexDisplayName('NIFTY FINANCIAL SERVICES'), 'Nifty Financial Services');
      expect(indexDisplayName('NIFTY FMCG'), 'Nifty FMCG');
      expect(indexDisplayName('NIFTY PSU BANK'), 'Nifty PSU Bank');
      expect(indexDisplayName('NIFTY50 TR 2X LEVERAGE'), 'Nifty50 TR 2X Leverage');
      expect(indexDisplayName('Nifty Smallcap 50'), 'Nifty Smallcap 50');
      expect(indexDisplayName('NIFTY IT'), 'Nifty IT');
    });

    test('suggestions put holdings first and drop duplicates', () {
      expect(searchSuggestions(['TCS', 'Nifty 50'], max: 4), [
        'TCS',
        'Nifty 50',
        'Sensex',
        'RBI policy',
      ]);
    });
  });

  group('repository', () {
    late FakeHttpAdapter adapter;
    late MarketsRepositoryImpl repo;

    setUp(() {
      adapter = FakeHttpAdapter((o) async => jsonBody({}));
      final dio = Dio(BaseOptions(baseUrl: 'https://api.test'))..httpClientAdapter = adapter;
      repo = MarketsRepositoryImpl(MarketsRemoteDataSource(ApiClient.withDio(dio)), RequestCache());
    });

    test('news is cached per period', () async {
      adapter.handler = (o) async => jsonBody(portfolioNewsJson());
      await repo.portfolioNews(NewsPeriod.week);
      await repo.portfolioNews(NewsPeriod.week);
      await repo.portfolioNews(NewsPeriod.month);
      expect(adapter.requests.map((r) => r.queryParameters['period']), ['7d', '1m']);
    });

    test('sentiment posts the full news and is reused until the news changes', () async {
      adapter.handler = (o) async =>
          jsonBody(o.method == 'POST' ? sentimentJson() : portfolioNewsJson());
      final news = (await repo.portfolioNews(NewsPeriod.week) as Success<PortfolioNews>).value;
      await repo.sentiment(news);
      await repo.sentiment(news);
      final posts = adapter.requests.where((r) => r.method == 'POST').toList();
      expect(posts, hasLength(1));
      expect(((posts.single.data as Map)['sectors'] as List).first, containsPair('name', 'IT'));
      expect(repo.cachedSentiment(NewsPeriod.week), isNotNull);

      await repo.portfolioNews(NewsPeriod.week, force: true);
      await repo.sentiment(news);
      expect(adapter.requests.where((r) => r.method == 'POST'), hasLength(2));
    });

    test('"No holdings found" is an empty sector list, not an error', () async {
      adapter.handler = (o) async => jsonBody({'error': 'No holdings found'}, status: 400);
      final r = await repo.sectors();
      expect(r, isA<Success<List<SectorExposure>>>());
      expect((r as Success<List<SectorExposure>>).value, isEmpty);
    });

    test('other sector errors still surface', () async {
      adapter.handler = (o) async => jsonBody({'error': 'NSE down'}, status: 500);
      expect((await repo.sectors()).failureOrNull, isA<ServerFailure>());
    });
  });
}
