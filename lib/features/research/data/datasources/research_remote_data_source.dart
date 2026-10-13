import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/network/json.dart';
import 'package:agentfolio/features/research/data/models/research_dtos.dart';

/// Per-stock research endpoints, mirroring `AgentfolioUI/src/api/research.ts`
/// and the prediction call in `api/portfolio.ts`.
///
/// The research endpoints answer "no data for this stock" as a 200 with an
/// `error` text (an ETF on Yahoo, a recent listing). [asDataMap] turns that
/// into an `UnavailableFailure` instead of a screen of dashes.
class ResearchRemoteDataSource {
  ResearchRemoteDataSource(this._api);

  final ApiClient _api;

  /// One broker history call on the server, plus a holdings call for the
  /// average price.
  Future<TechnicalsDto> technical(String symbol, {int days = 365}) => _api.get(
    '/api/research/technical',
    query: {'symbol': symbol, 'exchange': 'NSE', 'days': days},
    decode: (json) => TechnicalsDto.fromJson(asDataMap(json)),
    timeout: ApiTimeouts.slow,
  );

  /// Yahoo Finance behind the server: several seconds when not cached.
  Future<FundamentalsDto> fundamental(String symbol) => _api.get(
    '/api/research/fundamental',
    query: {'symbol': symbol},
    decode: (json) => FundamentalsDto.fromJson(asDataMap(json)),
    timeout: ApiTimeouts.slow,
  );

  Future<PredictionDto> predict(String symbol, {int days = 365}) => _api.get(
    '/api/portfolio/predict',
    query: {'symbol': symbol, 'exchange': 'NSE', 'days': days},
    decode: (json) => PredictionDto.fromJson(asDataMap(json)),
    timeout: ApiTimeouts.slow,
  );

  /// An LLM call on the server's key. A POST, but safe to repeat: it only
  /// reads, and the server caches per stock.
  Future<SummaryDto> summary(String symbol, {required bool refresh}) => _api.post(
    '/api/research/fundamental/summary',
    body: {'symbol': symbol, 'refresh': refresh},
    decode: (json) => SummaryDto.fromJson(asJsonMap(json)),
    timeout: ApiTimeouts.ai,
  );

  /// A static file, public and shared with the Learn screen.
  Future<GlossaryDto> glossary() => _api.get(
    '/static/data/metric_glossary.json',
    decode: (json) => GlossaryDto.fromJson(asJsonMap(json)),
  );
}
