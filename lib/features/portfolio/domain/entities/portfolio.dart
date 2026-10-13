import 'package:agentfolio/core/utils/format.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio.freezed.dart';

/// A stock held in the demat account, with its derived values.
@freezed
abstract class Holding with _$Holding {
  const factory Holding({
    /// The broker's trading symbol, e.g. `RELIANCE-EQ`.
    required String symbol,

    /// The broker's own instrument id, for live prices. Broker-specific.
    required String brokerToken,
    required int quantity,
    required double averagePrice,
    required double lastPrice,
    required double invested,
    required double currentValue,
    required double pnl,
    required double pnlPercent,
  }) = _Holding;

  const Holding._();

  /// `RELIANCE`, for display.
  String get displaySymbol => Fmt.symbol(symbol);
}

/// Totals across holdings. Each is null when the broker call behind it
/// failed, so the screen can show "—" instead of a misleading ₹0.
@freezed
abstract class PortfolioSummary with _$PortfolioSummary {
  const factory PortfolioSummary({
    double? totalInvested,
    double? currentValue,
    double? overallPnl,
    double? overallPnlPercent,

    /// Today's P&L across open positions. Absent when there are none today,
    /// which is a real zero.
    double? dayPnl,
  }) = _PortfolioSummary;
}

@freezed
abstract class Funds with _$Funds {
  const factory Funds({double? availableCash, double? net}) = _Funds;
}

/// Everything `GET /api/portfolio/analytics` returns, read at [fetchedAt].
@freezed
abstract class PortfolioSnapshot with _$PortfolioSnapshot {
  const factory PortfolioSnapshot({
    required List<Holding> holdings,
    required PortfolioSummary summary,
    required Funds funds,
    required DateTime fetchedAt,
  }) = _PortfolioSnapshot;
}

/// An open intraday or delivery position.
@freezed
abstract class Position with _$Position {
  const factory Position({
    required String symbol,
    required String product,
    required int netQuantity,
    required double buyAverage,
    required double sellAverage,
    required double lastPrice,
    required double pnl,
  }) = _Position;

  const Position._();

  String get displaySymbol => Fmt.symbol(symbol);
}

@freezed
abstract class Positions with _$Positions {
  const factory Positions({required List<Position> positions, required double totalPnl}) =
      _Positions;
}

enum OrderSide { buy, sell, other }

/// Where an order stands, grouped the way a user thinks about it.
enum OrderState {
  /// Filled.
  complete,

  /// Rejected or cancelled: will not fill.
  closed,

  /// Open, pending, trigger pending, …
  pending,
}

@freezed
abstract class Order with _$Order {
  const factory Order({
    required String orderId,
    required String symbol,
    required OrderSide side,
    required int quantity,
    required double price,

    /// The broker's own wording, shown as-is.
    required String status,
    required String time,
  }) = _Order;

  const Order._();

  String get displaySymbol => Fmt.symbol(symbol);

  OrderState get state => switch (status.toLowerCase()) {
    'complete' || 'executed' => OrderState.complete,
    'rejected' || 'cancelled' || 'canceled' => OrderState.closed,
    _ => OrderState.pending,
  };
}

/// One fill.
@freezed
abstract class Trade with _$Trade {
  const factory Trade({
    required String tradeId,
    required String orderId,
    required String symbol,
    required OrderSide side,
    required int quantity,
    required double price,
    required String time,
    required String exchange,
    required String product,
  }) = _Trade;

  const Trade._();

  String get displaySymbol => Fmt.symbol(symbol);
}

OrderSide orderSideOf(String value) => switch (value.toUpperCase()) {
  'BUY' => OrderSide.buy,
  'SELL' => OrderSide.sell,
  _ => OrderSide.other,
};

/// `GET /api/portfolio/beta`: the top holdings against NIFTY 50.
@freezed
abstract class BenchmarkComparison with _$BenchmarkComparison {
  const factory BenchmarkComparison({
    required double beta,

    /// Mean daily excess return beyond what beta explains, as a fraction.
    required double alpha,
    required double rSquared,
    required List<DateTime> dates,

    /// Cumulative return to each date, in percent.
    required List<double> niftyCumulative,
    required List<double> portfolioCumulative,
    required List<({String symbol, double beta})> stockBetas,
    required int daysUsed,
  }) = _BenchmarkComparison;
}

/// How volatile something is relative to the market, from its beta.
enum BetaBand {
  defensive,
  market,
  aggressive;

  static BetaBand of(double beta) => beta > 1.2
      ? aggressive
      : beta > 0.8
      ? market
      : defensive;
}

/// Trading symbol → sector, from `data/sector_map.json`.
typedef SectorMap = Map<String, String>;
