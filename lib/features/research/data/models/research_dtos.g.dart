// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'research_dtos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FundamentalsDto _$FundamentalsDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('FundamentalsDto', json, ($checkedConvert) {
      final val = FundamentalsDto(
        symbol: $checkedConvert('symbol', (v) => jsonString(v)),
        revenueTrend: $checkedConvert(
          'revenue_trend',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => TrendPointDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ),
        profitTrend: $checkedConvert(
          'profit_trend',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => TrendPointDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ),
        valuation: $checkedConvert(
          'valuation',
          (v) => v == null ? null : ValuationDto.fromJson(v as Map<String, dynamic>),
        ),
        health: $checkedConvert(
          'health',
          (v) => v == null ? null : HealthDto.fromJson(v as Map<String, dynamic>),
        ),
        score: $checkedConvert(
          'score',
          (v) => v == null ? null : ScoreDto.fromJson(v as Map<String, dynamic>),
        ),
        sector: $checkedConvert('sector', (v) => jsonStringOrNull(v)),
        industry: $checkedConvert('industry', (v) => jsonStringOrNull(v)),
      );
      return val;
    }, fieldKeyMap: const {'revenueTrend': 'revenue_trend', 'profitTrend': 'profit_trend'});

ValuationDto _$ValuationDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ValuationDto',
  json,
  ($checkedConvert) {
    final val = ValuationDto(
      peRatio: $checkedConvert('pe_ratio', (v) => jsonNumOrNull(v)),
      forwardPe: $checkedConvert('forward_pe', (v) => jsonNumOrNull(v)),
      pbRatio: $checkedConvert('pb_ratio', (v) => jsonNumOrNull(v)),
      evEbitda: $checkedConvert('ev_ebitda', (v) => jsonNumOrNull(v)),
      pegRatio: $checkedConvert('peg_ratio', (v) => jsonNumOrNull(v)),
      dividendYield: $checkedConvert('dividend_yield', (v) => jsonNumOrNull(v)),
      trailingEps: $checkedConvert('trailing_eps', (v) => jsonNumOrNull(v)),
    );
    return val;
  },
  fieldKeyMap: const {
    'peRatio': 'pe_ratio',
    'forwardPe': 'forward_pe',
    'pbRatio': 'pb_ratio',
    'evEbitda': 'ev_ebitda',
    'pegRatio': 'peg_ratio',
    'dividendYield': 'dividend_yield',
    'trailingEps': 'trailing_eps',
  },
);

HealthDto _$HealthDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'HealthDto',
  json,
  ($checkedConvert) {
    final val = HealthDto(
      roe: $checkedConvert('roe', (v) => jsonNumOrNull(v)),
      roce: $checkedConvert('roce', (v) => jsonNumOrNull(v)),
      debtToEquity: $checkedConvert('debt_to_equity', (v) => jsonNumOrNull(v)),
      freeCashFlow: $checkedConvert('free_cash_flow', (v) => jsonNumOrNull(v)),
      profitMargin: $checkedConvert('profit_margin', (v) => jsonNumOrNull(v)),
      operatingMargin: $checkedConvert('operating_margin', (v) => jsonNumOrNull(v)),
      revenueGrowth: $checkedConvert('revenue_growth', (v) => jsonNumOrNull(v)),
      earningsGrowth: $checkedConvert('earnings_growth', (v) => jsonNumOrNull(v)),
      promoterHolding: $checkedConvert('promoter_holding', (v) => jsonNumOrNull(v)),
    );
    return val;
  },
  fieldKeyMap: const {
    'debtToEquity': 'debt_to_equity',
    'freeCashFlow': 'free_cash_flow',
    'profitMargin': 'profit_margin',
    'operatingMargin': 'operating_margin',
    'revenueGrowth': 'revenue_growth',
    'earningsGrowth': 'earnings_growth',
    'promoterHolding': 'promoter_holding',
  },
);

