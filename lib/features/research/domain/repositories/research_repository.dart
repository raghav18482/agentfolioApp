import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/research/domain/entities/glossary.dart';
import 'package:agentfolio/features/research/domain/entities/prediction.dart';
import 'package:agentfolio/features/research/domain/entities/technicals.dart';

/// Per-stock research. `symbol` is always the broker's full trading symbol
/// (`BAJAJ-AUTO-EQ`, not `BAJAJ-AUTO`): the server finds the instrument by
/// cutting the last `-` segment, so a bare symbol with a hyphen resolves to
/// the wrong stock.
abstract interface class ResearchRepository {
  /// A year of daily bars with indicators, signals and pivot levels.
  Future<Result<Technicals>> technicals(String symbol, {bool force = false});

  /// Slow: Yahoo-backed.
  Future<Result<Fundamentals>> fundamentals(String symbol, {bool force = false});

  Future<Result<Prediction>> prediction(String symbol, {bool force = false});

  /// Generated with the server's LLM key, which it pays for. [regenerate]
  /// asks for a fresh one; the server still rate-limits that.
  Future<Result<AiSummary>> summary(String symbol, {bool regenerate = false});

  Future<Result<Glossary>> glossary();

  /// The glossary if already loaded, for an instant ⓘ sheet.
  Glossary? cachedGlossary();
}
