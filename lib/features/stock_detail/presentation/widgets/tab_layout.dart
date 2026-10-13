import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/fade_slide_in.dart';
import 'package:flutter/material.dart';

/// Which column a card takes on a wide screen.
enum Pane { main, side }

/// A tab's cards: one column on a phone, in the given order; two columns on
/// a tablet, charts in the wider main column and figures beside them.
class TabLayout extends StatelessWidget {
  const TabLayout({required this.children, super.key});

  final List<(Pane, Widget)> children;

  static const _wide = 720.0;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final staggered = [
        for (var i = 0; i < children.length; i++)
          (
            children[i].$1,
            FadeSlideIn(
              delay: Duration(milliseconds: 60 * i),
              child: children[i].$2,
            ),
          ),
      ];
      if (constraints.maxWidth < _wide) {
        return _column([for (final (_, w) in staggered) w]);
      }
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _column([
              for (final (p, w) in staggered)
                if (p == Pane.main) w,
            ]),
          ),
          const SizedBox(width: AppSpace.lg),
          Expanded(
            flex: 2,
            child: _column([
              for (final (p, w) in staggered)
                if (p == Pane.side) w,
            ]),
          ),
        ],
      );
    },
  );

  Widget _column(List<Widget> cards) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      for (var i = 0; i < cards.length; i++) ...[
        if (i > 0) const SizedBox(height: AppSpace.lg),
        cards[i],
      ],
    ],
  );
}
