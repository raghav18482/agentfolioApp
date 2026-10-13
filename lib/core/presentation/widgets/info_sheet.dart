import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// One explanation in an [showInfoSheet]: a heading and its text.
typedef InfoSection = ({String heading, String body});

/// Explains a metric in plain language, from a bottom sheet: what it is, what
/// good looks like, a tip. The mobile form of the web's ⓘ popovers.
Future<void> showInfoSheet(
  BuildContext context, {
  required String title,
  required String body,
  List<InfoSection> sections = const [],
}) => showModalBottomSheet<void>(
  context: context,
  useSafeArea: true,
  isScrollControlled: true,
  builder: (context) => SingleChildScrollView(
    padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.xl),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.text.titleLarge),
        const SizedBox(height: AppSpace.md),
        Text(body, style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary)),
        for (final section in sections) ...[
          const SizedBox(height: AppSpace.lg),
          Text(section.heading.toUpperCase(), style: context.text.labelSmall),
          const SizedBox(height: AppSpace.xs),
          Text(section.body, style: context.text.bodyMedium),
        ],
      ],
    ),
  ),
);
