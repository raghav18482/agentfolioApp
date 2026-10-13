// Response bodies shaped exactly as the FastAPI server sends them, for DTO
// and repository tests. Kept small but structurally faithful: the quirks
// (OHLC order, empty indicator lists, 200-with-error) are the point.

/// An indicator that is null until its window of [warmup] days has filled.
List<double?> _warming(int days, int warmup, double Function(int i) value) =>
    List.generate(days, (i) => i < warmup ? null : value(i));

List<String> _dates(int n) => [
  for (var i = 0; i < n; i++)
    DateTime(2026).add(Duration(days: i)).toIso8601String().substring(0, 10),
];

/// `GET /api/research/technical` for a stock with [days] of history: too
/// short for SMA 200, so the server sends `sma_200: []`.
Map<String, Object?> technicalJson({int days = 60, String symbol = 'RELIANCE-EQ'}) => {
  'symbol': symbol,
  'current_price': 1010.0,
  'avg_price': 900.0,
  'error': null,
  'indicators': {
    'sma_20': 1000.5,
    'sma_50': 990.25,
    'sma_200': null,
    'rsi': 62.4,
    'macd': 4.2,
    'macd_signal': 3.1,
    'macd_histogram': 1.1,
    'week52_high': 1100,
    'week52_low': '850.5',
    'week52_position': 63,
    'volume_ratio': 1.4,
  },
  'signals': [
    {'name': '50 DMA', 'value': '₹990.25', 'status': 'bullish', 'label': 'Above 50 DMA'},
    {'name': 'RSI (14)', 'value': 62.4, 'status': 'neutral', 'label': 'Neutral'},
    {'name': 'MACD', 'value': '+4.20', 'status': 'sideways', 'label': 'Weird'},
  ],
  'support_resistance': {'pivot': 1000, 'r1': 1020, 'r2': 1040, 's1': 980, 's2': 960},
  'chart_data': {
    'dates': _dates(days),
    // [open, high, low, close]
    'ohlc': [
      for (var i = 0; i < days; i++) [900.0 + i, 905.0 + i, 895.0 + i, 902.0 + i],
    ],
    'volume': [for (var i = 0; i < days; i++) 1000 + i],
    'sma_50': _warming(days, 49, (i) => 950.0 + i),
    'sma_200': <Object?>[],
    'rsi': _warming(days, 14, (_) => 50),
    'macd_line': _warming(days, 25, (_) => 1),
    'macd_signal': _warming(days, 33, (_) => 0.5),
    'macd_histogram': _warming(days, 33, (_) => 0.5),
  },
};

Map<String, Object?> fundamentalJson() => {
  'symbol': 'RELIANCE-EQ',
  'yf_symbol': 'RELIANCE.NS',
  'valuation': {
    'pe_ratio': 24.1,
    'pb_ratio': 2.2,
    'ev_ebitda': null,
    'peg_ratio': 'N/A',
    'dividend_yield': 0.4,
    'trailing_eps': 51.2,
    'forward_pe': 21.0,
  },
  'health': {'roe': 9.1, 'debt_to_equity': 0.41, 'free_cash_flow': 1.2e11},
  'revenue_trend': [
    {'year': '2023', 'value': 8.7e12},
    {'year': '2024', 'value': 9.0e12},
  ],
  'profit_trend': [
    {'year': '2023', 'value': 6.6e11},
    {'year': '2024', 'value': -1.0e10},
  ],
  'score': {
    'total': 64,
    'grade': 'C',
    'label': 'Average',
    'confidence': 'medium',
    'metrics_used': 11,
    'metrics_total': 15,
    'pillars': [
      {
        'key': 'valuation',
        'label': 'Valuation',
        'tagline': 'Are you overpaying?',
        'score': 18.5,
        'max': 25,
        'metrics': [
          {
            'key': 'pe_ratio',
            'label': 'P/E Ratio',
            'value': 24.1,
            'display': '24.1x',
            'verdict': 'good',
            'note': 'Fairly valued',
          },
          {
            'key': 'ev_ebitda',
            'label': 'EV/EBITDA',
            'value': null,
            'display': '—',
            'verdict': 'surprising',
            'note': '',
          },
        ],
      },
      {
        'key': 'balance_sheet',
        'label': 'Balance sheet',
        'tagline': 'Can it survive a bad year?',
        'score': null,
        'max': 25,
        'metrics': [
          {
            'key': 'debt_to_equity',
            'label': 'Debt to Equity',
            'value': null,
            'display': '—',
            'verdict': 'excluded',
            'note': 'Not meaningful for a bank',
          },
        ],
      },
    ],
    'strengths': ['Fairly valued'],
    'concerns': ['Thin margins'],
    'excluded': ['debt_to_equity', 'peg_ratio'],
  },
  'sector': 'Energy',
  'industry': 'Oil & Gas Refining & Marketing',
  'error': null,
};