TrendPointDto _$TrendPointDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('TrendPointDto', json, ($checkedConvert) {
      final val = TrendPointDto(
        year: $checkedConvert('year', (v) => jsonString(v)),
        value: $checkedConvert('value', (v) => jsonNum(v)),
      );
      return val;
    });

ScoreDto _$ScoreDtoFromJson(Map<String, dynamic> json) => $checkedCreate('ScoreDto', json, (
  $checkedConvert,
) {
  final val = ScoreDto(
    label: $checkedConvert('label', (v) => jsonString(v)),
    confidence: $checkedConvert(
      'confidence',
      (v) =>
          $enumDecodeNullable(_$ScoreConfidenceEnumMap, v, unknownValue: ScoreConfidence.none) ??
          ScoreConfidence.none,
    ),
    metricsUsed: $checkedConvert('metrics_used', (v) => jsonInt(v)),
    metricsTotal: $checkedConvert('metrics_total', (v) => jsonInt(v)),
    pillars: $checkedConvert(
      'pillars',
      (v) =>
          (v as List<dynamic>?)
              ?.map((e) => PillarDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    ),
    strengths: $checkedConvert('strengths', (v) => jsonStringList(v)),
    concerns: $checkedConvert('concerns', (v) => jsonStringList(v)),
    excluded: $checkedConvert('excluded', (v) => jsonStringList(v)),
    total: $checkedConvert('total', (v) => jsonNumOrNull(v)),
    grade: $checkedConvert('grade', (v) => jsonStringOrNull(v)),
    note: $checkedConvert('note', (v) => jsonStringOrNull(v)),
  );
  return val;
}, fieldKeyMap: const {'metricsUsed': 'metrics_used', 'metricsTotal': 'metrics_total'});

const _$ScoreConfidenceEnumMap = {
  ScoreConfidence.high: 'high',
  ScoreConfidence.medium: 'medium',
  ScoreConfidence.low: 'low',
  ScoreConfidence.none: 'none',
};

PillarDto _$PillarDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PillarDto', json, ($checkedConvert) {
      final val = PillarDto(
        key: $checkedConvert('key', (v) => jsonString(v)),
        label: $checkedConvert('label', (v) => jsonString(v)),
        tagline: $checkedConvert('tagline', (v) => jsonString(v)),
        max: $checkedConvert('max', (v) => jsonNum(v)),
        metrics: $checkedConvert(
          'metrics',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => ScoreMetricDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ),
        score: $checkedConvert('score', (v) => jsonNumOrNull(v)),
      );
      return val;
    });

ScoreMetricDto _$ScoreMetricDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ScoreMetricDto', json, ($checkedConvert) {
      final val = ScoreMetricDto(
        key: $checkedConvert('key', (v) => jsonString(v)),
        label: $checkedConvert('label', (v) => jsonString(v)),
        display: $checkedConvert('display', (v) => jsonString(v)),
        verdict: $checkedConvert(
          'verdict',
          (v) =>
              $enumDecodeNullable(_$VerdictEnumMap, v, unknownValue: Verdict.unknown) ??
              Verdict.unknown,
        ),
        note: $checkedConvert('note', (v) => jsonString(v)),
        value: $checkedConvert('value', (v) => jsonNumOrNull(v)),
      );
      return val;
    });

const _$VerdictEnumMap = {
  Verdict.good: 'good',
  Verdict.bad: 'bad',
  Verdict.neutral: 'neutral',
  Verdict.excluded: 'excluded',
  Verdict.unknown: 'unknown',
};

SummaryDto _$SummaryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SummaryDto', json, ($checkedConvert) {
      final val = SummaryDto(
        summary: $checkedConvert('summary', (v) => jsonString(v)),
        cached: $checkedConvert('cached', (v) => v as bool? ?? false),
      );
      return val;
    });

