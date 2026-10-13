import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/features/ai/domain/repositories/ai_repository.dart';
import 'package:agentfolio/features/ai/presentation/providers/ai_key_provider.dart';

/// One question and what came back for it.
class AskExchange {
  AskExchange(this.id, this.question);

  final int id;
  final String question;
  ViewState<String> answer = const ViewLoading();
}

/// Questions about the portfolio, answered with the user's own key. Lives as
/// long as the Ask sheet: a quick back-and-forth, not a saved conversation
/// (that is what the agent is for).
class AskViewModel extends BaseViewModel {
  AskViewModel({required this._ai, required this._aiKey, required super.telemetry});

  final AiRepository _ai;
  final AiKeyProvider _aiKey;
  final List<AskExchange> _exchanges = [];
  int _nextId = 0;

  /// Longest question accepted; the whole portfolio goes with it, so a very
  /// long one only costs more.
  static const maxLength = 500;

  List<AskExchange> get exchanges => List.unmodifiable(_exchanges);

  /// One question at a time: each is billed, and answers arrive in order.
  bool get busy => _exchanges.any((e) => e.answer is ViewLoading<String>);

  Future<void> ask(String raw) async {
    final question = raw.trim();
    if (question.isEmpty || busy) return;
    final exchange = AskExchange(_nextId++, question);
    _exchanges.add(exchange);
    await _answer(exchange);
  }

  /// Asks a failed question again, in place.
  Future<void> retry(int id) async {
    if (busy) return;
    final exchange = _exchanges.where((e) => e.id == id).firstOrNull;
    if (exchange == null || exchange.answer is! ViewError<String>) return;
    exchange.answer = const ViewLoading();
    await _answer(exchange);
  }

  Future<void> _answer(AskExchange exchange) async {
    notifyListeners();
    final credentials = await _aiKey.credentials();
    if (credentials == null) {
      exchange.answer = const ViewError(ValidationFailure('Please enter your OpenRouter API key'));
      notifyListeners();
      return;
    }
    final result = await runAction('ai_ask', () => _ai.ask(exchange.question, credentials));
    exchange.answer = switch (result) {
      Success(:final value) => ViewData(value),
      Err(:final failure) => ViewError(failure),
    };
    notifyListeners();
  }
}
