import 'package:agentfolio/core/broker/broker_descriptor.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/domain/entities/link_account_request.dart';
import 'package:agentfolio/features/auth/domain/repositories/auth_repository.dart';
import 'package:agentfolio/features/auth/domain/usecases/link_account.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';

enum LinkStep { brokerCredentials, signIn }

/// The two-step link-account flow: broker credentials, then how the user
/// signs in from now on.
///
/// The broker is only contacted at the end, when everything is submitted. If
/// it rejects the credentials, the user is taken back to step one with the
/// message, and everything they typed is still there.
class LinkAccountViewModel extends BaseViewModel {
  LinkAccountViewModel({
    required this.broker,
    required this._repository,
    required this._linkAccount,
    required this._session,
    required this.consentRequired,
    required super.telemetry,
  });

  final BrokerDescriptor broker;
  final AuthRepository _repository;
  final LinkAccount _linkAccount;
  final SessionProvider _session;

  /// True once the Terms and Privacy pages exist; see `Env.hasLegalPages`.
  final bool consentRequired;

  /// Starts as loading, because the screen asks for the config as it opens.
  /// That way the first [loadConfig] does not notify mid-build.
  ViewState<AuthConfig> config = const ViewLoading();
  Country? country;
  LinkStep step = LinkStep.brokerCredentials;
  bool consent = false;
  bool submitting = false;

  /// Per-field messages, keyed by credential key or `whatsapp_number`,
  /// `app_password`, `app_password_confirm`.
  Map<String, String> fieldErrors = const {};

  /// Submit was pressed without accepting the Terms and Privacy Policy.
  bool consentMissing = false;

  /// A message for the whole step, e.g. the broker rejecting the credentials.
  String? formError;

  int get stepNumber => step.index + 1;
  static const stepCount = 2;

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
    _clearError('whatsapp_number');
  }

  void setConsent({required bool value}) {
    consent = value;
    consentMissing = false;
    notifyListeners();
  }

  /// Clears a field's message as soon as the user edits it.
  void edited(String field) => _clearError(field);

  /// Step one → two, if every credential is filled in.
  bool continueToSignIn(Map<String, String> credentials) {
    final problem = validateBrokerCredentials(broker, credentials);
    if (problem != null) {
      fieldErrors = {problem.field!: problem.message};
      notifyListeners();
      return false;
    }
    fieldErrors = const {};
    formError = null;
    step = LinkStep.signIn;
    notifyListeners();
    return true;
  }

  /// Step two → one. Returns false when already on step one.
  bool back() {
    if (step == LinkStep.brokerCredentials) return false;
    step = LinkStep.brokerCredentials;
    formError = null;
    notifyListeners();
    return true;
  }

  /// Returns true once linked and signed in; the router moves the user on.
  Future<bool> submit({
    required Map<String, String> credentials,
    required String national,
    required String appPassword,
    required String appPasswordConfirm,
  }) async {
    final cfg = config.dataOrNull;
    final selected = country;
    if (submitting || cfg == null || selected == null) return false;

    if (consentRequired && !consent) {
      consentMissing = true;
      notifyListeners();
      return false;
    }

    submitting = true;
    fieldErrors = const {};
    formError = null;
    notifyListeners();

    final request = LinkAccountRequest(
      broker: broker,
      brokerCredentials: credentials,
      phone: PhoneNumber(dialCode: selected.dialCode, national: national),
      appPassword: appPassword,
      appPasswordConfirm: appPasswordConfirm,
    );
    final result = await runAction('link_account', () => _linkAccount(request, cfg));
    if (isDisposed) return false;

    var signedIn = false;
    switch (result) {
      case Success():
        signedIn = await _session.signedInNow();
      case Err(failure: UnknownOutcomeFailure()):
        // The connection dropped after the request left. The server may well
        // have linked the account; ask before telling the user it failed.
        signedIn = await _session.signedInNow();
        if (!signedIn) formError = const UnknownOutcomeFailure().message;
      case Err(:final failure):
        _showFailure(failure);
    }
    submitting = false;
    notifyListeners();
    return signedIn;
  }

  /// Puts the message where it belongs: on a field of step two, or on step
  /// one (with the step switched back) for anything about the broker
  /// credentials, including the broker rejecting them outright.
  void _showFailure(Failure failure) {
    final field = failure is ValidationFailure ? failure.field : null;
    final target = linkAccountFieldFor(field);
    if (target == null || target == LinkAccountField.brokerCredentials) {
      step = failure is NetworkFailure || failure is TimeoutFailure || failure is RateLimitedFailure
          ? step
          : LinkStep.brokerCredentials;
      if (field != null && broker.credentialFields.any((f) => f.key == field)) {
        fieldErrors = {field: failure.message};
      } else {
        formError = failure.message;
      }
      return;
    }
    step = LinkStep.signIn;
    fieldErrors = {field!: failure.message};
  }

  void _clearError(String field) {
    if (!fieldErrors.containsKey(field)) {
      notifyListeners();
      return;
    }
    fieldErrors = {...fieldErrors}..remove(field);
    notifyListeners();
  }
}
