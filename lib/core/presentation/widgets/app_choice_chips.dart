import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_segmented.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A row of small pill choices, one selected: a period (Today / 7D / 1M),
/// a filter. Lighter than [AppSegmented], for a secondary choice under it.
/// Each change is reported under [trackId].
class AppChoiceChips<T> extends StatelessWidget {
  const AppChoiceChips({
    required this.trackId,
    required this.options,
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final String trackId;
  final List<AppSegment<T>> options;
  final T selected;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final duration = AppMotion.of(context, AppMotion.short);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final option in options) ...[
            Semantics(
              button: true,
              selected: option.value == selected,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  if (option.value == selected) return;
                  HapticFeedback.selectionClick().ignore();
                  context.trackChange(trackId, option.id);
                  onChanged(option.value);
                },
                // Padding keeps the touch target at 40pt tall.
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: AnimatedContainer(
                    duration: duration,
                    curve: AppMotion.standard,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: ShapeDecoration(
                      color: option.value == selected
                          ? AppColors.brandBright.withValues(alpha: 0.18)
                          : context.palette.surface,
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: option.value == selected
                              ? AppColors.brandBright.withValues(alpha: 0.6)
                              : context.palette.border,
                        ),
                      ),
                    ),
                    child: Text(
                      option.label,
                      style: context.text.labelLarge?.copyWith(
                        color: option.value == selected
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                        fontWeight: option.value == selected ? FontWeight.w600 : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpace.sm),
          ],
        ],
      ),
    );
  }
}
