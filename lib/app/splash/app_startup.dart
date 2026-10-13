import 'dart:async';

import 'package:agentfolio/core/config/env.dart';
import 'package:agentfolio/core/storage/first_launch_guard.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/core/telemetry/telemetry_setup.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

enum StartupPhase {
  /// Working, and within the time a launch normally takes.
  running,

  /// Still working after [AppStartup.slowAfter]: say so, calmly.
  slow,

  /// Still working after [AppStartup.stalledAfter]: suggest checking the
  /// connection. The request keeps going; nothing is abandoned.
  stalled,

  /// Could not reach the server. Waiting for the user to retry.
  offline,

  /// Done. The router leaves the splash.
  ready,
}

/// Runs the launch work while the splash animates, and decides when the
/// splash may leave: only when the work is done **and** the intro animation
/// has played, so the brand moment is never cut off mid-stroke and never held
/// longer than the work needs.
class AppStartup extends ChangeNotifier {
  AppStartup({
    required this._env,
    required this._firstLaunchGuard,
    required this._session,
    required this._telemetry,
  });

  final Env _env;
  final FirstLaunchGuard _firstLaunchGuard;
  final SessionProvider _session;
  final Telemetry _telemetry;
  static final _log = Logger('Startup');

  static const slowAfter = Duration(seconds: 3);
  static const stalledAfter = Duration(seconds: 10);

  final _clock = Stopwatch();
  StartupPhase _phase = StartupPhase.running;
  bool _tasksDone = false;
  bool _introDone = false;
  bool _started = false;
  final List<Timer> _timers = [];

  StartupPhase get phase => _phase;
  bool get isReady => _phase == StartupPhase.ready;

  Future<void> start() async {
    if (_started) return;
    _started = true;
    _clock.start();
    _telemetry.track(const TelemetryEvent(EventName.appOpened));
    unawaited(_collectContext());

    try {
      await _firstLaunchGuard.run();
    } on Object catch (e, s) {
      // Never block launch on this. Worst case, a stale session is re-checked
      // with the server below anyway.
      _log.severe('First-launch cleanup failed', e, s);
    }
    await _restoreSession();
  }

  /// The splash calls this when its intro animation has finished, or at once
  /// when the OS asks for reduced motion.
  void introFinished() {
    _introDone = true;
    _maybeReady();
  }

  Future<void> retry() async {
    if (_phase != StartupPhase.offline) return;
    _setPhase(StartupPhase.running);
    await _restoreSession();
  }

  Future<void> _restoreSession() async {
    _cancelTimers();
    _timers.addAll([
      Timer(slowAfter, () {
        if (_phase == StartupPhase.running) _setPhase(StartupPhase.slow);
      }),
      Timer(stalledAfter, () {
        if (_phase == StartupPhase.slow) _setPhase(StartupPhase.stalled);
      }),
    ]);

    await _session.refresh();
    _cancelTimers();

    if (_session.status == SessionStatus.unreachable) {
      _setPhase(StartupPhase.offline);
      return;
    }
    _tasksDone = true;
    _maybeReady();
  }

  void _maybeReady() {
    if (!_tasksDone || !_introDone || _phase == StartupPhase.ready) return;
    _telemetry.track(
      TelemetryEvent(EventName.splashCompleted, {
        'duration_ms': _clock.elapsedMilliseconds,
        'signed_in': _session.isSignedIn,
      }),
    );
    _setPhase(StartupPhase.ready);
  }

  Future<void> _collectContext() async {
    try {
      _telemetry.setGlobalProperties(await collectTelemetryContext(_env));
    } on Object catch (e, s) {
      _log.warning('Could not collect device context', e, s);
    }
  }

  void _setPhase(StartupPhase phase) {
    if (_phase == phase) return;
    _phase = phase;
    notifyListeners();
  }

  void _cancelTimers() {
    for (final timer in _timers) {
      timer.cancel();
    }
    _timers.clear();
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }
}