TechnicalsDto _$TechnicalsDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'TechnicalsDto',
  json,
  ($checkedConvert) {
    final val = TechnicalsDto(
      symbol: $checkedConvert('symbol', (v) => jsonString(v)),
      currentPrice: $checkedConvert('current_price', (v) => jsonNum(v)),
      signals: $checkedConvert(
        'signals',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => SignalDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      ),
      indicators: $checkedConvert(
        'indicators',
        (v) => v == null ? null : IndicatorsDto.fromJson(v as Map<String, dynamic>),
      ),
      supportResistance: $checkedConvert(
        'support_resistance',
        (v) => v == null ? null : LevelsDto.fromJson(v as Map<String, dynamic>),
      ),
      chartData: $checkedConvert(
        'chart_data',
        (v) => v == null ? null : ChartDataDto.fromJson(v as Map<String, dynamic>),
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'currentPrice': 'current_price',
    'supportResistance': 'support_resistance',
    'chartData': 'chart_data',
  },
);

IndicatorsDto _$IndicatorsDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'IndicatorsDto',
  json,
  ($checkedConvert) {
    final val = IndicatorsDto(
      sma20: $checkedConvert('sma_20', (v) => jsonNumOrNull(v)),
      sma50: $checkedConvert('sma_50', (v) => jsonNumOrNull(v)),
      sma200: $checkedConvert('sma_200', (v) => jsonNumOrNull(v)),
      rsi: $checkedConvert('rsi', (v) => jsonNumOrNull(v)),
      macd: $checkedConvert('macd', (v) => jsonNumOrNull(v)),
      macdSignal: $checkedConvert('macd_signal', (v) => jsonNumOrNull(v)),
      macdHistogram: $checkedConvert('macd_histogram', (v) => jsonNumOrNull(v)),
      week52High: $checkedConvert('week52_high', (v) => jsonNumOrNull(v)),
      week52Low: $checkedConvert('week52_low', (v) => jsonNumOrNull(v)),
      week52Position: $checkedConvert('week52_position', (v) => jsonNumOrNull(v)),
      volumeRatio: $checkedConvert('volume_ratio', (v) => jsonNumOrNull(v)),
    );
    return val;
  },
  fieldKeyMap: const {
    'sma20': 'sma_20',
    'sma50': 'sma_50',
    'sma200': 'sma_200',
    'macdSignal': 'macd_signal',
    'macdHistogram': 'macd_histogram',
    'week52High': 'week52_high',
    'week52Low': 'week52_low',
    'week52Position': 'week52_position',
    'volumeRatio': 'volume_ratio',
  },
);

SignalDto _$SignalDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SignalDto', json, ($checkedConvert) {
      final val = SignalDto(
        name: $checkedConvert('name', (v) => jsonString(v)),
        status: $checkedConvert(
          'status',
          (v) =>
              $enumDecodeNullable(_$SignalStatusEnumMap, v, unknownValue: SignalStatus.neutral) ??
              SignalStatus.neutral,
        ),
        value: $checkedConvert('value', (v) => jsonString(v)),
        label: $checkedConvert('label', (v) => jsonString(v)),
      );
      return val;
    });

const _$SignalStatusEnumMap = {
  SignalStatus.bullish: 'bullish',
  SignalStatus.bearish: 'bearish',
  SignalStatus.neutral: 'neutral',
};

LevelsDto _$LevelsDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('LevelsDto', json, ($checkedConvert) {
      final val = LevelsDto(
        pivot: $checkedConvert('pivot', (v) => jsonNumOrNull(v)),
        r1: $checkedConvert('r1', (v) => jsonNumOrNull(v)),
        r2: $checkedConvert('r2', (v) => jsonNumOrNull(v)),
        s1: $checkedConvert('s1', (v) => jsonNumOrNull(v)),
        s2: $checkedConvert('s2', (v) => jsonNumOrNull(v)),
      );
      return val;
    });

