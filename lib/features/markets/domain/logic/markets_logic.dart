import 'package:agentfolio/features/markets/domain/entities/markets.dart';

/// The biggest risers and fallers among [indices], for a phone-sized list:
/// up to [count] of each, biggest moves first, flat ones left out.
({List<IndexMove> up, List<IndexMove> down}) topMoves(List<IndexMove> indices, {int count = 5}) {
  final up = indices.where((i) => i.changePercent > 0).toList()
    ..sort((a, b) => b.changePercent.compareTo(a.changePercent));
  final down = indices.where((i) => i.changePercent < 0).toList()
    ..sort((a, b) => a.changePercent.compareTo(b.changePercent));
  return (up: up.take(count).toList(), down: down.take(count).toList());
}

/// The mood the server would give these tallies, for summaries the server
/// did not compute: more than 20 points net positive or negative.
Mood moodOf({required int bullish, required int bearish, required int neutral}) {
  final total = bullish + bearish + neutral;
  if (total == 0) return Mood.neutral;
  final score = (bullish - bearish) / total;
  return score > 0.2
      ? Mood.bullish
      : score < -0.2
      ? Mood.bearish
      : Mood.neutral;
}

/// Search suggestions: the user's largest holdings first, then general
/// market topics, without duplicates.
List<String> searchSuggestions(List<String> topHoldings, {int max = 8}) {
  const topics = ['Nifty 50', 'Sensex', 'RBI policy', 'FII flows', 'IT sector', 'Banking sector'];
  final seen = <String>{};
  return [
    for (final s in [...topHoldings, ...topics])
      if (s.trim().isNotEmpty && seen.add(s.toLowerCase())) s,
  ].take(max).toList();
}

const _acronyms = {
  'IT',
  'FMCG',
  'PSU',
  'PSE',
  'CPSE',
  'MNC',
  'ESG',
  'SME',
  'TR',
  'PR',
  'REIT',
  'REITS',
  'INVIT',
  'INVITS',
  'IPO',
  'EV',
  'BSE',
  'NSE',
  'VIX',
  'LIX',
  'SDL',
  'ETF',
  'MF',
};

/// An NSE index name as people write it: `NIFTY FINANCIAL SERVICES` becomes
/// `Nifty Financial Services`, while market acronyms and codes stay in
/// capitals: `Nifty FMCG`, `Nifty PSU Bank`, `Nifty50 TR 2X Leverage`.
String indexDisplayName(String name) => name
    .split(RegExp(r'\s+'))
    .where((w) => w.isNotEmpty)
    .map((w) {
      final upper = w.toUpperCase();
      if (_acronyms.contains(upper)) return upper;
      if (upper.startsWith('NIFTY')) return 'Nifty${upper.substring(5).toUpperCase()}';
      if (RegExp(r'\d').hasMatch(w)) return upper; // 2X, 50:50
      return '${upper[0]}${upper.substring(1).toLowerCase()}';
    })
    .join(' ');
