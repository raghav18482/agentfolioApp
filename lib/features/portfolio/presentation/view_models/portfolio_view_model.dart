import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/logic/portfolio_insights.dart';
import 'package:agentfolio/features/portfolio/domain/repositories/portfolio_repository.dart';

enum PortfolioView { holdings, positions, orders }

enum OrdersView { orders, trades }

/// The Portfolio tab: holdings (sortable, searchable), positions, and the
/// order and trade books. Each segment loads the first time it is opened.
class PortfolioViewModel extends BaseViewModel {
  PortfolioViewModel({required this._repository, required super.telemetry});

  final PortfolioRepository _repository;

  PortfolioView view = PortfolioView.holdings;
  OrdersView ordersView = OrdersView.orders;
  HoldingSort sort = HoldingSort.currentValue;
  String query = '';

  late final snapshot = Loadable<PortfolioSnapshot>(
    fetch: _repository.snapshot,
    peek: _repository.cachedSnapshot,
    onChanged: notifyListeners,
  );

  late final positions = Loadable<Positions>(
    fetch: _repository.positions,
    peek: _repository.cachedPositions,
    onChanged: notifyListeners,
  );

  late final orders = Loadable<List<Order>>(
    fetch: _repository.orders,
    peek: _repository.cachedOrders,
    onChanged: notifyListeners,
  );

  late final trades = Loadable<List<Trade>>(
    fetch: _repository.trades,
    peek: _repository.cachedTrades,
    onChanged: notifyListeners,
  );

  /// Holdings after the search and sort the user picked.
  List<Holding> get visibleHoldings {
    final holdings = snapshot.data?.holdings;
    return holdings == null ? const [] : arrangeHoldings(holdings, sort: sort, query: query);
  }

  Future<void> load() => _ensureCurrent();

  void selectView(PortfolioView value) {
    if (view == value) return;
    view = value;
    notifyListeners();
    _ensureCurrent().ignore();
  }

  void selectOrdersView(OrdersView value) {
    if (ordersView == value) return;
    ordersView = value;
    notifyListeners();
    _ensureCurrent().ignore();
  }

  void setSort(HoldingSort value) {
    sort = value;
    notifyListeners();
  }

  void setQuery(String value) {
    query = value;
    notifyListeners();
  }

  /// Pull-to-refresh refreshes only what is on screen.
  Future<void> refresh() => switch (view) {
    PortfolioView.holdings => snapshot.load(force: true),
    PortfolioView.positions => positions.load(force: true),
    PortfolioView.orders => switch (ordersView) {
      OrdersView.orders => orders.load(force: true),
      OrdersView.trades => trades.load(force: true),
    },
  };

  Future<void> _ensureCurrent() => switch (view) {
    PortfolioView.holdings => snapshot.ensureLoaded(),
    PortfolioView.positions => positions.ensureLoaded(),
    // Both counts show on the Orders/Trades switch, so load both.
    PortfolioView.orders => Future.wait([orders.ensureLoaded(), trades.ensureLoaded()]),
  };
}
