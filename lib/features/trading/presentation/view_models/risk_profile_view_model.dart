import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/domain/repositories/trading_repository.dart';
import 'package:agentfolio/features/trading/domain/trading_logic.dart';

/// Editing the risk profile. Numbers are kept as typed text, so clearing a
/// field to retype it does not snap it to zero.
class RiskProfileViewModel extends BaseViewModel {
  RiskProfileViewModel({required this._trading, required super.telemetry, RiskProfile? initial})
    : _initial = initial ?? RiskProfile.starter,
      isNew = initial == null {
    _reset(_initial);
  }

  final TradingRepository _trading;
  final RiskProfile _initial;

  /// No profile was saved before: the form starts from suggested values.
  final bool isNew;

  late String age;
  late String horizon;
  late String maxOrderValue;
  late String maxPosition;
  late String maxDailyTrades;
  late InvestmentGoal goal;
  late RiskTolerance tolerance;
  late String taxBracket;
  late Set<ProductType> products;

  Set<ProfileField> _problems = {};
  bool _showProblems = false;
  bool _saving = false;
  Failure? _saveFailure;

  /// Shown only after a save was tried, so the form does not open in red.
  Set<ProfileField> get problems => _showProblems ? _problems : const {};
  bool get saving => _saving;
  Failure? get saveFailure => _saveFailure;

  void _reset(RiskProfile p) {
    age = '${p.age}';
    horizon = '${p.horizonYears}';
    maxOrderValue = Fmt.number(p.maxOrderValue).replaceAll(',', '');
    maxPosition = Fmt.number(p.maxPositionPercent).replaceAll(',', '');
    maxDailyTrades = '${p.maxDailyTrades}';
    goal = p.goal;
    tolerance = p.tolerance;
    taxBracket = p.taxBracket;
    products = {...p.products};
    _validate();
  }

  void update(void Function(RiskProfileViewModel form) change) {
    change(this);
    _saveFailure = null;
    _validate();
    notifyListeners();
  }

  void toggleProduct(ProductType product) => update((f) {
    f.products = f.products.contains(product)
        ? ({...f.products}..remove(product))
        : {...f.products, product};
  });

  static int? _int(String s) => int.tryParse(s.trim());
  static double? _num(String s) => double.tryParse(s.trim().replaceAll(',', ''));

  void _validate() => _problems = profileProblems(
    age: _int(age),
    horizonYears: _int(horizon),
    maxOrderValue: _num(maxOrderValue),
    maxPositionPercent: _num(maxPosition),
    maxDailyTrades: _int(maxDailyTrades),
    products: products,
  );

  RiskProfile? get _draft => _problems.isNotEmpty
      ? null
      : RiskProfile(
          age: _int(age)!,
          goal: goal,
          horizonYears: _int(horizon)!,
          tolerance: tolerance,
          taxBracket: taxBracket.trim(),
          maxOrderValue: _num(maxOrderValue)!,
          maxPositionPercent: _num(maxPosition)!,
          maxDailyTrades: _int(maxDailyTrades)!,
          products: products,
        );

  /// Changed from what was saved (or from the suggestions, for a new one).
  bool get dirty => isNew || _draft != _initial;

  Future<RiskProfile?> save() async {
    _showProblems = true;
    final draft = _draft;
    if (draft == null || _saving) {
      notifyListeners();
      return null;
    }
    _saving = true;
    _saveFailure = null;
    notifyListeners();
    final result = await runAction('risk_profile_save', () => _trading.saveRiskProfile(draft));
    _saving = false;
    if (result case Err(:final failure)) _saveFailure = failure;
    notifyListeners();
    return result.valueOrNull;
  }
}
