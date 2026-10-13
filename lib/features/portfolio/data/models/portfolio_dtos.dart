import 'package:agentfolio/core/network/json_fields.dart';
import 'package:agentfolio/features/portfolio/domain/entities/portfolio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'portfolio_dtos.g.dart';

/// `GET /api/portfolio/analytics`.
@JsonSerializable()
class PortfolioDto {
  const PortfolioDto({required this.holdings, this.summary, this.funds});

  factory PortfolioDto.fromJson(Map<String, dynamic> json) => _$PortfolioDtoFromJson(json);

  @JsonKey(defaultValue: <HoldingDto>[])
  final List<HoldingDto> holdings;
  // Either is absent when the broker call behind it failed.
  final SummaryDto? summary;
  final FundsDto? funds;

  PortfolioSnapshot toEntity(DateTime fetchedAt) => PortfolioSnapshot(
    holdings: [for (final h in holdings) h.toEntity()],
    summary: PortfolioSummary(
      totalInvested: summary?.totalInvested,
      currentValue: summary?.currentValue,
      overallPnl: summary?.overallPnl,
      overallPnlPercent: summary?.overallPnlPct,
      dayPnl: summary?.dayPnl,
    ),
    funds: Funds(availableCash: funds?.availableCash, net: funds?.net),
    fetchedAt: fetchedAt,
  );
}

@JsonSerializable()
class HoldingDto {
  const HoldingDto({
    required this.symbol,
    required this.symboltoken,
    required this.qty,
    required this.avgPrice,
    required this.ltp,
    required this.invested,
    required this.current,
    required this.pnl,
    required this.pnlPct,
  });

  factory HoldingDto.fromJson(Map<String, dynamic> json) => _$HoldingDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String symbol;
  @JsonKey(fromJson: jsonString)
  final String symboltoken;
  @JsonKey(fromJson: jsonInt)
  final int qty;
  @JsonKey(fromJson: jsonNum)
  final double avgPrice;
  @JsonKey(fromJson: jsonNum)
  final double ltp;
  @JsonKey(fromJson: jsonNum)
  final double invested;
  @JsonKey(fromJson: jsonNum)
  final double current;
  @JsonKey(fromJson: jsonNum)
  final double pnl;
  @JsonKey(fromJson: jsonNum)
  final double pnlPct;

  Holding toEntity() => Holding(
    symbol: symbol,
    brokerToken: symboltoken,
    quantity: qty,
    averagePrice: avgPrice,
    lastPrice: ltp,
    invested: invested,
    currentValue: current,
    pnl: pnl,
    pnlPercent: pnlPct,
  );
}

@JsonSerializable()
class SummaryDto {
  const SummaryDto({
    this.totalInvested,
    this.currentValue,
    this.overallPnl,
    this.overallPnlPct,
    this.dayPnl,
  });

  factory SummaryDto.fromJson(Map<String, dynamic> json) => _$SummaryDtoFromJson(json);

  @JsonKey(fromJson: jsonNumOrNull)
  final double? totalInvested;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? currentValue;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? overallPnl;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? overallPnlPct;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? dayPnl;
}

/// Angel One reports funds as strings, or `"N/A"` when unavailable.
@JsonSerializable()
class FundsDto {
  const FundsDto({this.availableCash, this.net});

  factory FundsDto.fromJson(Map<String, dynamic> json) => _$FundsDtoFromJson(json);

  @JsonKey(fromJson: jsonNumOrNull)
  final double? availableCash;
  @JsonKey(fromJson: jsonNumOrNull)
  final double? net;
}

/// `GET /api/portfolio/positions`.
@JsonSerializable()
class PositionsDto {
  const PositionsDto({required this.positions, required this.totalPnl});

  factory PositionsDto.fromJson(Map<String, dynamic> json) => _$PositionsDtoFromJson(json);

  @JsonKey(defaultValue: <PositionDto>[])
  final List<PositionDto> positions;
  @JsonKey(fromJson: jsonNum)
  final double totalPnl;

  Positions toEntity() => Positions(
    positions: [
      for (final p in positions)
        Position(
          symbol: p.symbol,
          product: p.product,
          netQuantity: p.netQty,
          buyAverage: p.buyAvg,
          sellAverage: p.sellAvg,
          lastPrice: p.ltp,
          pnl: p.pnl,
        ),
    ],
    totalPnl: totalPnl,
  );
}

@JsonSerializable()
class PositionDto {
  const PositionDto({
    required this.symbol,
    required this.product,
    required this.netQty,
    required this.buyAvg,
    required this.sellAvg,
    required this.ltp,
    required this.pnl,
  });

