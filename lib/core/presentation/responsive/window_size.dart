import 'package:flutter/widgets.dart';

/// Material 3 window size classes.
///
/// * compact (< 600): phones in portrait, bottom navigation, one pane;
/// * medium (600–839): large phones in landscape, small tablets, nav rail;
/// * expanded (≥ 840): tablets, nav rail and two panes, close to the web layout.
enum WindowSize {
  compact,
  medium,
  expanded;

  static WindowSize of(BuildContext context) => fromWidth(MediaQuery.sizeOf(context).width);

  static WindowSize fromWidth(double width) => switch (width) {
    < 600 => compact,
    < 840 => medium,
    _ => expanded,
  };

  bool get usesRail => this != compact;
  bool get twoPane => this == expanded;
}
