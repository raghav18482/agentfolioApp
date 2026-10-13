import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:flutter/material.dart';

/// A surface for one block of content. Tappable when [onTap] is given, in
/// which case [trackId] is required and the card presses down slightly.
class AppCard extends StatefulWidget {
  const AppCard({
    required this.child,
    super.key,
    this.padding = const EdgeInsets.all(AppSpace.lg),
    this.onTap,
    this.trackId,
    this.color,
  }) : assert(onTap == null || trackId != null, 'A tappable card needs a trackId');

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final String? trackId;
  final Color? color;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final card = Material(
      color: widget.color ?? palette.surface,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.card,
        side: BorderSide(color: palette.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: widget.onTap == null
          ? Padding(padding: widget.padding, child: widget.child)
          : InkWell(
              onTap: () {
                context.trackTap(widget.trackId!);
                widget.onTap!();
              },
              onHighlightChanged: (pressed) => setState(() => _pressed = pressed),
              child: Padding(padding: widget.padding, child: widget.child),
            ),
    );
    if (widget.onTap == null) return card;
    return AnimatedScale(
      scale: _pressed ? 0.985 : 1,
      duration: AppMotion.of(context, const Duration(milliseconds: 120)),
      child: card,
    );
  }
}
