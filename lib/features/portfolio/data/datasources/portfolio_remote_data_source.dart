import 'package:agentfolio/core/network/api_client.dart';
import 'package:agentfolio/core/network/json.dart';
import 'package:agentfolio/features/portfolio/data/models/portfolio_dtos.dart';

/// `/api/portfolio/*` and the static sector map. One method per endpoint,
/// mirroring `AgentfolioUI/src/api/portfolio.ts`.
class PortfolioRemoteDataSource {
  PortfolioRemoteDataSource(this._api);

  final ApiClient _api;

  Future<PortfolioDto> analytics() => _api.get(
    '/api/portfolio/analytics',
    decode: (json) => PortfolioDto.fromJson(asJsonMap(json)),
    // Holdings, positions and funds are three broker calls on the server.
    timeout: ApiTimeouts.slow,
  );

  Future<PositionsDto> positions() => _api.get(
    '/api/portfolio/positions',
    decode: (json) => PositionsDto.fromJson(asJsonMap(json)),
  );

  Future<List<OrderDto>> orders() => _api.get(
    '/api/portfolio/orders',
    decode: (json) => asJsonList(asJsonMap(json)['orders'], OrderDto.fromJson),
  );

  Future<List<TradeDto>> trades() => _api.get(
    '/api/portfolio/trades',
    decode: (json) => asJsonList(asJsonMap(json)['trades'], TradeDto.fromJson),
  );

  /// Slow: history for each of the top holdings plus NIFTY 50.
  Future<BenchmarkDto> beta(int days) => _api.get(
    '/api/portfolio/beta',
    query: {'days': days},
    decode: (json) => BenchmarkDto.fromJson(asJsonMap(json)),
    timeout: ApiTimeouts.slow,
  );

  /// `data/sector_map.json`, the same file the server classifies holdings with.
  Future<Map<String, String>> sectorMap() => _api.get(
    '/static/data/sector_map.json',
    decode: (json) => asJsonMap(json).map((k, v) => MapEntry(k, v.toString())),
  );
}
