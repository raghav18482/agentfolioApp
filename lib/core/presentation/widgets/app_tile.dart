import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A tappable row: settings entries, menu items, list rows.
class AppTile extends StatelessWidget {
  const AppTile({
    required this.trackId,
    required this.title,
    required this.onTap,
    super.key,
    this.subtitle,
    this.icon,
    this.iconColor,
    this.trailing,
    this.destructive = false,
  });

  final String trackId;
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? iconColor;

  /// Defaults to a chevron when tappable.
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final titleColor = destructive ? AppColors.loss : AppColors.textPrimary;
    final accent = destructive ? AppColors.loss : (iconColor ?? AppColors.brandSoft);

    return InkWell(
      onTap: onTap == null
          ? null
          : () {
              context.trackTap(trackId);
              HapticFeedback.selectionClick().ignore();
              onTap!();
            },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 56),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg, vertical: AppSpace.md),
          child: Row(
            children: [
              if (icon != null) ...[
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: const BorderRadius.all(AppRadius.sm),
                  ),
                  child: Icon(icon, size: 20, color: accent),
                ),
                const SizedBox(width: AppSpace.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title, style: context.text.titleSmall?.copyWith(color: titleColor)),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(subtitle!, style: context.text.bodySmall),
                    ],
                  ],
                ),
              ),
              if (trailing != null)
                trailing!
              else if (onTap != null)
                const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

/// A row with a switch. The whole row toggles, not just the switch.
class AppSwitchTile extends StatelessWidget {
  const AppSwitchTile({
    required this.trackId,
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
    this.subtitle,
  });

  final String trackId;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;

  void _toggle(BuildContext context) {
    HapticFeedback.selectionClick().ignore();
    context.trackChange(trackId, value ? 'off' : 'on');
    onChanged?.call(!value);
  }

  @override
  Widget build(BuildContext context) => MergeSemantics(
    child: InkWell(
      onTap: onChanged == null ? null : () => _toggle(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg, vertical: AppSpace.sm),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title, style: context.text.titleSmall),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: context.text.bodySmall),
                  ],
                ],
              ),
            ),
            Switch.adaptive(
              value: value,
              onChanged: onChanged == null ? null : (_) => _toggle(context),
            ),
          ],
        ),
      ),
    ),
  );
}
