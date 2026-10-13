import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// An icon-only button. [tooltip] is required: it is also the screen-reader
/// label, and an unlabelled icon button is invisible to VoiceOver/TalkBack.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.trackId,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    super.key,
    this.color,
  });

  final String trackId;
  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) => IconButton(
    icon: Icon(icon),
    color: color,
    tooltip: tooltip,
    onPressed: onPressed == null
        ? null
        : () {
            context.trackTap(trackId);
            HapticFeedback.selectionClick().ignore();
            onPressed!();
          },
  );
}
