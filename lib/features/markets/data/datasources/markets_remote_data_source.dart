import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/network/json.dart';
import 'package:agentfolio/features/markets/data/models/markets_dtos.dart';
import 'package:agentfolio/features/markets/domain/entities/markets.dart';

/// `/api/news/*` and `/api/sectors/*`, mirroring `AgentfolioUI/src/api/news.ts`
/// and `sectors.ts`.
class MarketsRemoteDataSource {
  MarketsRemoteDataSource(this._api);

  final ApiClient _api;

  /// One Google News search per sector, run one after another on the
  /// server: about five seconds each, so up to a minute for eight sectors.
  /// Given the AI timeout until the server fetches them in parallel.
  Future<List<SectorNewsDto>> portfolioNews(NewsPeriod period) => _api.get(
    '/api/news/portfolio',
    query: {'period': period.wire},
    decode: (json) => asJsonList(asJsonMap(json)['sectors'], SectorNewsDto.fromJson),
    timeout: ApiTimeouts.ai,
  );

  Future<List<ArticleDto>> search(String query, NewsPeriod period) => _api.get(
    '/api/news/search',
    query: {'q': query, 'period': period.wire},
    decode: (json) => asJsonList(asJsonMap(json)['articles'], ArticleDto.fromJson),
    timeout: ApiTimeouts.slow,
  );

  /// FinBERT over every article. A POST that only reads, so safe to repeat.
  Future<SentimentDto> sentiment(PortfolioNews news) => _api.post(
    '/api/news/sentiment',
    body: sentimentRequest(news),
    decode: (json) => SentimentDto.fromJson(asJsonMap(json)),
    timeout: ApiTimeouts.ai,
  );

  Future<BreadthDto> breadth() => _api.get(
    '/api/sectors/breadth',
    decode: (json) => BreadthDto.fromJson(asJsonMap(json)),
    timeout: ApiTimeouts.slow,
  );

  Future<List<SectorExposureDto>> sectors() => _api.get(
    '/api/sectors/overview',
    decode: (json) => asJsonList(asJsonMap(json)['sectors'], SectorExposureDto.fromJson),
    timeout: ApiTimeouts.slow,
  );
}
