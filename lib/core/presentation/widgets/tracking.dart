import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/core/telemetry/telemetry_event.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

/// How design-system widgets report interactions. Feature code does not call
/// these: it passes a `trackId` to `AppButton`, `AppTile`, `AppSegmented`…
/// and they report for it.
extension InteractionTracking on BuildContext {
  void trackTap(String trackId) => read<Telemetry>().track(TelemetryEvent.tap(trackId));

  void trackChange(String trackId, String selection) =>
      read<Telemetry>().track(TelemetryEvent.change(trackId, selection));
}
