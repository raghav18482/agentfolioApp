import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:flutter/widgets.dart';

/// Reports a screen view whenever a named route comes to the top, including
/// when a pop reveals the screen underneath. Unnamed routes (dialogs, sheets)
/// are ignored: they are part of the screen that opened them.
class TelemetryRouteObserver extends NavigatorObserver {
  TelemetryRouteObserver(this._telemetry);

  final Telemetry _telemetry;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) => _report(route);

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) => _report(newRoute);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) => _report(previousRoute);

  void _report(Route<dynamic>? route) {
    final name = route?.settings.name;
    if (route is PageRoute && name != null && name.isNotEmpty) _telemetry.screen(name);
  }
}
