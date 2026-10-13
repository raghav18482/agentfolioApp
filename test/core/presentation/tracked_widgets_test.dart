import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_segmented.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../../helpers/recording_sink.dart';

/// Interactions are captured by the design system itself, so features get
/// analytics without writing any. These tests hold that promise.
void main() {
  late Telemetry telemetry;
  late RecordingSink sink;

  setUp(() async => (telemetry, sink) = await recordingTelemetry());

  Widget wrap(Widget child) => Provider<Telemetry>.value(
    value: telemetry,
    child: MaterialApp(
      theme: AppTheme.dark(),
      home: Scaffold(body: Center(child: child)),
    ),
  );

  testWidgets('AppButton reports its tap and runs its action', (tester) async {
    var pressed = 0;
    await tester.pumpWidget(
      wrap(AppButton(trackId: 'login_submit', label: 'Log in', onPressed: () => pressed++)),
    );
    await tester.tap(find.text('Log in'));

    expect(pressed, 1);
    final tap = sink.named(EventName.uiTapped).single;
    expect(tap.properties['track_id'], 'login_submit');
  });

  testWidgets('a loading AppButton ignores taps, so actions cannot double-fire', (tester) async {
    var pressed = 0;
    await tester.pumpWidget(
      wrap(
        AppButton(trackId: 'approve', label: 'Approve', loading: true, onPressed: () => pressed++),
      ),
    );
    await tester.tap(find.byType(AppButton));
    expect(pressed, 0);
    expect(sink.events, isEmpty);
  });

  testWidgets('AppSegmented reports the selection id, not the label', (tester) async {
    var selected = 'holdings';
    await tester.pumpWidget(
      wrap(
        StatefulBuilder(
          builder: (context, setState) => SizedBox(
            width: 320,
            child: AppSegmented<String>(
              trackId: 'portfolio_view',
              selected: selected,
              onChanged: (v) => setState(() => selected = v),
              segments: const [
                AppSegment(value: 'holdings', label: 'Holdings', id: 'holdings'),
                AppSegment(value: 'orders', label: 'Orders', id: 'orders'),
              ],
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Orders'));
    await tester.pumpAndSettle();

    expect(selected, 'orders');
    final change = sink.named(EventName.uiChanged).single;
    expect(change.properties['track_id'], 'portfolio_view');
    expect(change.properties['selection'], 'orders');
  });
}
