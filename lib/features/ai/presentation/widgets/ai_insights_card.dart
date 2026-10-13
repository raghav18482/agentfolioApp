import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/ai_markdown.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ai_insights_view_model.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ai_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A plain-English read of the whole portfolio, written with the user's own
/// OpenRouter key, on request.
class AiInsightsCard extends StatelessWidget {
  const AiInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<AiInsightsViewModel>();

    final Widget body;
    if (!vm.keyReady) {
      body = const SkeletonBox(width: double.infinity, height: 72);
    } else if (!vm.hasKey) {
      body = AiKeyNeeded(message: l10n.aiInsightsNeedKey, trackId: 'ai_insights_set_up');
    } else {
      body = switch (vm.state) {
        ViewIdle() => _Invite(model: vm.model),
        ViewLoading() => AiWriting(label: l10n.aiInsightsWriting),
        ViewError(:final failure) => AiFailureView(
          failure: failure,
          retryTrackId: 'ai_insights_retry',
          onRetry: () => unawaited(vm.generate()),
        ),
        ViewData(:final data, :final refreshing, :final refreshFailure) => _Insight(
          insight: data,
          refreshing: refreshing,
          refreshFailed: refreshFailure?.message,
        ),
      };
    }

    return SectionCard(
      title: l10n.aiInsightsTitle,
      subtitle: l10n.aiInsightsSubtitle,
      onInfo: () => showResponsibleAi(context),
      infoTrackId: 'ai_insights_info',
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        alignment: Alignment.topCenter,
        child: body,
      ),
    );
  }
}

class _Invite extends StatelessWidget {
  const _Invite({required this.model});

  final String model;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.aiInsightsInvite,
          style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary, height: 1.45),
        ),
        const SizedBox(height: AppSpace.lg),
        AppButton(
          trackId: 'ai_insights_generate',
          label: l10n.aiInsightsGenerate,
          icon: Icons.auto_awesome_rounded,
          onPressed: () => unawaited(context.read<AiInsightsViewModel>().generate()),
        ),
        const SizedBox(height: AppSpace.sm),
        AiMetaLine(l10n.aiUsesYourCredit(model)),
      ],
    );
  }
}

class _Insight extends StatelessWidget {
  const _Insight({required this.insight, required this.refreshing, this.refreshFailed});

  final Insight insight;
  final bool refreshing;
  final String? refreshFailed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedOpacity(
          // A regenerate in flight dims the old text instead of hiding it.
          opacity: refreshing ? 0.4 : 1,
          duration: const Duration(milliseconds: 200),
          child: AiMarkdown(insight.markdown, linkTrackId: 'ai_insights_link'),
        ),
        if (refreshFailed != null) ...[
          const SizedBox(height: AppSpace.md),
          Text(
            l10n.aiRegenerateFailed(refreshFailed!),
            style: context.text.bodySmall?.copyWith(color: AppColors.warning),
          ),
        ],
        const SizedBox(height: AppSpace.lg),
        Divider(height: 1, color: context.palette.border),
        const SizedBox(height: AppSpace.md),
        Row(
          children: [
            Expanded(
              child: AiMetaLine(l10n.aiWrittenBy(insight.model, Times.relative(insight.writtenAt))),
            ),
            const SizedBox(width: AppSpace.sm),
            AppButton(
              trackId: 'ai_insights_regenerate',
              label: l10n.aiRegenerate,
              icon: Icons.refresh_rounded,
              size: AppButtonSize.medium,
              variant: AppButtonVariant.secondary,
              loading: refreshing,
              onPressed: () => unawaited(context.read<AiInsightsViewModel>().generate()),
            ),
          ],
        ),
      ],
    );
  }
}
