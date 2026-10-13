import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/network/guard_api.dart';
import 'package:agentfolio/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

/// Cache lifetimes match the web app's react-query `staleTime`s, which were
/// tuned to Angel One's rate limits.
abstract final class _Ttl {
  static const broker = Duration(seconds: 60);
  static const benchmark = Duration(minutes: 5);
  static const sectorMap = Duration(hours: 12);
}

abstract final class _Key {
  static const snapshot = 'portfolio/analytics';
  static const positions = 'portfolio/positions';
  static const orders = 'portfolio/orders';
  static const trades = 'portfolio/trades';
  static String benchmark(int days) => 'portfolio/beta/$days';
  static const sectorMap = 'static/sector_map';
}

class PortfolioRepositoryImpl implements PortfolioRepository {
  PortfolioRepositoryImpl(this._remote, this._cache, {DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  final PortfolioRemoteDataSource _remote;
  final RequestCache _cache;
  final DateTime Function() _now;

  @override
  Future<Result<PortfolioSnapshot>> snapshot({bool force = false}) => guardApi(
    () => _cache.fetch(
      _Key.snapshot,
      ttl: _Ttl.broker,
      force: force,
      load: () async => (await _remote.analytics()).toEntity(_now()),
    ),
  );

  @override
  PortfolioSnapshot? cachedSnapshot() => _cache.peek(_Key.snapshot);

  @override
  Future<Result<Positions>> positions({bool force = false}) => guardApi(
    () => _cache.fetch(
      _Key.positions,
      ttl: _Ttl.broker,
      force: force,
      load: () async => (await _remote.positions()).toEntity(),
    ),
  );

  @override
  Positions? cachedPositions() => _cache.peek(_Key.positions);

  @override
  Future<Result<List<Order>>> orders({bool force = false}) => guardApi(
    () => _cache.fetch(
      _Key.orders,
      ttl: _Ttl.broker,
      force: force,
      load: () async => [for (final o in await _remote.orders()) o.toEntity()],
    ),
  );

  @override
  List<Order>? cachedOrders() => _cache.peek(_Key.orders);

  @override
  Future<Result<List<Trade>>> trades({bool force = false}) => guardApi(
    () => _cache.fetch(
      _Key.trades,
      ttl: _Ttl.broker,
      force: force,
      load: () async => [for (final t in await _remote.trades()) t.toEntity()],
    ),
  );

  @override
  List<Trade>? cachedTrades() => _cache.peek(_Key.trades);

  @override
  Future<Result<BenchmarkComparison>> benchmark({int days = 90, bool force = false}) => guardApi(
    () => _cache.fetch(
      _Key.benchmark(days),
      ttl: _Ttl.benchmark,
      force: force,
      load: () async => (await _remote.beta(days)).toEntity(),
    ),
  );

  @override
  Future<Result<SectorMap>> sectorMap() =>
      guardApi(() => _cache.fetch(_Key.sectorMap, ttl: _Ttl.sectorMap, load: _remote.sectorMap));
}
