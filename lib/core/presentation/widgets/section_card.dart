import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/app_icon_button.dart';
import 'package:flutter/material.dart';

/// A titled card: one section of a screen, e.g. "P&L heatmap".
class SectionCard extends StatelessWidget {
  const SectionCard({
    required this.title,
    required this.child,
    super.key,
    this.subtitle,
    this.trailing,
    this.onInfo,
    this.infoTrackId,
    this.padding = const EdgeInsets.all(AppSpace.lg),
  });

  final String title;
  final String? subtitle;
  final Widget child;

  /// Right of the title: a count, a toggle, a "See all".
  final Widget? trailing;

  /// Shows an ⓘ beside the title that explains the section.
  final VoidCallback? onInfo;
  final String? infoTrackId;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) => AppCard(
    padding: padding,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(child: Text(title, style: context.text.titleMedium)),
                      if (onInfo != null)
                        SizedBox(
                          height: 32,
                          width: 32,
                          child: AppIconButton(
                            trackId: infoTrackId ?? 'section_info',
                            icon: Icons.info_outline_rounded,
                            tooltip: 'About $title',
                            color: AppColors.textMuted,
                            onPressed: onInfo,
                          ),
                        ),
                    ],
                  ),
                  if (subtitle != null) Text(subtitle!, style: context.text.bodySmall),
                ],
              ),
            ),
            ?trailing,
          ],
        ),
        const SizedBox(height: AppSpace.lg),
        child,
      ],
    ),
  );
}

/// A small label/value pair: "Available cash ₹12,400".
class StatTile extends StatelessWidget {
  const StatTile({required this.label, required this.value, super.key, this.icon});

  final String label;
  final Widget value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => AppCard(
    padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg, vertical: AppSpace.md),
    child: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18, color: AppColors.textMuted),
          const SizedBox(width: AppSpace.md),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: context.text.labelMedium),
              const SizedBox(height: 2),
              DefaultTextStyle.merge(style: context.text.titleMedium, child: value),
            ],
          ),
        ),
      ],
    ),
  );
}

/// A small coloured label: BUY, SELL, COMPLETE, DELIVERY.
class StatusChip extends StatelessWidget {
  const StatusChip(this.label, {super.key, this.color, this.icon});

  final String label;
  final Color? color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.palette.neutral;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: c.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[Icon(icon, size: 12, color: c), const SizedBox(width: 4)],
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.text.labelSmall?.copyWith(color: c, letterSpacing: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
