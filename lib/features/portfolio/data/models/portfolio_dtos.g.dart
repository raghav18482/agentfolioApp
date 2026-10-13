// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioDto _$PortfolioDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PortfolioDto', json, ($checkedConvert) {
      final val = PortfolioDto(
        holdings: $checkedConvert(
          'holdings',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => HoldingDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ),
        summary: $checkedConvert(
          'summary',
          (v) => v == null ? null : SummaryDto.fromJson(v as Map<String, dynamic>),
        ),
        funds: $checkedConvert(
          'funds',
          (v) => v == null ? null : FundsDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

HoldingDto _$HoldingDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HoldingDto', json, ($checkedConvert) {
      final val = HoldingDto(
        symbol: $checkedConvert('symbol', (v) => jsonString(v)),
        symboltoken: $checkedConvert('symboltoken', (v) => jsonString(v)),
        qty: $checkedConvert('qty', (v) => jsonInt(v)),
        avgPrice: $checkedConvert('avg_price', (v) => jsonNum(v)),
        ltp: $checkedConvert('ltp', (v) => jsonNum(v)),
        invested: $checkedConvert('invested', (v) => jsonNum(v)),
        current: $checkedConvert('current', (v) => jsonNum(v)),
        pnl: $checkedConvert('pnl', (v) => jsonNum(v)),
        pnlPct: $checkedConvert('pnl_pct', (v) => jsonNum(v)),
      );
      return val;
    }, fieldKeyMap: const {'avgPrice': 'avg_price', 'pnlPct': 'pnl_pct'});

SummaryDto _$SummaryDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'SummaryDto',
  json,
  ($checkedConvert) {
    final val = SummaryDto(
      totalInvested: $checkedConvert('total_invested', (v) => jsonNumOrNull(v)),
      currentValue: $checkedConvert('current_value', (v) => jsonNumOrNull(v)),
      overallPnl: $checkedConvert('overall_pnl', (v) => jsonNumOrNull(v)),
      overallPnlPct: $checkedConvert('overall_pnl_pct', (v) => jsonNumOrNull(v)),
      dayPnl: $checkedConvert('day_pnl', (v) => jsonNumOrNull(v)),
    );
    return val;
  },
  fieldKeyMap: const {
    'totalInvested': 'total_invested',
    'currentValue': 'current_value',
    'overallPnl': 'overall_pnl',
    'overallPnlPct': 'overall_pnl_pct',
    'dayPnl': 'day_pnl',
  },
);

FundsDto _$FundsDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FundsDto', json, ($checkedConvert) {
      final val = FundsDto(
        availableCash: $checkedConvert('available_cash', (v) => jsonNumOrNull(v)),
        net: $checkedConvert('net', (v) => jsonNumOrNull(v)),
      );
      return val;
    }, fieldKeyMap: const {'availableCash': 'available_cash'});

PositionsDto _$PositionsDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PositionsDto', json, ($checkedConvert) {
      final val = PositionsDto(
        positions: $checkedConvert(
          'positions',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => PositionDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ),
        totalPnl: $checkedConvert('total_pnl', (v) => jsonNum(v)),
      );
      return val;
    }, fieldKeyMap: const {'totalPnl': 'total_pnl'});

PositionDto _$PositionDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PositionDto', json, ($checkedConvert) {
      final val = PositionDto(
        symbol: $checkedConvert('symbol', (v) => jsonString(v)),
        product: $checkedConvert('product', (v) => jsonString(v)),
        netQty: $checkedConvert('net_qty', (v) => jsonInt(v)),
        buyAvg: $checkedConvert('buy_avg', (v) => jsonNum(v)),
        sellAvg: $checkedConvert('sell_avg', (v) => jsonNum(v)),
        ltp: $checkedConvert('ltp', (v) => jsonNum(v)),
        pnl: $checkedConvert('pnl', (v) => jsonNum(v)),
      );
      return val;
    }, fieldKeyMap: const {'netQty': 'net_qty', 'buyAvg': 'buy_avg', 'sellAvg': 'sell_avg'});

OrderDto _$OrderDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('OrderDto', json, ($checkedConvert) {
      final val = OrderDto(
        orderid: $checkedConvert('orderid', (v) => jsonString(v)),
        symbol: $checkedConvert('symbol', (v) => jsonString(v)),
        txnType: $checkedConvert('txn_type', (v) => jsonString(v)),
        qty: $checkedConvert('qty', (v) => jsonInt(v)),
        price: $checkedConvert('price', (v) => jsonNum(v)),
        status: $checkedConvert('status', (v) => jsonString(v)),
        time: $checkedConvert('time', (v) => jsonString(v)),
      );
      return val;
    }, fieldKeyMap: const {'txnType': 'txn_type'});

TradeDto _$TradeDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TradeDto', json, ($checkedConvert) {
      final val = TradeDto(
        tradeid: $checkedConvert('tradeid', (v) => jsonString(v)),
        orderid: $checkedConvert('orderid', (v) => jsonString(v)),
        symbol: $checkedConvert('symbol', (v) => jsonString(v)),
        txnType: $checkedConvert('txn_type', (v) => jsonString(v)),
        qty: $checkedConvert('qty', (v) => jsonInt(v)),
        price: $checkedConvert('price', (v) => jsonNum(v)),
        time: $checkedConvert('time', (v) => jsonString(v)),
        exchange: $checkedConvert('exchange', (v) => jsonString(v)),
        product: $checkedConvert('product', (v) => jsonString(v)),
      );
      return val;
    }, fieldKeyMap: const {'txnType': 'txn_type'});

BenchmarkDto _$BenchmarkDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'BenchmarkDto',
  json,
  ($checkedConvert) {
    final val = BenchmarkDto(
      beta: $checkedConvert('beta', (v) => jsonNum(v)),
      alpha: $checkedConvert('alpha', (v) => jsonNum(v)),
      rSquared: $checkedConvert('r_squared', (v) => jsonNum(v)),
      dates: $checkedConvert(
        'dates',
        (v) => (v as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      ),
      niftyCumulative: $checkedConvert(
        'nifty_cumulative',
        (v) => (v as List<dynamic>?)?.map((e) => (e as num).toDouble()).toList() ?? [],
      ),
      portfolioCumulative: $checkedConvert(
        'portfolio_cumulative',
        (v) => (v as List<dynamic>?)?.map((e) => (e as num).toDouble()).toList() ?? [],
      ),
      stockBetas: $checkedConvert(
        'stock_betas',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => StockBetaDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      ),
      daysUsed: $checkedConvert('days_used', (v) => jsonInt(v)),
    );
    return val;
  },
  fieldKeyMap: const {
    'rSquared': 'r_squared',
    'niftyCumulative': 'nifty_cumulative',
    'portfolioCumulative': 'portfolio_cumulative',
    'stockBetas': 'stock_betas',
    'daysUsed': 'days_used',
  },
);

StockBetaDto _$StockBetaDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('StockBetaDto', json, ($checkedConvert) {
      final val = StockBetaDto(
        symbol: $checkedConvert('symbol', (v) => jsonString(v)),
        beta: $checkedConvert('beta', (v) => jsonNum(v)),
      );
      return val;
    });
