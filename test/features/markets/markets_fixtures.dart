// Response bodies shaped as the FastAPI server sends them.

Map<String, Object?> article(String title, {String source = 'Mint', String? date, String? tone}) =>
    {
      'title': title,
      'link': 'https://news.google.com/rss/articles/$title',
      'date': date ?? 'Sun, 11 Oct 2026 07:00:00 GMT',
      'description': '$title, in detail.',
      'source': source,
      'sentiment': ?(tone == null ? null : {'label': tone, 'confidence': 0.91}),
    };

Map<String, Object?> portfolioNewsJson() => {
  'sectors': [
    {
      'name': 'IT',
      'invested': 32000.5,
      'news': [article('TCS wins deal'), article('Infosys guidance')],
    },
    {
      'name': 'Energy',
      'invested': 12000,
      'news': [article('Oil slips')],
    },
  ],
};

Map<String, Object?> sentimentJson() => {
  'sectors': [
    {
      'name': 'IT',
      'invested': 32000.5,
      'news': [
        article('TCS wins deal', tone: 'positive'),
        article('Infosys guidance', tone: 'neutral'),
      ],
      'sentiment_summary': {
        'label': 'bullish',
        'avg_score': 0.5,
        'bullish': 1,
        'bearish': 0,
        'neutral': 1,
      },
    },
    {
      'name': 'Energy',
      'invested': 12000,
      'news': [article('Oil slips', tone: 'negative')],
      'sentiment_summary': {
        'label': 'bearish',
        'avg_score': -1,
        'bullish': 0,
        'bearish': 1,
        'neutral': 0,
      },
    },
  ],
  'portfolio_sentiment': {
    'label': 'neutral',
    'score': 0.0,
    'bullish': 1,
    'bearish': 1,
    'neutral': 1,
    'total_articles': 3,
  },
};

Map<String, Object?> breadthJson() => {
  'advance_decline': {'advances': 40, 'declines': 22},
  'week52_highs': 31,
  'week52_lows': '9',
  'sector_heatmap': [
    {'name': 'NIFTY IT', 'change': 2.1},
    {'name': 'NIFTY BANK', 'change': -1.4},
    {'name': 'NIFTY FMCG', 'change': 0.3},
    {'name': 'NIFTY METAL', 'change': -0.2},
    {'name': '', 'change': 9.9},
  ],
  'fii_dii': null,
  'india_vix': {'current': 13.42, 'change': 0.55},
  'error': null,
};

Map<String, Object?> sectorsJson() => {
  'sectors': [
    {
      'name': 'IT',
      'index_name': 'NIFTY IT',
      'weight': 42.5,
      'invested': 32000.5,
      'holdings': [
        {'symbol': 'TCS-EQ', 'ltp': 4100.5, 'pnl_pct': 12.4, 'qty': 3},
        {'symbol': 'INFY-EQ', 'ltp': 1500, 'pnl_pct': -3.1},
      ],
      'holdings_count': 2,
      'index_performance': {
        'current': 41000,
        '1w': 1.2,
        '1m': -2.5,
        '3m': null,
        '6m': 8.1,
        '1y': 14,
      },
      'driver': 'US tech spending and the rupee.',
    },
    {
      'name': 'Capital Goods',
      'index_name': 'No index for Capital Goods',
      'weight': 10,
      'invested': 9000,
      'holdings': <Object?>[],
      'holdings_count': 1,
      'index_performance': null,
      'driver': '',
    },
  ],
};
