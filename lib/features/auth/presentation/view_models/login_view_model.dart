import 'dart:async';

import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/domain/repositories/auth_repository.dart';
import 'package:agentfolio/features/auth/domain/usecases/login.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';

/// What went wrong with the last login attempt, as the screen shows it.
sealed class LoginProblem {
  const LoginProblem(this.message);

  final String message;
}

/// One field is at fault: mark it.
final class LoginFieldProblem extends LoginProblem {
  const LoginFieldProblem(super.message, {required this.field});

  final String field;
}

/// A banner over the form.
final class LoginFormProblem extends LoginProblem {
  const LoginFormProblem(super.message);
}

/// Login succeeded but reading the new session afterwards did not. Rare; the
/// screen shows its own localised message for it.
final class LoginSessionNotLoaded extends LoginProblem {
  const LoginSessionNotLoaded() : super('');
}

/// The password was right but the broker refused the stored credentials:
/// the way out is linking the account again.
final class LoginBrokerRejected extends LoginProblem {
  const LoginBrokerRejected(super.message);
}

class LoginViewModel extends BaseViewModel {
  LoginViewModel({
    required this._repository,
    required this._login,
    required this._session,
    required super.telemetry,
    DateTime Function()? clock,
  }) : _now = clock ?? DateTime.now;

  final AuthRepository _repository;
  final Login _login;
  final SessionProvider _session;
  final DateTime Function() _now;

  /// Starts as loading, because the screen asks for the config as it opens.
  /// That way the first [loadConfig] does not notify mid-build.
  ViewState<AuthConfig> config = const ViewLoading();
  Country? country;
  bool submitting = false;
  LoginProblem? problem;

  /// When a throttled user may try again. The button counts down to it.
  DateTime? _retryAt;
  Timer? _ticker;

  Duration? get retryIn {
    final at = _retryAt;
    if (at == null) return null;
    final left = at.difference(_now());
    return left.isNegative ? null : left;
  }

  bool get canSubmit => !submitting && retryIn == null && config is ViewData<AuthConfig>;

  Future<void> loadConfig() async {
    if (config is! ViewLoading<AuthConfig>) {
      config = const ViewLoading();
      notifyListeners();
    }
    final result = await _repository.authConfig();
    if (isDisposed) return;
    config = switch (result) {
      Success(:final value) => ViewData(value),
      Err(:final failure) => ViewError(failure),
    };
    country ??= result.valueOrNull?.defaultCountry;
    notifyListeners();
  }

  void selectCountry(Country value) {
    country = value;
    if (problem is LoginFieldProblem) problem = null;
    notifyListeners();
  }

  /// Clears a field's message as soon as the user edits that field.
  void edited(String field) {
    final current = problem;
    if (current is LoginFieldProblem && current.field == field) {
      problem = null;
      notifyListeners();
    }
  }

  /// Returns true when signed in; the router then moves the user on.
  Future<bool> submit({required String national, required String appPassword}) async {
    final selected = country;
    if (!canSubmit || selected == null) return false;
    submitting = true;
    problem = null;
    notifyListeners();

    final phone = PhoneNumber(dialCode: selected.dialCode, national: national);
    final result = await runAction('login', () => _login(phone: phone, appPassword: appPassword));
    if (isDisposed) return false;

    var signedIn = false;
    switch (result) {
      case Success():
        signedIn = await _session.signedInNow();
        if (!signedIn) problem = const LoginSessionNotLoaded();
      case Err(failure: UnknownOutcomeFailure()):
        // The connection dropped after the request left: the login may have
        // gone through. Ask the server rather than guess.
        signedIn = await _session.signedInNow();
        if (!signedIn) problem = const LoginSessionNotLoaded();
      case Err(:final failure):
        problem = _problemFor(failure);
        if (failure is RateLimitedFailure) _startCountdown(failure.retryAfter);
    }
    submitting = false;
    notifyListeners();
    return signedIn;
  }

  LoginProblem _problemFor(Failure failure) => switch (failure) {
    ValidationFailure(:final field?) => LoginFieldProblem(failure.message, field: field),
    BrokerFailure(statusCode: 502) => LoginBrokerRejected(failure.message),
    _ => LoginFormProblem(failure.message),
  };

  void _startCountdown(Duration? retryAfter) {
    _retryAt = _now().add(retryAfter ?? const Duration(seconds: 30));
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (retryIn == null) {
        timer.cancel();
        _retryAt = null;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
