import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'technicals.freezed.dart';

/// One day's prices.
@immutable
class Ohlc {
  const Ohlc({required this.open, required this.high, required this.low, required this.close});

  final double open;
  final double high;
  final double low;
  final double close;

  bool get isUp => close >= open;
}

/// A year of daily bars with the indicators computed over them, oldest first.
///
/// Every list has one entry per date. An indicator with too little history
/// for its window (SMA 200 on a recent listing) is null at those dates.
///
/// A plain class, not a freezed one: deep equality over hundreds of bars
/// would cost on every comparison and buy nothing.
@immutable
class PriceHistory {
  const PriceHistory({
    required this.dates,
    required this.bars,
    required this.volumes,
    required this.sma50,
    required this.sma200,
    required this.rsi,
    required this.macd,
    required this.macdSignal,
    required this.macdHistogram,
  });

  static const empty = PriceHistory(
    dates: [],
    bars: [],
    volumes: [],
    sma50: [],
    sma200: [],
    rsi: [],
    macd: [],
    macdSignal: [],
    macdHistogram: [],
  );

  final List<DateTime> dates;
  final List<Ohlc> bars;
  final List<double> volumes;
  final List<double?> sma50;
  final List<double?> sma200;
  final List<double?> rsi;
  final List<double?> macd;
  final List<double?> macdSignal;
  final List<double?> macdHistogram;

  int get length => dates.length;
  bool get isEmpty => dates.isEmpty;

  List<double> get closes => [for (final b in bars) b.close];
}

@freezed
abstract class TechnicalIndicators with _$TechnicalIndicators {
  const factory TechnicalIndicators({
    double? sma20,
    double? sma50,
    double? sma200,
    double? rsi,
    double? macd,
    double? macdSignal,
    double? macdHistogram,
    double? week52High,
    double? week52Low,

    /// Percent of the way from the 52-week low to the high.
    double? week52Position,

    /// Today's volume over the 20-day average.
    double? volumeRatio,
  }) = _TechnicalIndicators;
}

enum SignalStatus { bullish, bearish, neutral }

/// One reading the server drew from the indicators, e.g. "Above 200 DMA".
@freezed
abstract class TechnicalSignal with _$TechnicalSignal {
  const factory TechnicalSignal({
    required String name,
    required SignalStatus status,

    /// Already formatted by the server: `₹2,410.50`, `1.4x avg`.
    required String value,
    required String label,
  }) = _TechnicalSignal;
}

/// Classic pivot points from the last session's high, low and close.
@freezed
abstract class PivotLevels with _$PivotLevels {
  const factory PivotLevels({double? pivot, double? r1, double? r2, double? s1, double? s2}) =
      _PivotLevels;

  const PivotLevels._();

  bool get isAvailable => pivot != null;
}

/// `GET /api/research/technical`.
@freezed
abstract class Technicals with _$Technicals {
  const factory Technicals({
    required String symbol,

    /// The last close, which during market hours is today's live bar.
    required double currentPrice,
    required TechnicalIndicators indicators,
    required List<TechnicalSignal> signals,
    required PivotLevels levels,
    required PriceHistory history,
  }) = _Technicals;
}
