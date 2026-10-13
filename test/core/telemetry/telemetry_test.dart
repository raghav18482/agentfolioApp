import 'package:agentfolio/core/telemetry/redactor.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/recording_sink.dart';

void main() {
  test('fans every call out to every sink', () async {
    final a = RecordingSink();
    final b = RecordingSink();
    final telemetry = Telemetry(sinks: [a, b]);
    await telemetry.init();

    telemetry
      ..track(TelemetryEvent.tap('login_submit'))
      ..screen('home')
      ..breadcrumb('hello')
      ..error(StateError('x'), StackTrace.empty);

    for (final sink in [a, b]) {
      expect(sink.events.single.properties['track_id'], 'login_submit');
      expect(sink.screens, ['home']);
      expect(sink.breadcrumbs, ['hello']);
      expect(sink.errors, hasLength(1));
    }
  });

  test('buffers calls made before init and replays them in order', () async {
    final sink = RecordingSink();
    final telemetry = Telemetry(sinks: [sink])
      ..track(const TelemetryEvent('first'))
      ..track(const TelemetryEvent('second'));
    expect(sink.events, isEmpty);

    await telemetry.init();
    expect(sink.events.map((e) => e.name), ['first', 'second']);
  });

  test('a throwing sink does not stop the others or reach the caller', () async {
    final broken = RecordingSink(throwOnTrack: true);
    final healthy = RecordingSink();
    final telemetry = Telemetry(sinks: [broken, healthy]);
    await telemetry.init();

    expect(() => telemetry.track(const TelemetryEvent('e')), returnsNormally);
    expect(healthy.events, hasLength(1));
  });

  test('redacts before any sink sees the data', () async {
    final (telemetry, sink) = await recordingTelemetry();
    telemetry.track(const TelemetryEvent('login', {'app_password': 'hunter2', 'step': 'otp'}));
    final props = sink.events.single.properties;
    expect(props['app_password'], Redactor.redacted);
    expect(props['step'], 'otp');
  });

  test('tags events with the current screen', () async {
    final (telemetry, sink) = await recordingTelemetry();
    telemetry
      ..screen('portfolio')
      ..track(TelemetryEvent.tap('sort'));
    expect(sink.events.single.properties['screen'], 'portfolio');
  });

  test('repeated reports of the same screen count once', () async {
    final (telemetry, sink) = await recordingTelemetry();
    telemetry
      ..screen('home')
      ..screen('home')
      ..screen('markets');
    expect(sink.screens, ['home', 'markets']);
  });

  test('the analytics opt-out silences analytics sinks but keeps crash reports', () async {
    final analytics = RecordingSink(analytics: true);
    final crashes = RecordingSink();
    final telemetry = Telemetry(sinks: [analytics, crashes]);
    await telemetry.init();
    telemetry
      ..analyticsEnabled = false
      ..track(const TelemetryEvent('tap'))
      ..screen('home')
      ..error(StateError('crash'), StackTrace.empty);

    expect(analytics.events, isEmpty);
    expect(analytics.screens, isEmpty);
    expect(analytics.errors, hasLength(1));
    expect(crashes.events, hasLength(1));
  });
}
