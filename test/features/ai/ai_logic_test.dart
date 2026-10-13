import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/utils/amount_mask.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('key rules', () {
    test('a key must be one unbroken run of characters, of key length', () {
      expect(AiKeyRules.check(''), KeyProblem.empty);
      expect(AiKeyRules.check('   '), KeyProblem.empty);
      expect(AiKeyRules.check('sk-or-v1-abc def-0123456789'), KeyProblem.whitespace);
      expect(AiKeyRules.check('sk-or-v1-abc\n0123456789'), KeyProblem.whitespace);
      expect(AiKeyRules.check('sk-or-v1-abc'), KeyProblem.tooShort);
      // Pasting often brings a trailing newline: trimmed, not refused.
      expect(AiKeyRules.check('  sk-or-v1-0123456789abcdef\n'), isNull);
    });

    test('an unfamiliar prefix is allowed but noticed', () {
      expect(AiKeyRules.looksLikeOpenRouter('sk-or-v1-0123456789abcdef'), isTrue);
      expect(AiKeyRules.looksLikeOpenRouter('sk-proj-0123456789abcdef'), isFalse);
    });

    test('fingerprints are stable per key, differ across keys, and hide the key', () {
      const key = 'sk-or-v1-0123456789abcdef';
      final a = AiKeyRules.fingerprint(key);
      expect(AiKeyRules.fingerprint(' $key '), a);
      expect(AiKeyRules.fingerprint('${key}0'), isNot(a));
      expect(a, hasLength(16));
      expect(a.contains('0123456789'), isFalse);
    });

    test('only a refused key sends the user to settings', () {
      expect(
        AiKeyRules.isKeyFailure(
          const ValidationFailure('Invalid OpenRouter API key. Please check and try again.'),
        ),
        isTrue,
      );
      expect(
        AiKeyRules.isKeyFailure(const ValidationFailure('Please enter your OpenRouter API key')),
        isTrue,
      );
      expect(AiKeyRules.isKeyFailure(const ValidationFailure('Question cannot be empty')), isFalse);
      expect(AiKeyRules.isKeyFailure(const ServerFailure('api key exploded')), isFalse);
    });

    test('credentials never print the key', () {
      const c = AiCredentials(apiKey: 'sk-or-v1-secret-secret', model: 'openai/gpt-4o');
      expect(c.toString(), isNot(contains('secret')));
      expect(c.toString(), contains('openai/gpt-4o'));
    });
  });

  test('model ids follow OpenRouter provider/model, with an optional variant', () {
    for (final id in [
      ...AiModels.presets,
      'meta-llama/llama-3.1-8b-instruct:free',
      'x-ai/grok-2',
    ]) {
      expect(AiModels.isValidId(id), isTrue, reason: id);
    }
    for (final id in ['gpt-4o', '/gpt', 'openai/', 'open ai/gpt', 'https://x.ai/m', '']) {
      expect(AiModels.isValidId(id), isFalse, reason: id);
    }
  });

  group('amount mask', () {
    test('masks rupee amounts in every way a model writes them', () {
      expect(AmountMask.apply('Up Rs. 3,600 overall'), 'Up Rs. •••• overall');
      expect(AmountMask.apply('Cash ₹15,000.50 idle'), 'Cash ₹ •••• idle');
      expect(AmountMask.apply('worth ₹4.2L now'), 'worth ₹ •••• now');
      expect(AmountMask.apply('INR 5 crore'), 'INR ••••');
      expect(AmountMask.apply('a loss of Rs.-1,200'), 'a loss of Rs. ••••');
      expect(AmountMask.apply('**₹1,23,456**'), '**₹ ••••**');
    });

    test('leaves percentages, counts and words alone', () {
      const text = 'TCS is 47% of 3 holdings; RSI 62. Results 2026. Mrs Rao.';
      expect(AmountMask.apply(text), text);
    });
  });
}
