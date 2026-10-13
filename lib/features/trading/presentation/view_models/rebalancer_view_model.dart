import 'dart:async';

import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:agentfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:agentfolio/features/trading/domain/trading_logic.dart';

enum ReinvestProblem { noTarget, notPositive, tooMuch }

/// A what-if: sell parts of holdings, put the cash elsewhere, see the
/// result. Nothing here is ever sent to the broker.
class RebalancerViewModel extends BaseViewModel {
  RebalancerViewModel({required this._portfolio, required super.telemetry});

  final PortfolioRepository _portfolio;

  late final snapshot = Loadable<PortfolioSnapshot>(
    fetch: _portfolio.snapshot,
    peek: _portfolio.cachedSnapshot,
    onChanged: notifyListeners,
  );

  final Map<String, double> _sells = {};
  final Map<String, double> _buys = {};

  Future<void> load() => snapshot.load();

  List<RebalanceRow> get rows => rebalanceRows([
    for (final h in snapshot.data?.holdings ?? const <Holding>[])
      (symbol: h.symbol, label: Fmt.symbol(h.symbol), value: h.currentValue),
  ]);

  double get cash => snapshot.data?.funds.availableCash ?? 0;

  Simulation get simulation => simulate(rows, _sells, _buys, cash);

  double soldPercent(String symbol) => _sells[symbol] ?? 0;
  double reinvested(String symbol) => _buys[symbol] ?? 0;
  bool get touched => _sells.values.any((v) => v > 0) || _buys.isNotEmpty;

  void setSold(String symbol, double percent) {
    _sells[symbol] = percent.clamp(0, 100).roundToDouble();
    notifyListeners();
  }

  /// Adds [amount] to [symbol], if there is that much left to deploy.
  ReinvestProblem? reinvest(String? symbol, double? amount) {
    if (symbol == null) return ReinvestProblem.noTarget;
    if (amount == null || amount <= 0) return ReinvestProblem.notPositive;
    if (!canReinvest(amount, simulation.remaining)) return ReinvestProblem.tooMuch;
    _buys[symbol] = (_buys[symbol] ?? 0) + amount;
    notifyListeners();
    return null;
  }

  void reset() {
    _sells.clear();
    _buys.clear();
    notifyListeners();
  }
}