ChartDataDto _$ChartDataDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'ChartDataDto',
  json,
  ($checkedConvert) {
    final val = ChartDataDto(
      dates: $checkedConvert('dates', (v) => jsonStringList(v)),
      ohlc: $checkedConvert('ohlc', (v) => _ohlcRows(v)),
      volume: $checkedConvert('volume', (v) => jsonNumOrNullList(v)),
      sma50: $checkedConvert('sma_50', (v) => jsonNumOrNullList(v)),
      sma200: $checkedConvert('sma_200', (v) => jsonNumOrNullList(v)),
      rsi: $checkedConvert('rsi', (v) => jsonNumOrNullList(v)),
      macdLine: $checkedConvert('macd_line', (v) => jsonNumOrNullList(v)),
      macdSignal: $checkedConvert('macd_signal', (v) => jsonNumOrNullList(v)),
      macdHistogram: $checkedConvert('macd_histogram', (v) => jsonNumOrNullList(v)),
    );
    return val;
  },
  fieldKeyMap: const {
    'sma50': 'sma_50',
    'sma200': 'sma_200',
    'macdLine': 'macd_line',
    'macdSignal': 'macd_signal',
    'macdHistogram': 'macd_histogram',
  },
);

PredictionDto _$PredictionDtoFromJson(Map<String, dynamic> json) => $checkedCreate(
  'PredictionDto',
  json,
  ($checkedConvert) {
    final val = PredictionDto(
      symbol: $checkedConvert('symbol', (v) => jsonString(v)),
      predictions: $checkedConvert(
        'predictions',
        (v) =>
            (v as Map<String, dynamic>?)?.map(
              (k, e) => MapEntry(k, HorizonDto.fromJson(e as Map<String, dynamic>)),
            ) ??
            {},
      ),
      overallOutlook: $checkedConvert(
        'overall_outlook',
        (v) =>
            $enumDecodeNullable(_$OutlookEnumMap, v, unknownValue: Outlook.neutral) ??
            Outlook.neutral,
      ),
      overallScore: $checkedConvert('overall_score', (v) => jsonNum(v)),
      modelType: $checkedConvert('model_type', (v) => jsonString(v)),
      topBullishSignals: $checkedConvert(
        'top_bullish_signals',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => PredictionSignalDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      ),
      topBearishSignals: $checkedConvert(
        'top_bearish_signals',
        (v) =>
            (v as List<dynamic>?)
                ?.map((e) => PredictionSignalDto.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
      ),
      modelVersion: $checkedConvert('model_version', (v) => jsonStringOrNull(v)),
      calibrated: $checkedConvert('calibrated', (v) => v as bool?),
      disclaimer: $checkedConvert('disclaimer', (v) => jsonStringOrNull(v)),
    );
    return val;
  },
  fieldKeyMap: const {
    'overallOutlook': 'overall_outlook',
    'overallScore': 'overall_score',
    'modelType': 'model_type',
    'topBullishSignals': 'top_bullish_signals',
    'topBearishSignals': 'top_bearish_signals',
    'modelVersion': 'model_version',
  },
);

const _$OutlookEnumMap = {
  Outlook.bullish: 'bullish',
  Outlook.bearish: 'bearish',
  Outlook.neutral: 'neutral',
};

HorizonDto _$HorizonDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('HorizonDto', json, ($checkedConvert) {
      final val = HorizonDto(
        direction: $checkedConvert(
          'direction',
          (v) =>
              $enumDecodeNullable(_$DirectionEnumMap, v, unknownValue: Direction.neutral) ??
              Direction.neutral,
        ),
        confidence: $checkedConvert('confidence', (v) => jsonNum(v)),
        score: $checkedConvert('score', (v) => jsonNum(v)),
        probabilityUp: $checkedConvert('probability_up', (v) => jsonNumOrNull(v)),
        calibrated: $checkedConvert('calibrated', (v) => v as bool?),
      );
      return val;
    }, fieldKeyMap: const {'probabilityUp': 'probability_up'});

const _$DirectionEnumMap = {
  Direction.up: 'up',
  Direction.down: 'down',
  Direction.neutral: 'neutral',
};

PredictionSignalDto _$PredictionSignalDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('PredictionSignalDto', json, ($checkedConvert) {
      final val = PredictionSignalDto(
        feature: $checkedConvert('feature', (v) => jsonString(v)),
        value: $checkedConvert('value', (v) => jsonNumOrNull(v)),
      );
      return val;
    });

GlossaryDto _$GlossaryDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GlossaryDto', json, ($checkedConvert) {
      final val = GlossaryDto(
        intro: $checkedConvert(
          'intro',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => GlossaryIntroDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ),
        pillars: $checkedConvert(
          'pillars',
          (v) =>
              (v as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, GlossaryPillarDto.fromJson(e as Map<String, dynamic>)),
              ) ??
              {},
        ),
        metrics: $checkedConvert(
          'metrics',
          (v) =>
              (v as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, GlossaryMetricDto.fromJson(e as Map<String, dynamic>)),
              ) ??
              {},
        ),
        scoring: $checkedConvert(
          'scoring',
          (v) => GlossaryScoringDto.fromJson(v as Map<String, dynamic>),
        ),
      );
      return val;
    });

