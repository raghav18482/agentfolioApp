import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';

/// Portfolio insights and questions, written with the user's own OpenRouter
/// key. Every call spends the user's credit, so nothing here retries.
abstract interface class AiRepository {
  /// Kept for the session under [AiKeyRules.fingerprint]; [regenerate] asks
  /// for a fresh one.
  Future<Result<Insight>> insights(AiCredentials credentials, {bool regenerate = false});

  /// The insight already written with this key, if any.
  Insight? cachedInsights(String keyFingerprint);

  Future<Result<String>> ask(String question, AiCredentials credentials);
}
