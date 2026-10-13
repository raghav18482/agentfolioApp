import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/error/failure.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/info_sheet.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Opens AI settings, above the tabs.
void openAiSettings(BuildContext context) => unawaited(context.push(Routes.aiSettings));

/// The Responsible AI statement in a sheet, from an ⓘ beside AI output.
void showResponsibleAi(BuildContext context) => unawaited(
  showInfoSheet(
    context,
    title: Disclaimers.responsibleAiEyebrow,
    body: Disclaimers.responsibleAiFineprint,
  ),
);

/// A failed AI request. When the key itself was refused, the way out is
/// AI settings, not Retry.
class AiFailureView extends StatelessWidget {
  const AiFailureView({
    required this.failure,
    required this.onRetry,
    required this.retryTrackId,
    super.key,
  });

  final Failure failure;
  final VoidCallback onRetry;
  final String retryTrackId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final keyProblem = AiKeyRules.isKeyFailure(failure);
    return AppAlert(
      message: failure.message,
      variant: failure is NetworkFailure || failure is TimeoutFailure
          ? AppAlertVariant.warning
          : AppAlertVariant.error,
      action: keyProblem
          ? AppButton(
              trackId: '${retryTrackId}_check_key',
              label: l10n.aiCheckKey,
              icon: Icons.key_rounded,
              size: AppButtonSize.medium,
              variant: AppButtonVariant.secondary,
              onPressed: () => openAiSettings(context),
            )
          : AppButton(
              trackId: retryTrackId,
              label: l10n.commonRetry,
              icon: Icons.refresh_rounded,
              size: AppButtonSize.medium,
              variant: AppButtonVariant.secondary,
              onPressed: onRetry,
            ),
    );
  }
}

/// Shown where an AI feature needs the user's key and there is none yet.
class AiKeyNeeded extends StatelessWidget {
  const AiKeyNeeded({required this.message, required this.trackId, super.key});

  final String message;
  final String trackId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.brandSoft.withValues(alpha: 0.12),
            borderRadius: AppRadius.card,
          ),
          child: const Icon(Icons.key_rounded, color: AppColors.brandSoft, size: 20),
        ),
        const SizedBox(width: AppSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message, style: context.text.bodyMedium?.copyWith(height: 1.45)),
              const SizedBox(height: AppSpace.md),
              AppButton(
                trackId: trackId,
                label: l10n.aiSetUp,
                icon: Icons.arrow_forward_rounded,
                size: AppButtonSize.medium,
                variant: AppButtonVariant.secondary,
                onPressed: () => openAiSettings(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Placeholder lines while a model writes, with what is happening.
class AiWriting extends StatelessWidget {
  const AiWriting({required this.label, super.key, this.lines = 6});

  final String label;
  final int lines;

  static const _widths = [1.0, 0.92, 0.97, 0.6, 0.88, 0.75, 0.95, 0.5];

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: context.text.labelMedium?.copyWith(color: AppColors.brandSoft)),
      const SizedBox(height: AppSpace.md),
      Shimmer(
        child: Column(
          children: [
            for (var i = 0; i < lines; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpace.sm),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _widths[i % _widths.length],
                  child: const SkeletonBox(height: 12),
                ),
              ),
          ],
        ),
      ),
    ],
  );
}

/// "Written by openai/gpt-4o-mini · 5m ago"-style footers.
class AiMetaLine extends StatelessWidget {
  const AiMetaLine(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: context.text.labelMedium?.copyWith(color: context.palette.textMuted),
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
  );
}
