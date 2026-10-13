import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/presentation/base_view_model.dart';
import 'package:agentfolio/core/presentation/loadable.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/domain/repositories/auth_repository.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/trading/domain/repositories/trading_repository.dart';

/// Turning on Premium for the signed-in broker account: just a WhatsApp
/// number, since the server reuses the session's broker credentials.
class PremiumViewModel extends BaseViewModel {
  PremiumViewModel({
    required this._trading,
    required this._auth,
    required this._session,
    required super.telemetry,
  });

  final TradingRepository _trading;
  final AuthRepository _auth;
  final SessionProvider _session;

  late final config = Loadable<AuthConfig>(
    fetch: ({required force}) => _auth.authConfig(),
    onChanged: notifyListeners,
  );

  bool _submitting = false;
  Failure? _failure;
  bool _blank = false;

  bool get submitting => _submitting;
  Failure? get failure => _failure;

  /// Submit was tried with no number.
  bool get blank => _blank;

  Future<void> load() => config.load();

  /// True once Premium is on and the session knows it.
  Future<bool> activate(PhoneNumber phone) async {
    if (_submitting) return false;
    _blank = phone.isBlank;
    _failure = null;
    if (_blank) {
      notifyListeners();
      return false;
    }
    _submitting = true;
    notifyListeners();
    final result = await runAction(
      'premium_activate',
      () => _trading.activatePremium(dialCode: phone.dialCode, number: phone.national.trim()),
    );
    switch (result) {
      case Success():
        await _session.refresh();
      // Already registered from another device: just catch up.
      case Err(failure: ValidationFailure(:final message))
          when message.toLowerCase().contains('already registered'):
        await _session.refresh();
      case Err(:final failure):
        _failure = failure;
    }
    _submitting = false;
    notifyListeners();
    return _session.signedIn?.user.premium.registered ?? false;
  }
}
