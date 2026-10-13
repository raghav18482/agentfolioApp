import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

/// Home: the portfolio snapshot everything derives from, the sector map for
/// allocation, and the benchmark, which is slow and loads only once its card
/// scrolls into view.
class HomeViewModel extends BaseViewModel {
  HomeViewModel({required this._repository, required super.telemetry});

  final PortfolioRepository _repository;

  late final snapshot = Loadable<PortfolioSnapshot>(
    fetch: _repository.snapshot,
    peek: _repository.cachedSnapshot,
    onChanged: notifyListeners,
  );

  late final sectorMap = Loadable<SectorMap>(
    fetch: ({required force}) => _repository.sectorMap(),
    onChanged: notifyListeners,
  );

  late final benchmark = Loadable<BenchmarkComparison>(
    fetch: _repository.benchmark,
    onChanged: notifyListeners,
  );

  Future<void> load() => Future.wait([snapshot.load(), sectorMap.load()]);

  /// Pull-to-refresh: everything visible, fresh from the broker. The
  /// benchmark refreshes only if it was already loaded.
  Future<void> refresh() => Future.wait([
    snapshot.load(force: true),
    if (benchmark.data != null) benchmark.load(force: true),
  ]);

  /// The benchmark card became visible.
  Future<void> revealBenchmark() => benchmark.ensureLoaded();
}
