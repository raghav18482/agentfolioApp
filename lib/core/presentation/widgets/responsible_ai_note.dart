import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// The Responsible AI statement, verbatim, alongside AI output.
class ResponsibleAiNote extends StatelessWidget {
  const ResponsibleAiNote({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpace.lg),
    decoration: BoxDecoration(
      borderRadius: AppRadius.card,
      border: Border.all(color: context.palette.border),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.shield_outlined, size: 18, color: AppColors.textMuted),
        const SizedBox(width: AppSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Disclaimers.responsibleAiEyebrow.toUpperCase(), style: context.text.labelSmall),
              const SizedBox(height: AppSpace.xs),
              Text(
                Disclaimers.responsibleAiFineprint,
                style: context.text.bodySmall?.copyWith(height: 1.5),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
