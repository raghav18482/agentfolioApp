import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/features/research/data/datasources/research_remote_data_source.dart';
import 'package:agentfolio/features/research/data/models/research_dtos.dart';
import 'package:agentfolio/features/research/data/repositories/research_repository_impl.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/entities/prediction.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_http_adapter.dart';
import 'research_fixtures.dart';

void main() {
  group('DTOs', () {
    test('technical OHLC rows are read as [open, high, low, close]', () {
      final t = TechnicalsDto.fromJson(technicalJson()).toEntity();
      final first = t.history.bars.first;
      // The trap the web app once fell into: index 1 is the high, not the close.
      expect((first.open, first.high, first.low, first.close), (900, 905, 895, 902));
      expect(t.history.dates.first, DateTime(2026));
      expect(t.history.volumes.first, 1000);
    });

    test('an indicator sent as [] (too little history) becomes nulls, aligned to the dates', () {
      final h = TechnicalsDto.fromJson(technicalJson()).toEntity().history;
      expect(h.sma200, hasLength(h.length));
      expect(h.sma200.every((v) => v == null), isTrue);
      expect(h.sma50.last, isNotNull);
      expect(h.sma50.first, isNull);
    });

    test('a short indicator is aligned to the most recent dates', () {
      expect(alignToEnd([1, 2], 4), [null, null, 1, 2]);
      expect(alignToEnd([1, 2, 3, 4, 5], 3), [3, 4, 5]);
    });

    test('unknown signal statuses and numeric values are read safely', () {
      final t = TechnicalsDto.fromJson(technicalJson()).toEntity();
      expect(t.signals[1].value, '62.4');
      expect(t.signals[2].status, SignalStatus.neutral);
      expect(t.indicators.week52Low, 850.5);
    });

    test('fundamentals keep missing figures as null, never zero', () {
      final f = FundamentalsDto.fromJson(fundamentalJson()).toEntity();
      expect(f.valuation.peRatio, 24.1);
      expect(f.valuation.evEbitda, isNull);
      expect(f.valuation.pegRatio, isNull); // "N/A"
      expect(f.health.roce, isNull);
      expect(f.profitTrend.last.value, -1.0e10);
    });

    test('the score parses, with an unknown verdict read as unknown', () {
      final s = FundamentalsDto.fromJson(fundamentalJson()).toEntity().score!;
      expect(s.total, 64);
      expect(s.confidence, ScoreConfidence.medium);
      expect(s.pillars[0].metrics[1].verdict, Verdict.unknown);
      expect(s.pillars[1].score, isNull);
      expect(s.excluded, ['debt_to_equity', 'peg_ratio']);
    });

    test('empty valuation and health objects are fine', () {
      final f = FundamentalsDto.fromJson({
        'symbol': 'NIFTYBEES-EQ',
        'valuation': <String, Object?>{},
        'health': <String, Object?>{},
        'revenue_trend': <Object?>[],
        'profit_trend': <Object?>[],
        'score': null,
      }).toEntity();
      expect(f.valuation, const Valuation());
      expect(f.score, isNull);
    });

    test('prediction keeps known horizons only and normalises directions', () {
      final p = PredictionDto.fromJson(predictionJson()).toEntity();
      expect(p.calls.keys, [Horizon.day, Horizon.week, Horizon.month]);
      expect(p.calls[Horizon.month]!.direction, Direction.neutral);
      expect(p.isHeuristic, isTrue);
      expect(p.disclaimer, contains('not a calibrated probability'));
    });

    test('glossary keeps the file order and the metric key', () {
      final g = GlossaryDto.fromJson(glossaryJson()).toEntity();
      expect(g.pillars.map((p) => p.key), ['valuation', 'profitability']);
      expect(g.metrics.keys, ['pe_ratio', 'market_cap', 'roe']);
      expect(g.metrics['pe_ratio']!.key, 'pe_ratio');
      expect(g.metrics['pe_ratio']!.bands.last.max, isNull);
      expect(g.metrics['market_cap']!.isScored, isFalse);
    });
  });

  group('repository', () {
    late FakeHttpAdapter adapter;
    late ResearchRepositoryImpl repo;

    setUp(() {
      adapter = FakeHttpAdapter((o) async => jsonBody({}));
      final dio = Dio(BaseOptions(baseUrl: 'https://api.test'))..httpClientAdapter = adapter;
      repo = ResearchRepositoryImpl(
        ResearchRemoteDataSource(ApiClient.withDio(dio)),
        RequestCache(),
      );
    });

    test('"no data" sent as a 200 with an error is Unavailable, with the server text', () async {
      adapter.handler = (o) async => jsonBody({
        'error': 'Not enough candle data (need at least 20 days)',
        'symbol': 'NEWCO-EQ',
      });
      final result = await repo.technicals('NEWCO-EQ');
      expect(
        result.failureOrNull,
        isA<UnavailableFailure>().having((f) => f.message, 'message', contains('20 days')),
      );
    });

    test('a 404 (instrument not found) is Unavailable too', () async {
      adapter.handler = (o) async =>
          jsonBody({'error': 'Could not find token for XYZ-EQ'}, status: 404);
      expect((await repo.prediction('XYZ-EQ')).failureOrNull, isA<UnavailableFailure>());
    });

    test('sends the full trading symbol and caches per symbol', () async {
      adapter.handler = (o) async =>
          jsonBody(technicalJson(symbol: '${o.queryParameters['symbol']}'));
      await repo.technicals('BAJAJ-AUTO-EQ');
      await repo.technicals('BAJAJ-AUTO-EQ');
      await repo.technicals('M&M-EQ');
      expect(adapter.requests.map((r) => r.queryParameters['symbol']), ['BAJAJ-AUTO-EQ', 'M&M-EQ']);
    });

    test('the summary is cached; regenerate asks the server to skip its own cache', () async {
      adapter.handler = (o) async => jsonBody({'summary': ' **Solid** company. ', 'cached': false});
      final first = await repo.summary('TCS-EQ');
      await repo.summary('TCS-EQ');
      expect(adapter.requests, hasLength(1));
      expect((first as Success<AiSummary>).value.markdown, '**Solid** company.');
      expect(adapter.requests.single.data, {'symbol': 'TCS-EQ', 'refresh': false});

      await repo.summary('TCS-EQ', regenerate: true);
      expect(adapter.requests, hasLength(2));
      expect(adapter.requests.last.data, {'symbol': 'TCS-EQ', 'refresh': true});
    });

    test('a dropped summary request is a plain timeout to retry, not an unknown outcome', () async {
      adapter.handler = (o) async =>
          throw DioException(requestOptions: o, type: DioExceptionType.receiveTimeout);
      expect((await repo.summary('TCS-EQ')).failureOrNull, isA<TimeoutFailure>());
    });

    test('the glossary is fetched once and then peekable', () async {
      adapter.handler = (o) async => jsonBody(glossaryJson());
      expect(repo.cachedGlossary(), isNull);
      await repo.glossary();
      await repo.glossary();
      expect(adapter.requests, hasLength(1));
      expect(repo.cachedGlossary()!.metrics, hasLength(3));
    });
  });
}
