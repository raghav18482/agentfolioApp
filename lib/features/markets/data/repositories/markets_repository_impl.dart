import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/network/guard_api.dart';
import 'package:agentfolio/features/markets/data/datasources/markets_remote_data_source.dart';
import 'package:agentfolio/features/markets/domain/entities/markets.dart';
import 'package:agentfolio/features/markets/domain/repositories/markets_repository.dart';

/// Lifetimes follow how fast each source changes and what it costs the
/// server: news searches are slow, FinBERT is heavy, NSE breadth moves
/// through the day.
abstract final class _Ttl {
  static const news = Duration(minutes: 15);
  static const search = Duration(minutes: 10);
  static const sentiment = Duration(minutes: 30);
  static const breadth = Duration(minutes: 5);
  static const sectors = Duration(minutes: 30);
}

abstract final class _Key {
  static String news(NewsPeriod p) => 'markets/news/${p.wire}';
  static String sentiment(NewsPeriod p) => 'markets/sentiment/${p.wire}';
  static String search(String q, NewsPeriod p) => 'markets/search/${p.wire}/${q.toLowerCase()}';
  static const breadth = 'markets/breadth';
  static const sectors = 'markets/sectors';
}

class MarketsRepositoryImpl implements MarketsRepository {
  MarketsRepositoryImpl(this._remote, this._cache);

  final MarketsRemoteDataSource _remote;
  final RequestCache _cache;

  @override
  Future<Result<PortfolioNews>> portfolioNews(NewsPeriod period, {bool force = false}) => guardApi(
    () => _cache.fetch(
      _Key.news(period),
      ttl: _Ttl.news,
      force: force,
      load: () async => PortfolioNews(
        period: period,
        sectors: [for (final s in await _remote.portfolioNews(period)) s.toEntity()],
      ),
    ),
  );

  @override
  Future<Result<NewsSentiment>> sentiment(PortfolioNews news) async {
    final result = await guardApi(
      () => _cache.fetch(
        _Key.sentiment(news.period),
        ttl: _Ttl.sentiment,
        // Re-run when the news it described has been refreshed since.
        force:
            _cache
                .storedAt(_Key.news(news.period))
                ?.isAfter(_cache.storedAt(_Key.sentiment(news.period)) ?? DateTime(0)) ??
            false,
        load: () async => (await _remote.sentiment(news)).toEntity(),
      ),
    );
    // A dropped connection on this read-only POST is just a failed read.
    return switch (result) {
      Err(failure: UnknownOutcomeFailure()) => const Err(TimeoutFailure()),
      _ => result,
    };
  }

  @override
  NewsSentiment? cachedSentiment(NewsPeriod period) => _cache.peek(_Key.sentiment(period));

  @override
  Future<Result<List<NewsArticle>>> search(String query, NewsPeriod period) => guardApi(
    () => _cache.fetch(
      _Key.search(query, period),
      ttl: _Ttl.search,
      load: () async => [
        for (final a in await _remote.search(query, period))
          if (a.title.trim().isNotEmpty) a.toEntity(),
      ],
    ),
  );

  @override
  Future<Result<MarketBreadth>> breadth({bool force = false}) => guardApi(
    () => _cache.fetch(
      _Key.breadth,
      ttl: _Ttl.breadth,
      force: force,
      load: () async => (await _remote.breadth()).toEntity(),
    ),
  );

  @override
  Future<Result<List<SectorExposure>>> sectors({bool force = false}) async {
    final result = await guardApi(
      () => _cache.fetch(
        _Key.sectors,
        ttl: _Ttl.sectors,
        force: force,
        load: () async => [for (final s in await _remote.sectors()) s.toEntity()],
      ),
    );
    // The server answers 400 "No holdings found" for an empty portfolio:
    // that is an empty list, not an error.
    return switch (result) {
      Err(failure: ValidationFailure(:final message)) when message.contains('No holdings') =>
        const Success(<SectorExposure>[]),
      _ => result,
    };
  }
}
