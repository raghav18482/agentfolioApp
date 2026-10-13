import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';
import 'package:agentfolio/features/ai/domain/repositories/ai_repository.dart';
import 'package:agentfolio/features/ai/presentation/providers/ai_key_provider.dart';

/// The Home insights card.
///
/// Written only when the user asks: each one is billed to their OpenRouter
/// key, and Home opens many times a day. Once written it stays for the
/// session, and comes back instantly on the next visit.
class AiInsightsViewModel extends BaseViewModel {
  AiInsightsViewModel({required this._ai, required this._aiKey, required super.telemetry}) {
    _aiKey.addListener(_onKeyChanged);
    _onKeyChanged();
  }

  final AiRepository _ai;
  final AiKeyProvider _aiKey;

  ViewState<Insight> _state = const ViewIdle();
  String? _fingerprint;
  int _sequence = 0;

  ViewState<Insight> get state => _state;
  bool get hasKey => _aiKey.hasKey;
  bool get keyReady => _aiKey.isReady;

  /// The model the next one will be written with.
  String get model => _aiKey.model;

  /// A new key means a new reader: forget what the old key wrote here, and
  /// show what the new one already has, if anything.
  void _onKeyChanged() {
    final fingerprint = _aiKey.keyFingerprint;
    if (fingerprint != _fingerprint) {
      _fingerprint = fingerprint;
      _sequence++;
      final cached = fingerprint == null ? null : _ai.cachedInsights(fingerprint);
      _state = cached == null ? const ViewIdle() : ViewData(cached, updatedAt: cached.writtenAt);
    }
    notifyListeners();
  }

  Future<void> generate() async {
    if (_state.isBusy) return;
    final sequence = ++_sequence;
    final current = _state.dataOrNull;
    _state = current == null ? const ViewLoading() : ViewData(current, refreshing: true);
    notifyListeners();

    final credentials = await _aiKey.credentials();
    if (sequence != _sequence) return;
    if (credentials == null) {
      _state = current == null ? const ViewIdle() : ViewData(current);
      notifyListeners();
      return;
    }

    final result = await runAction(
      current == null ? 'ai_insights' : 'ai_insights_regenerate',
      () => _ai.insights(credentials, regenerate: current != null),
    );
    if (sequence != _sequence) return;
    _state = switch (result) {
      Success(:final value) => ViewData(value, updatedAt: value.writtenAt),
      Err(:final failure) when current != null => ViewData(current, refreshFailure: failure),
      Err(:final failure) => ViewError(failure),
    };
    notifyListeners();
  }

  /// The failure on screen, if it is the key's fault.
  bool get failedOnKey => switch (_state) {
    ViewError(:final failure) ||
    ViewData(refreshFailure: final Failure failure) => AiKeyRules.isKeyFailure(failure),
    _ => false,
  };

  @override
  void dispose() {
    _aiKey.removeListener(_onKeyChanged);
    super.dispose();
  }
}