GlossaryIntroDto _$GlossaryIntroDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GlossaryIntroDto', json, ($checkedConvert) {
      final val = GlossaryIntroDto(
        title: $checkedConvert('title', (v) => jsonString(v)),
        body: $checkedConvert('body', (v) => jsonString(v)),
      );
      return val;
    });

GlossaryPillarDto _$GlossaryPillarDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GlossaryPillarDto', json, ($checkedConvert) {
      final val = GlossaryPillarDto(
        label: $checkedConvert('label', (v) => jsonString(v)),
        tagline: $checkedConvert('tagline', (v) => jsonString(v)),
        body: $checkedConvert('body', (v) => jsonString(v)),
      );
      return val;
    });

GlossaryMetricDto _$GlossaryMetricDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GlossaryMetricDto', json, ($checkedConvert) {
      final val = GlossaryMetricDto(
        label: $checkedConvert('label', (v) => jsonString(v)),
        fullName: $checkedConvert('full_name', (v) => jsonString(v)),
        pillar: $checkedConvert('pillar', (v) => jsonString(v)),
        weight: $checkedConvert('weight', (v) => jsonNum(v)),
        formula: $checkedConvert('formula', (v) => jsonString(v)),
        plain: $checkedConvert('plain', (v) => jsonString(v)),
        ideal: $checkedConvert('ideal', (v) => jsonString(v)),
        bands: $checkedConvert(
          'bands',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => GlossaryBandDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ),
        caveat: $checkedConvert('caveat', (v) => jsonString(v)),
        watchOut: $checkedConvert('watch_out', (v) => jsonString(v)),
      );
      return val;
    }, fieldKeyMap: const {'fullName': 'full_name', 'watchOut': 'watch_out'});

GlossaryBandDto _$GlossaryBandDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GlossaryBandDto', json, ($checkedConvert) {
      final val = GlossaryBandDto(
        verdict: $checkedConvert(
          'verdict',
          (v) =>
              $enumDecodeNullable(_$VerdictEnumMap, v, unknownValue: Verdict.unknown) ??
              Verdict.unknown,
        ),
        note: $checkedConvert('note', (v) => jsonString(v)),
        max: $checkedConvert('max', (v) => jsonNumOrNull(v)),
      );
      return val;
    });

GlossaryScoringDto _$GlossaryScoringDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GlossaryScoringDto', json, ($checkedConvert) {
      final val = GlossaryScoringDto(
        grades: $checkedConvert(
          'grades',
          (v) =>
              (v as List<dynamic>?)
                  ?.map((e) => GradeBandDto.fromJson(e as Map<String, dynamic>))
                  .toList() ??
              [],
        ),
        howItWorks: $checkedConvert('how_it_works', (v) => jsonStringList(v)),
        limits: $checkedConvert('limits', (v) => jsonString(v)),
      );
      return val;
    }, fieldKeyMap: const {'howItWorks': 'how_it_works'});

GradeBandDto _$GradeBandDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('GradeBandDto', json, ($checkedConvert) {
      final val = GradeBandDto(
        min: $checkedConvert('min', (v) => jsonNum(v)),
        grade: $checkedConvert('grade', (v) => jsonString(v)),
        label: $checkedConvert('label', (v) => jsonString(v)),
      );
      return val;
    });
