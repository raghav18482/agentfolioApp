import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:logging/logging.dart';

/// How a request to confirm "it's really you" ended.
enum DeviceAuthResult {
  /// Face, fingerprint, or the device passcode.
  confirmed,

  /// The user backed out. Not an error.
  cancelled,

  /// This device has no screen lock at all, so there is nothing to confirm
  /// with. The caller falls back to an explicit hold-to-confirm.
  unavailable,

  /// Locked out after too many attempts, or a platform failure.
  failed,
}

/// Confirms the person holding the phone is its owner, before something that
/// cannot be undone, like placing an order.
abstract interface class DeviceAuth {
  Future<DeviceAuthResult> confirm(String reason);
}

/// Biometrics with the device passcode as fallback, never biometrics alone:
/// someone whose face is not recognised can still use their PIN.
class LocalDeviceAuth implements DeviceAuth {
  LocalDeviceAuth([LocalAuthentication? auth]) : _auth = auth ?? LocalAuthentication();

  final LocalAuthentication _auth;
  static final _log = Logger('DeviceAuth');

  @override
  Future<DeviceAuthResult> confirm(String reason) async {
    try {
      if (!await _auth.isDeviceSupported()) return DeviceAuthResult.unavailable;
      final ok = await _auth.authenticate(localizedReason: reason);
      return ok ? DeviceAuthResult.confirmed : DeviceAuthResult.cancelled;
    } on LocalAuthException catch (e) {
      return switch (e.code) {
        LocalAuthExceptionCode.userCanceled ||
        LocalAuthExceptionCode.systemCanceled ||
        LocalAuthExceptionCode.timeout ||
        LocalAuthExceptionCode.userRequestedFallback => DeviceAuthResult.cancelled,
        LocalAuthExceptionCode.noCredentialsSet ||
        LocalAuthExceptionCode.noBiometricHardware => DeviceAuthResult.unavailable,
        _ => _failed(e),
      };
    } on PlatformException catch (e) {
      return _failed(e);
    }
  }

  DeviceAuthResult _failed(Object e) {
    _log.warning('Device authentication failed: $e');
    return DeviceAuthResult.failed;
  }
}
