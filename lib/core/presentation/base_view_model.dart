import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// The base for every screen's view model.
///
/// * [notifyListeners] after dispose is a no-op, so a response landing after
///   the user left the screen cannot throw.
/// * [cancelToken] is cancelled on dispose, for requests nobody else shares.
/// * [runAction] records each user action's outcome and duration, so every
///   button press and its result reaches telemetry with no per-feature code.
abstract class BaseViewModel extends ChangeNotifier {
  BaseViewModel({required this.telemetry});

  @protected
  final Telemetry telemetry;

  CancelToken? _cancelToken;
  bool _disposed = false;

  bool get isDisposed => _disposed;

  @protected
  CancelToken get cancelToken => _cancelToken ??= CancelToken();

  /// Runs a user action, reporting `action_succeeded` / `action_failed`.
  ///
  /// [name] is an identifier like `approve_proposal`, never user data.
  @protected
  Future<Result<T>> runAction<T>(String name, Future<Result<T>> Function() action) async {
    final watch = Stopwatch()..start();
    final result = await action();
    final failure = result.failureOrNull;
    if (failure is! CancelledFailure) {
      telemetry.track(
        TelemetryEvent(failure == null ? EventName.actionSucceeded : EventName.actionFailed, {
          'action': name,
          'duration_ms': watch.elapsedMilliseconds,
          if (failure != null) 'failure': failureCode(failure),
        }),
      );
    }
    return result;
  }

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _cancelToken?.cancel('Screen closed');
    super.dispose();
  }
}

/// A stable, analytics-friendly name for a failure kind.
String failureCode(Failure failure) => switch (failure) {
  NetworkFailure() => 'network',
  TimeoutFailure() => 'timeout',
  UnauthorizedFailure() => 'unauthorized',
  PremiumRequiredFailure() => 'premium_required',
  RateLimitedFailure() => 'rate_limited',
  BrokerFailure() => 'broker',
  ValidationFailure() => 'validation',
  UnavailableFailure() => 'unavailable',
  ServerFailure() => 'server',
  UnknownOutcomeFailure() => 'unknown_outcome',
  CancelledFailure() => 'cancelled',
  ParseFailure() => 'parse',
  UnexpectedFailure() => 'unexpected',
};
