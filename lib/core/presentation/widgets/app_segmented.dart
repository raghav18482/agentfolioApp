import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class AppSegment<T> {
  const AppSegment({required this.value, required this.label, required this.id});

  final T value;
  final String label;

  /// Reported to analytics as the selection, e.g. `holdings`.
  final String id;
}

/// A pill segmented control with a sliding thumb: Holdings / Positions /
/// Orders, News / Sectors, Finance / Trading.
class AppSegmented<T> extends StatelessWidget {
  const AppSegmented({
    required this.trackId,
    required this.segments,
    required this.selected,
    required this.onChanged,
    super.key,
  }) : assert(segments.length >= 2, 'A segmented control needs at least two segments');

  final String trackId;
  final List<AppSegment<T>> segments;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;
    final index = segments.indexWhere((s) => s.value == selected).clamp(0, segments.length - 1);
    final duration = AppMotion.of(context, AppMotion.medium);

    // The pill is drawn 44 high; the tap targets above it span the full 48
    // the accessibility guidelines ask for, so the look stays compact.
    return SizedBox(
      height: 48,
      child: Stack(
        children: [
          Center(
            child: Container(
              height: 44,
              padding: const EdgeInsets.all(4),
              decoration: ShapeDecoration(
                color: palette.surface,
                shape: StadiumBorder(side: BorderSide(color: palette.border)),
              ),
              child: AnimatedAlign(
                alignment: Alignment(-1 + 2 * index / (segments.length - 1), 0),
                duration: duration,
                curve: AppMotion.enter,
                child: FractionallySizedBox(
                  widthFactor: 1 / segments.length,
                  heightFactor: 1,
                  child: const DecoratedBox(
                    decoration: ShapeDecoration(
                      color: AppColors.surfaceHighest,
                      shape: StadiumBorder(side: BorderSide(color: AppColors.borderStrong)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                for (final segment in segments)
                  Expanded(
                    child: _SegmentButton(
                      label: segment.label,
                      selected: segment.value == selected,
                      duration: duration,
                      onTap: () {
                        if (segment.value == selected) return;
                        HapticFeedback.selectionClick().ignore();
                        context.trackChange(trackId, segment.id);
                        onChanged(segment.value);
                      },
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.duration,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final Duration duration;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = context.text.labelLarge!;
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: duration,
            style: style.copyWith(
              color: selected ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
            child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
        ),
      ),
    );
  }
}
