import 'dart:convert';

import 'package:agentfolio/core/error/failure.dart';
import 'package:crypto/crypto.dart';

/// What an AI request needs from the user: their OpenRouter key and the
/// model to bill it to. Built at the moment of a request and dropped after.
class AiCredentials {
  const AiCredentials({required this.apiKey, required this.model});

  final String apiKey;
  final String model;

  /// Never prints the key, so it cannot leak into a log line or crash report.
  @override
  String toString() => 'AiCredentials(model: $model, apiKey: [redacted])';
}

/// The AI's reading of the whole portfolio.
class Insight {
  const Insight({required this.markdown, required this.model, required this.writtenAt});

  final String markdown;

  /// The model that wrote it, which may no longer be the one selected.
  final String model;
  final DateTime writtenAt;
}

/// Model choices offered without typing, matching the web app.
abstract final class AiModels {
  static const fallback = 'openai/gpt-4o-mini';

  static const presets = [
    'openai/gpt-4o-mini',
    'openai/gpt-4o',
    'anthropic/claude-3.5-haiku',
    'google/gemini-2.0-flash-001',
  ];

  static final _id = RegExp(r'^[a-z0-9][a-z0-9._-]*/[a-z0-9][a-z0-9._:-]*$', caseSensitive: false);

  /// OpenRouter ids are `provider/model`, optionally with a `:variant`.
  static bool isValidId(String id) => _id.hasMatch(id.trim());
}

/// What is wrong with a key as typed, before it is ever sent.
enum KeyProblem { empty, whitespace, tooShort }

abstract final class AiKeyRules {
  static const _minLength = 20;

  static KeyProblem? check(String raw) {
    final key = raw.trim();
    if (key.isEmpty) return KeyProblem.empty;
    if (RegExp(r'\s').hasMatch(key)) return KeyProblem.whitespace;
    if (key.length < _minLength) return KeyProblem.tooShort;
    return null;
  }

  /// OpenRouter keys start `sk-or-`. Anything else is allowed, since the
  /// format could change, but worth a gentle word.
  static bool looksLikeOpenRouter(String raw) => raw.trim().startsWith('sk-or-');

  /// A short, stable id for a key: answers are cached under it, so a new key
  /// never shows an answer paid for with the old one. Not reversible.
  static String fingerprint(String key) =>
      sha256.convert(utf8.encode('agentfolio-ai-key:${key.trim()}')).toString().substring(0, 16);

  /// The server rejected the key itself (wrong, revoked), rather than the
  /// question: the fix is in AI settings, so the UI offers to go there.
  static bool isKeyFailure(Failure failure) =>
      failure is ValidationFailure && failure.message.toLowerCase().contains('api key');
}
