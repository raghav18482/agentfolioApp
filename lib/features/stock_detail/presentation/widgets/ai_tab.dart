import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/ai_markdown.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/responsible_ai_note.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/research/domain/entities/fundamentals.dart';
import 'package:agentfolio/features/stock_detail/presentation/view_models/stock_detail_view_model.dart';
import 'package:agentfolio/features/stock_detail/presentation/widgets/tab_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A plain-English reading of the stock's fundamentals, written by the
/// server's LLM: nothing for the user to set up. Loaded the first time this
/// tab is shown.
class AiTab extends StatelessWidget {
  const AiTab({super.key});

  @override
  Widget build(BuildContext context) =>
      const TabLayout(children: [(Pane.main, _SummaryCard()), (Pane.side, ResponsibleAiNote())]);
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<StockDetailViewModel>();
    final state = context.select<StockDetailViewModel, ViewState<AiSummary>>(
      (vm) => vm.summary.state,
    );

    return SectionCard(
      title: l10n.aiSummaryTitle,
      subtitle: l10n.aiSummarySubtitle,
      child: SectionState(
        state: state,
        retryTrackId: 'ai_summary_retry',
        unavailableHint: l10n.fundamentalsUnavailableHint,
        onRetry: () => unawaited(vm.summary.load()),
        skeleton: _Writing(symbol: Fmt.symbol(vm.symbol)),
        builder: (context, data) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedOpacity(
              // A regenerate in flight dims the old text instead of hiding it.
              opacity: state.isBusy ? 0.4 : 1,
              duration: const Duration(milliseconds: 200),
              child: AiMarkdown(data.markdown, linkTrackId: 'ai_summary_link'),
            ),
            if (state case ViewData(:final refreshFailure?)) ...[
              const SizedBox(height: AppSpace.md),
              Text(
                l10n.aiRegenerateFailed(refreshFailure.message),
                style: context.text.bodySmall?.copyWith(color: AppColors.warning),
              ),
            ],
            const SizedBox(height: AppSpace.lg),
            // Side by side when they fit, stacked at large text sizes.
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: AppSpace.md,
              runSpacing: AppSpace.sm,
              children: [
                Text(
                  data.cached ? l10n.aiRecentlyWritten : l10n.aiJustWritten,
                  style: context.text.labelMedium?.copyWith(color: AppColors.textMuted),
                ),
                _RegenerateButton(busy: state.isBusy),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Regenerate, or how long until it would produce anything new: the server
/// returns the same text within a minute of the last one.
class _RegenerateButton extends StatefulWidget {
  const _RegenerateButton({required this.busy});

  final bool busy;

  @override
  State<_RegenerateButton> createState() => _RegenerateButtonState();
}

class _RegenerateButtonState extends State<_RegenerateButton> {
  Timer? _ticker;

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<StockDetailViewModel>();
    final at = vm.regenerateAvailableAt;
    final wait = at?.difference(DateTime.now());
    final cooling = wait != null && wait > Duration.zero;

    // Tick once a second only while counting down.
    _ticker?.cancel();
    if (cooling) _ticker = Timer(const Duration(seconds: 1), () => setState(() {}));

    return AppButton(
      trackId: 'ai_summary_regenerate',
      label: cooling ? l10n.aiRegenerateIn(wait.inSeconds + 1) : l10n.aiRegenerate,
      icon: Icons.refresh_rounded,
      size: AppButtonSize.medium,
      variant: AppButtonVariant.secondary,
      loading: widget.busy,
      onPressed: cooling ? null : () => unawaited(vm.regenerateSummary()),
    );
  }
}

/// While the summary is written: a few lines of placeholder text and what
/// is happening, since it can take several seconds.
class _Writing extends StatelessWidget {
  const _Writing({required this.symbol});

  final String symbol;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        AppLocalizations.of(context).aiWriting(symbol),
        style: context.text.labelMedium?.copyWith(color: AppColors.brandSoft),
      ),
      const SizedBox(height: AppSpace.md),
      for (final w in const [1.0, 0.92, 0.97, 0.6, 0.0, 1.0, 0.85, 0.7])
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpace.sm),
          child: w == 0
              ? const SizedBox(height: AppSpace.sm)
              : FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: w,
                  child: const SkeletonBox(height: 12),
                ),
        ),
    ],
  );
}
