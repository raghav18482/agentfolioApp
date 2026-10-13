import 'dart:async';

import 'package:agentfolio/core/cache/request_cache.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/session/session_epoch.dart';
import 'package:agentfolio/core/session/session_expiry_signal.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/core/telemetry/user_hash.dart';
import 'package:agentfolio/features/accounts/domain/entities/broker_account.dart';
import 'package:agentfolio/features/auth/domain/entities/session.dart';
import 'package:agentfolio/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

enum SignOutReason { userChoice, accountDeleted }

enum SessionStatus {
  /// Not asked yet, or asking for the first time.
  unknown,
  signedIn,
  signedOut,

  /// The server could not be reached to ask. Only possible before the first
  /// answer; after that, a failed re-check keeps the last known state.
  unreachable,
}

/// Who is signed in: the single source of truth for routing, the account in
/// use, the premium gate and telemetry identity.
///
/// Session is server state. It is never assumed from a cookie on disk, always
/// asked of the server.
class SessionProvider extends ChangeNotifier {
  SessionProvider({
    required this._repository,
    required this._cache,
    required this._epoch,
    required this._telemetry,
    required SessionExpirySignal expirySignal,
  }) {
    _expirySub = expirySignal.stream.listen((_) => unawaited(_onExpired()));
  }

  final AuthRepository _repository;
  final RequestCache _cache;
  final SessionEpoch _epoch;
  final Telemetry _telemetry;
  late final StreamSubscription<void> _expirySub;
  static final _log = Logger('Session');

  Session? _session;
  SessionStatus _status = SessionStatus.unknown;
  Failure? _lastFailure;
  Future<void>? _inFlight;
  Future<void>? _expiryCheck;
  final List<Future<void> Function(String userId)> _signOutTasks = [];

  SessionStatus get status => _status;
  Session? get session => _session;
  Failure? get lastFailure => _lastFailure;

  SignedIn? get signedIn => switch (_session) {
    final SignedIn s => s,
    _ => null,
  };

  BrokerAccount? get activeAccount => signedIn?.activeAccount;

  bool get isSignedIn => _status == SessionStatus.signedIn;

  /// Ask the server who we are. Concurrent calls share one request, so a burst
  /// of expired-session 401s causes exactly one re-check.
  Future<void> refresh() => _inFlight ??= _refresh().whenComplete(() => _inFlight = null);

  /// Re-asks the server after a successful login or link, so the session
  /// (premium status, linked accounts) is exactly what the server holds.
  Future<bool> signedInNow() async {
    await refresh();
    if (isSignedIn) {
      _lastSignOut = null;
      _telemetry.track(const TelemetryEvent(EventName.loggedIn));
    }
    return isSignedIn;
  }

  /// Registers work for an explicit sign-out: wiping what a feature keeps on
  /// the device for the user (their OpenRouter key, chat drafts). Not run when
  /// a session merely expires, so an expired cookie does not cost the user
  /// their saved key.
  void onSignOut(Future<void> Function(String userId) task) => _signOutTasks.add(task);

  /// Signs out on the server and wipes everything this device held for the
  /// user: cookies, cached responses, telemetry identity, and whatever
  /// features registered with [onSignOut]. Never fails: if the server cannot
  /// be reached, the device is signed out anyway.
  Future<void> signOut() async {
    final userId = signedIn?.user.id;
    await _repository.logout();
    await _forgetOnDevice(userId);
    _lastSignOut = SignOutReason.userChoice;
    _telemetry.track(const TelemetryEvent(EventName.loggedOut));
    _apply(const Session.signedOut());
  }

  Future<void> _refresh() async {
    final result = await _repository.currentSession();
    switch (result) {
      case Success(:final value):
        _lastFailure = null;
        _apply(value);
      case Err(:final failure):
        _lastFailure = failure;
        _log.warning('Session check failed: ${failure.message}');
        if (_status == SessionStatus.unknown || _status == SessionStatus.unreachable) {
          _status = SessionStatus.unreachable;
          notifyListeners();
        }
    }
  }

  /// One check, and one `session_expired` event, per burst of 401s.
  Future<void> _onExpired() =>
      _expiryCheck ??= _checkExpired().whenComplete(() => _expiryCheck = null);

  Future<void> _checkExpired() async {
    if (!isSignedIn) return;
    await refresh();
    if (!isSignedIn) _telemetry.track(const TelemetryEvent(EventName.sessionExpired));
  }

  SignOutReason? _lastSignOut;

  /// Why the last sign-out happened, so Login can say so after an account
  /// was deleted.
  SignOutReason? get lastSignOut => _lastSignOut;

  /// Deletes the account on the server, then wipes this device exactly as
  /// signing out does. A wrong password leaves everything as it was.
  Future<Result<void>> deleteAccount(String appPassword) async {
    final userId = signedIn?.user.id;
    final result = await _repository.deleteAccount(appPassword);
    if (result is Success) {
      // The server already ended the session; this clears the cookies.
      await _repository.logout();
      await _forgetOnDevice(userId);
      _lastSignOut = SignOutReason.accountDeleted;
      _telemetry.track(const TelemetryEvent(EventName.accountDeleted));
      _apply(const Session.signedOut());
    }
    return result;
  }

  Future<void> _forgetOnDevice(String? userId) async {
    if (userId == null) return;
    for (final task in _signOutTasks) {
      try {
        await task(userId);
      } on Object catch (e, s) {
        // One feature failing to clean up must not keep the user signed in.
        _log.severe('Sign-out cleanup failed', e, s);
      }
    }
  }

  void _apply(Session next) {
    final previous = signedIn;
    final current = switch (next) {
      final SignedIn s => s,
      SignedOut() => null,
    };

    final identityChanged =
        previous?.user.id != current?.user.id ||
        previous?.activeAccountId != current?.activeAccountId;
    if (identityChanged) {
      // Everything cached or in flight belongs to the previous identity.
      _epoch.advance();
      _cache
        ..clear()
        ..scope = current?.activeAccountId ?? 'anon';
      if (current == null) {
        _telemetry.reset();
      } else {
        _identify(current);
      }
    }

    final wasKnown = _status != SessionStatus.unknown && _status != SessionStatus.unreachable;
    _session = next;
    _status = current == null ? SessionStatus.signedOut : SessionStatus.signedIn;
    if (!wasKnown && current != null) {
      _telemetry.track(const TelemetryEvent(EventName.sessionRestored));
    }
    notifyListeners();
  }

  void _identify(SignedIn session) {
    _telemetry
      ..identify(TelemetryUser(id: hashUserId(session.user.id)))
      ..setGlobalProperties({
        'broker_id': session.activeAccount.brokerId.value,
        'premium': session.user.premium.registered,
        'linked_accounts': session.accounts.length,
      });
  }

  @override
  void dispose() {
    unawaited(_expirySub.cancel());
    super.dispose();
  }
}
