import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';

/// The user's portfolio as the broker reports it. Every read is cached
/// briefly and shared: several screens asking at once make one request.
abstract interface class PortfolioRepository {
  Future<Result<PortfolioSnapshot>> snapshot({bool force = false});

  /// The last snapshot read, however old, for an instant first paint.
  PortfolioSnapshot? cachedSnapshot();

  Future<Result<Positions>> positions({bool force = false});
  Positions? cachedPositions();

  Future<Result<List<Order>>> orders({bool force = false});
  List<Order>? cachedOrders();

  Future<Result<List<Trade>>> trades({bool force = false});
  List<Trade>? cachedTrades();

  /// Slow: the server fetches history for each top holding.
  Future<Result<BenchmarkComparison>> benchmark({int days = 90, bool force = false});

  Future<Result<SectorMap>> sectorMap();
}
