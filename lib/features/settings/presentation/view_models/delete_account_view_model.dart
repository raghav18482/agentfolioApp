import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';

/// Deleting the account: the app password, an explicit acknowledgement, then
/// the server. On success the session ends and the device is wiped; the
/// router takes the user to Login, which says the account is gone.
class DeleteAccountViewModel extends BaseViewModel {
  DeleteAccountViewModel({required this._session, required super.telemetry});

  final SessionProvider _session;

  bool understood = false;
  bool submitting = false;
  bool passwordMissing = false;
  bool notAcknowledged = false;
  Failure? failure;

  /// The failure belongs on the password field (wrong password).
  bool get passwordWrong => failure is ValidationFailure;

  void setUnderstood({required bool value}) {
    understood = value;
    notAcknowledged = false;
    notifyListeners();
  }

  void clearErrors() {
    if (failure == null && !passwordMissing) return;
    failure = null;
    passwordMissing = false;
    notifyListeners();
  }

  /// True once the form is complete enough to ask the final "are you sure".
  bool validate(String password) {
    passwordMissing = password.isEmpty;
    notAcknowledged = !understood;
    failure = null;
    notifyListeners();
    return !passwordMissing && !notAcknowledged;
  }

  Future<bool> delete(String password) async {
    if (submitting) return false;
    submitting = true;
    notifyListeners();
    final result = await runAction('delete_account', () => _session.deleteAccount(password));
    submitting = false;
    if (result case Err(failure: final f)) failure = f;
    notifyListeners();
    return result is Success;
  }
}
