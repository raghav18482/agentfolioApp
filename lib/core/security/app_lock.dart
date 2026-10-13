import 'dart:async';

import 'package:agentfolio/core/security/device_auth.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:flutter/foundation.dart';

enum UnlockResult { unlocked, stillLocked, lockRemoved }

enum EnableResult { enabled, cancelled, noScreenLock }

/// "Require Face ID to open Agentfolio": an optional second lock on a phone
/// someone else might pick up, since the session alone can approve trades.
///
/// Locks when a saved session is restored at launch, and when the app comes
/// back after `grace` in the background. Never right after signing in: the
/// password was just proven. Signing out turns it off.
class AppLock extends ChangeNotifier {
  AppLock({
    required this._prefs,
    required this._auth,
    required this._session,
    required this._telemetry,
    this._grace = const Duration(minutes: 1),
    DateTime Function()? clock,
  }) : _now = clock ?? DateTime.now {
    _session
      ..addListener(_onSession)
      ..onSignOut((_) => _disable());
    _onSession();
  }

  final Prefs _prefs;
  final DeviceAuth _auth;
  final SessionProvider _session;
  final Telemetry _telemetry;
  final Duration _grace;
  final DateTime Function() _now;

  bool _locked = false;
  bool _decidedAtLaunch = false;
  DateTime? _backgroundAt;
  bool _unlocking = false;

  bool get enabled => _prefs.appLockEnabled;
  bool get locked => _locked;
  bool get unlocking => _unlocking;

  void _onSession() {
    switch (_session.status) {
      case SessionStatus.unknown || SessionStatus.unreachable:
        return;
      case SessionStatus.signedOut:
        _decidedAtLaunch = true;
        _setLocked(false);
      case SessionStatus.signedIn:
        // The first answer at launch is a restored session: lock it. Later
        // sign-ins come from typing the password.
        if (!_decidedAtLaunch) {
          _decidedAtLaunch = true;
          if (enabled) _setLocked(true);
        }
    }
  }

  void onBackground() => _backgroundAt ??= _now();

  void onForeground() {
    final since = _backgroundAt;
    _backgroundAt = null;
    if (since == null || !enabled || !_session.isSignedIn) return;
    if (_now().difference(since) >= _grace) _setLocked(true);
  }

  Future<UnlockResult> unlock(String reason) async {
    if (!_locked) return UnlockResult.unlocked;
    if (_unlocking) return UnlockResult.stillLocked;
    _unlocking = true;
    notifyListeners();
    final result = await _auth.confirm(reason);
    _unlocking = false;
    switch (result) {
      case DeviceAuthResult.confirmed:
        _setLocked(false);
        return UnlockResult.unlocked;
      case DeviceAuthResult.unavailable:
        // The phone's own lock was removed: nothing to unlock with. Turn the
        // app lock off rather than lock the user out of their own app.
        await _disable();
        _setLocked(false);
        return UnlockResult.lockRemoved;
      case DeviceAuthResult.cancelled || DeviceAuthResult.failed:
        notifyListeners();
        return UnlockResult.stillLocked;
    }
  }

  /// Turning it on proves the phone can unlock it, so nobody locks
  /// themselves out on a device with no screen lock.
  Future<EnableResult> setEnabled({required bool enabled, required String reason}) async {
    if (!enabled) {
      await _disable();
      return EnableResult.cancelled;
    }
    final result = await _auth.confirm(reason);
    switch (result) {
      case DeviceAuthResult.confirmed:
        await _prefs.setAppLockEnabled(enabled: true);
        _telemetry.track(
          const TelemetryEvent(EventName.actionSucceeded, {'action': 'app_lock_on'}),
        );
        notifyListeners();
        return EnableResult.enabled;
      case DeviceAuthResult.unavailable:
        return EnableResult.noScreenLock;
      case DeviceAuthResult.cancelled || DeviceAuthResult.failed:
        return EnableResult.cancelled;
    }
  }

  Future<void> _disable() async {
    if (!_prefs.appLockEnabled) return;
    await _prefs.setAppLockEnabled(enabled: false);
    notifyListeners();
  }

  void _setLocked(bool value) {
    if (_locked == value) return;
    _locked = value;
    notifyListeners();
  }

  @override
  void dispose() {
    _session.removeListener(_onSession);
    super.dispose();
  }
}