Map<String, Object?> predictionJson({String modelType = 'heuristic'}) => {
  'symbol': 'RELIANCE-EQ',
  'predictions': {
    '1day': {'direction': 'up', 'confidence': 0.62, 'score': 0.12},
    '1week': {'direction': 'down', 'confidence': 0.7, 'score': -0.2},
    '1month': {'direction': 'sideways', 'confidence': 0.5, 'score': 0},
    '1year': {'direction': 'up', 'confidence': 0.9, 'score': 0.5},
  },
  'overall_outlook': 'bullish',
  'overall_score': 0.58,
  'model_type': modelType,
  'model_version': modelType == 'heuristic' ? null : '0123456789abcdef',
  'disclaimer': modelType == 'heuristic'
      ? 'No trained model is registered. These are rule-based technical scores, not '
            'machine-learning predictions, and the confidence shown is not a calibrated '
            'probability.'
      : null,
  'top_bullish_signals': [
    {'feature': 'RSI slope', 'value': 1.2},
  ],
  'top_bearish_signals': <Object?>[],
};

Map<String, Object?> glossaryJson() => {
  '_about': 'ignored',
  'intro': [
    {'title': 'Ratios compare', 'body': 'A number alone means little.'},
  ],
  'pillars': {
    'valuation': {'label': 'Valuation', 'tagline': 'Price', 'body': 'What you pay.'},
    'profitability': {'label': 'Profitability', 'tagline': 'Returns', 'body': 'What it earns.'},
  },
  'metrics': {
    'pe_ratio': {
      'label': 'P/E Ratio',
      'full_name': 'Price to Earnings',
      'pillar': 'valuation',
      'unit': 'x',
      'weight': 1.0,
      'formula': 'Share price ÷ earnings per share',
      'plain': 'Years of profit you pay for.',
      'ideal': '15–25',
      'bands': [
        {'max': 0, 'verdict': 'bad', 'note': 'Loss-making'},
        {'max': 25, 'verdict': 'good', 'note': 'Fair'},
        {'max': null, 'verdict': 'bad', 'note': 'Expensive'},
      ],
      'caveat': 'Sector decides normal.',
      'watch_out': 'Value traps.',
    },
    'market_cap': {
      'label': 'Market cap',
      'full_name': 'Market capitalisation',
      'pillar': 'valuation',
      'unit': '₹',
      'weight': 0,
      'formula': '',
      'plain': 'The company’s price tag.',
      'ideal': '',
      'bands': <Object?>[],
      'caveat': '',
      'watch_out': '',
    },
    'roe': {
      'label': 'ROE',
      'full_name': 'Return on equity',
      'pillar': 'profitability',
      'unit': '%',
      'weight': 1.0,
      'formula': 'Net profit ÷ equity',
      'plain': 'Profit per rupee of owners’ money.',
      'ideal': 'Above 15%',
      'bands': [
        {'max': 10, 'verdict': 'bad', 'note': 'Low'},
        {'max': null, 'verdict': 'good', 'note': 'Healthy'},
      ],
      'caveat': '',
      'watch_out': 'Debt can inflate it.',
    },
  },
  'scoring': {
    'grades': [
      {'min': 80, 'grade': 'A', 'label': 'Strong'},
      {'min': 0, 'grade': 'E', 'label': 'Poor'},
    ],
    'how_it_works': ['Four pillars, 25 points each.'],
    'limits': 'It cannot see management quality.',
  },
};
