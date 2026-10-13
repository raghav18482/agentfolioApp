import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A button that acts only after being held down: the deliberate gesture
/// for an irreversible action on a device with no screen lock to confirm
/// with. Letting go early undoes the progress.
class HoldToConfirm extends StatefulWidget {
  const HoldToConfirm({
    required this.label,
    required this.onConfirmed,
    required this.trackId,
    super.key,
    this.hold = const Duration(milliseconds: 1500),
  });

  final String label;
  final VoidCallback? onConfirmed;
  final String trackId;
  final Duration hold;

  @override
  State<HoldToConfirm> createState() => _HoldToConfirmState();
}

class _HoldToConfirmState extends State<HoldToConfirm> with SingleTickerProviderStateMixin {
  late final _progress = AnimationController(vsync: this, duration: widget.hold)
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        HapticFeedback.heavyImpact().ignore();
        context.trackTap(widget.trackId);
        widget.onConfirmed?.call();
      }
    });

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  void _start() {
    if (widget.onConfirmed == null) return;
    HapticFeedback.selectionClick().ignore();
    _progress.forward().ignore();
  }

  void _stop() {
    if (_progress.isCompleted) return;
    _progress.reverse().ignore();
  }

  @override
  Widget build(BuildContext context) {
    final enabled = widget.onConfirmed != null;
    return Semantics(
      button: true,
      enabled: enabled,
      label: widget.label,
      // A screen reader cannot hold; its activation is deliberate already.
      onTap: enabled ? widget.onConfirmed : null,
      child: ExcludeSemantics(
        child: GestureDetector(
          onTapDown: (_) => _start(),
          onTapUp: (_) => _stop(),
          onTapCancel: _stop,
          child: ClipRRect(
            borderRadius: AppRadius.card,
            child: SizedBox(
              height: 52,
              child: AnimatedBuilder(
                animation: _progress,
                builder: (context, _) => Stack(
                  fit: StackFit.expand,
                  children: [
                    ColoredBox(
                      color: enabled
                          ? AppColors.loss.withValues(alpha: 0.18)
                          : AppColors.surfaceRaised,
                    ),
                    FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _progress.value,
                      child: const ColoredBox(color: AppColors.lossStrong),
                    ),
                    Center(
                      child: Text(
                        widget.label,
                        style: context.text.titleSmall?.copyWith(
                          color: enabled ? Colors.white : AppColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
