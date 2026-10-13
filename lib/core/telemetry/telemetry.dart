import 'dart:async';
import 'dart:collection';
import 'dart:developer' as developer;

import 'package:agentfolio/core/telemetry/redactor.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:agentfolio/core/telemetry/telemetry_sink.dart';

/// The one door telemetry goes through.
///
/// Feature code never talks to Crashlytics or an analytics SDK directly. It
/// calls this, and this fans out to every sink listed in
/// `telemetry_setup.dart`. Adding a destination therefore touches one line.
///
/// Guarantees:
/// * everything is redacted once, here, before any sink sees it;
/// * a throwing sink is isolated and never reaches the caller;
/// * calls made before [init] are buffered, then replayed in order;
/// * the analytics opt-out silences analytics sinks but keeps crash reports.
class Telemetry {
  Telemetry({required List<TelemetrySink> sinks, this.redactor = const Redactor()})
    : _sinks = List.unmodifiable(sinks);

  final List<TelemetrySink> _sinks;
  final Redactor redactor;

  static const _bufferLimit = 200;
  final Queue<void Function()> _buffer = Queue();
  bool _ready = false;
  String? _currentScreen;

  String? get currentScreen => _currentScreen;

  /// The user's "Share usage analytics" choice. Off silences analytics sinks;
  /// crash reporting continues.
  bool analyticsEnabled = true;

  Future<void> init() async {
    await Future.wait(
      _sinks.map(
        (sink) => sink.init().catchError((Object e, StackTrace s) => _sinkFailed(sink, e, s)),
      ),
    );
    _ready = true;
    while (_buffer.isNotEmpty) {
      _buffer.removeFirst()();
    }
  }

  /// Records [event], tagged with the screen it happened on.
  void track(TelemetryEvent event) {
    final scrubbed = TelemetryEvent(
      event.name,
      redactor.properties({'screen': ?_currentScreen, ...event.properties}),
    );
    _dispatch((sink) => sink.track(scrubbed), analytics: true);
  }

  /// A screen became visible. Repeats of the current screen are dropped, so
  /// the router observer and the tab bar can both report without double counting.
  void screen(String name) {
    if (name == _currentScreen) return;
    final previous = _currentScreen;
    _currentScreen = name;
    _dispatch((sink) => sink.screen(name, previous: previous), analytics: true);
  }

  void breadcrumb(String message, {Map<String, Object?> data = const {}}) {
    final text = redactor.text(message);
    final props = redactor.properties(data);
    _dispatch((sink) => sink.breadcrumb(text, data: props));
  }

  void error(
    Object error,
    StackTrace? stack, {
    bool fatal = false,
    String? reason,
    Map<String, Object?> context = const {},
  }) {
    final props = redactor.properties({'screen': _currentScreen, ...context});
    _dispatch(
      (sink) => sink.recordError(error, stack, fatal: fatal, reason: reason, context: props),
    );
  }

  void identify(TelemetryUser user) {
    final scrubbed = TelemetryUser(id: user.id, traits: redactor.properties(user.traits));
    _dispatch((sink) => sink.identify(scrubbed));
  }

  void setGlobalProperties(Map<String, Object?> properties) {
    final props = redactor.properties(properties);
    _dispatch((sink) => sink.setGlobalProperties(props));
  }

  void reset() {
    _currentScreen = null;
    _dispatch((sink) => sink.reset());
  }

  void _dispatch(void Function(TelemetrySink sink) call, {bool analytics = false}) {
    void run() {
      for (final sink in _sinks) {
        if (analytics && sink.isAnalytics && !analyticsEnabled) continue;
        try {
          call(sink);
        } on Object catch (e, s) {
          _sinkFailed(sink, e, s);
        }
      }
    }

    if (_ready) {
      run();
    } else {
      if (_buffer.length >= _bufferLimit) _buffer.removeFirst();
      _buffer.add(run);
    }
  }

  // Telemetry must never take the app down, and reporting a sink failure
  // through the sinks could loop, so failures only reach the debug log.
  void _sinkFailed(TelemetrySink sink, Object error, StackTrace stack) {
    developer.log(
      'Telemetry sink "${sink.name}" failed',
      name: 'telemetry',
      error: error,
      stackTrace: stack,
    );
  }
}