  factory PositionDto.fromJson(Map<String, dynamic> json) => _$PositionDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String symbol;
  @JsonKey(fromJson: jsonString)
  final String product;
  @JsonKey(fromJson: jsonInt)
  final int netQty;
  @JsonKey(fromJson: jsonNum)
  final double buyAvg;
  @JsonKey(fromJson: jsonNum)
  final double sellAvg;
  @JsonKey(fromJson: jsonNum)
  final double ltp;
  @JsonKey(fromJson: jsonNum)
  final double pnl;
}

/// A row of `GET /api/portfolio/orders`.
@JsonSerializable()
class OrderDto {
  const OrderDto({
    required this.orderid,
    required this.symbol,
    required this.txnType,
    required this.qty,
    required this.price,
    required this.status,
    required this.time,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) => _$OrderDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String orderid;
  @JsonKey(fromJson: jsonString)
  final String symbol;
  @JsonKey(fromJson: jsonString)
  final String txnType;
  @JsonKey(fromJson: jsonInt)
  final int qty;
  @JsonKey(fromJson: jsonNum)
  final double price;
  @JsonKey(fromJson: jsonString)
  final String status;
  @JsonKey(fromJson: jsonString)
  final String time;

  Order toEntity() => Order(
    orderId: orderid,
    symbol: symbol,
    side: orderSideOf(txnType),
    quantity: qty,
    price: price,
    status: status,
    time: time,
  );
}

/// A row of `GET /api/portfolio/trades`.
@JsonSerializable()
class TradeDto {
  const TradeDto({
    required this.tradeid,
    required this.orderid,
    required this.symbol,
    required this.txnType,
    required this.qty,
    required this.price,
    required this.time,
    required this.exchange,
    required this.product,
  });

  factory TradeDto.fromJson(Map<String, dynamic> json) => _$TradeDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String tradeid;
  @JsonKey(fromJson: jsonString)
  final String orderid;
  @JsonKey(fromJson: jsonString)
  final String symbol;
  @JsonKey(fromJson: jsonString)
  final String txnType;
  @JsonKey(fromJson: jsonInt)
  final int qty;
  @JsonKey(fromJson: jsonNum)
  final double price;
  @JsonKey(fromJson: jsonString)
  final String time;
  @JsonKey(fromJson: jsonString)
  final String exchange;
  @JsonKey(fromJson: jsonString)
  final String product;

  Trade toEntity() => Trade(
    tradeId: tradeid,
    orderId: orderid,
    symbol: symbol,
    side: orderSideOf(txnType),
    quantity: qty,
    price: price,
    time: time,
    exchange: exchange,
    product: product,
  );
}

/// `GET /api/portfolio/beta`.
@JsonSerializable()
class BenchmarkDto {
  const BenchmarkDto({
    required this.beta,
    required this.alpha,
    required this.rSquared,
    required this.dates,
    required this.niftyCumulative,
    required this.portfolioCumulative,
    required this.stockBetas,
    required this.daysUsed,
  });

  factory BenchmarkDto.fromJson(Map<String, dynamic> json) => _$BenchmarkDtoFromJson(json);

  @JsonKey(fromJson: jsonNum)
  final double beta;
  @JsonKey(fromJson: jsonNum)
  final double alpha;
  @JsonKey(fromJson: jsonNum)
  final double rSquared;
  @JsonKey(defaultValue: <String>[])
  final List<String> dates;
  @JsonKey(defaultValue: <double>[])
  final List<double> niftyCumulative;
  @JsonKey(defaultValue: <double>[])
  final List<double> portfolioCumulative;
  @JsonKey(defaultValue: <StockBetaDto>[])
  final List<StockBetaDto> stockBetas;
  @JsonKey(fromJson: jsonInt)
  final int daysUsed;

  BenchmarkComparison toEntity() {
    // The three series must line up; trust only their common length.
    final n = [
      dates.length,
      niftyCumulative.length,
      portfolioCumulative.length,
    ].reduce((a, b) => a < b ? a : b);
    return BenchmarkComparison(
      beta: beta,
      alpha: alpha,
      rSquared: rSquared,
      dates: [for (final d in dates.take(n)) DateTime.tryParse(d) ?? DateTime(1970)],
      niftyCumulative: niftyCumulative.take(n).toList(),
      portfolioCumulative: portfolioCumulative.take(n).toList(),
      stockBetas: [for (final s in stockBetas) (symbol: s.symbol, beta: s.beta)],
      daysUsed: daysUsed,
    );
  }
}

@JsonSerializable()
class StockBetaDto {
  const StockBetaDto({required this.symbol, required this.beta});

  factory StockBetaDto.fromJson(Map<String, dynamic> json) => _$StockBetaDtoFromJson(json);

  @JsonKey(fromJson: jsonString)
  final String symbol;
  @JsonKey(fromJson: jsonNum)
  final double beta;
}
