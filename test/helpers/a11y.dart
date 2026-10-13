import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Sets the system text size for this test (the app honours up to 2×).
void useLargeText(WidgetTester tester, [double scale = 2]) {
  tester.platformDispatcher.textScaleFactorTestValue = scale;
  addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);
}

/// Scrolls the screen's main list from top to bottom, failing on any layout
/// error (an overflow) along the way.
Future<void> scrollThrough(WidgetTester tester, {int steps = 14}) async {
  final scrollable = find.byType(Scrollable).first;
  for (var i = 0; i < steps; i++) {
    await tester.drag(scrollable, const Offset(0, -350), warnIfMissed: false);
    for (var f = 0; f < 4; f++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(tester.takeException(), isNull, reason: 'layout error after scroll step $i');
  }
}

/// Every tappable thing is big enough and has a label a screen reader can say.
Future<void> expectAccessibleTapTargets(WidgetTester tester) async {
  final handle = tester.ensureSemantics();
  await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
  await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
  await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
  handle.dispose();
}
