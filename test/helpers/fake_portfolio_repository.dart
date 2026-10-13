import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

/// A portfolio of the given holdings, for screens that only read the snapshot.
class FakePortfolioRepository implements PortfolioRepository {
  FakePortfolioRepository(List<Holding> holdings)
    : snapshotResult = Success(
        PortfolioSnapshot(
          holdings: holdings,
          summary: PortfolioSummary(
            currentValue: holdings.fold<double>(0, (s, h) => s + h.currentValue),
          ),
          funds: const Funds(),
          fetchedAt: DateTime(2026),
        ),
      );

  Result<PortfolioSnapshot> snapshotResult;

  @override
  Future<Result<PortfolioSnapshot>> snapshot({bool force = false}) async => snapshotResult;
  @override
  PortfolioSnapshot? cachedSnapshot() => snapshotResult.valueOrNull;
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
      const Err(ServerFailure('unused'));
  @override
  Future<Result<SectorMap>> sectorMap() async => const Success({});
}
