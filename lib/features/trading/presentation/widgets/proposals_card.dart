import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/time/server_clock.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/domain/trading_logic.dart';
import 'package:agentfolio/features/trading/presentation/view_models/trade_view_model.dart';
import 'package:agentfolio/features/trading/presentation/widgets/trade_approval.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// The agent's trade proposals: pending ones first, with what each would do
/// and how long it has left, then what became of the rest.
class ProposalsCard extends StatelessWidget {
  const ProposalsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<TradeViewModel>();
    final pending = vm.pendingCount;

    return SectionCard(
      title: l10n.proposalsTitle,
      subtitle: l10n.proposalsSubtitle,
      trailing: pending == 0
          ? null
          : StatusChip(l10n.proposalsPending(pending), color: AppColors.warning),
      child: SectionState(
        state: vm.proposals.state,
        retryTrackId: 'proposals_retry',
        onRetry: () => unawaited(vm.proposals.load(force: true)),
        skeletonHeight: 120,
        builder: (context, proposals) => proposals.isEmpty
            ? const _NoProposals()
            : Column(
                children: [
                  for (final (i, p) in proposals.indexed) ...[
                    if (i > 0) Divider(height: AppSpace.xl, color: context.palette.border),
                    ProposalTile(key: ValueKey(p.id), proposal: p),
                  ],
                ],
              ),
      ),
    );
  }
}

class _NoProposals extends StatelessWidget {
  const _NoProposals();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.proposalsNone,
          style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary, height: 1.45),
        ),
        const SizedBox(height: AppSpace.md),
        AppButton(
          trackId: 'proposals_chat',
          label: l10n.proposalsChat,
          icon: Icons.forum_outlined,
          variant: AppButtonVariant.secondary,
          onPressed: () => context.go(Routes.agentWith(trading: true)),
        ),
      ],
    );
  }
}

class ProposalTile extends StatefulWidget {
  const ProposalTile({required this.proposal, super.key});

  final TradeProposal proposal;

  @override
  State<ProposalTile> createState() => _ProposalTileState();
}

class _ProposalTileState extends State<ProposalTile> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _syncTicker();
  }

  @override
  void didUpdateWidget(ProposalTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncTicker();
  }

  /// A countdown ticks only while there is one to show.
  void _syncTicker() {
    if (widget.proposal.isPending) {
      _ticker ??= Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
    } else {
      _ticker?.cancel();
      _ticker = null;
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _approve() async {
    final vm = context.read<TradeViewModel>();
    final p = widget.proposal;
    final confirmed = await confirmTradeApproval(context, proposalId: p.id, proposal: p);
    if (!confirmed || !mounted) return;
    final outcome = await vm.approve(p.id);
    switch (outcome) {
      case OrderPlaced():
        HapticFeedback.heavyImpact().ignore();
      case OrderNotPlaced() || OutcomeUnconfirmed():
        HapticFeedback.vibrate().ignore();
      case _:
        break;
    }
  }

  Future<void> _reject() async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final result = await context.read<TradeViewModel>().reject(widget.proposal.id);
    messenger.showSnackBar(
      SnackBar(
        content: Text(switch (result) {
          Success() => l10n.proposalRejected,
          Err(:final failure) => failure.message,
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<TradeViewModel>();
    final p = widget.proposal;
    final approving = vm.isApproving(p.id);
    final rejecting = vm.isRejecting(p.id);
    final left = timeLeft(p, context.read<ServerClock>().now());
    // Pending on the server but past its time here: offer nothing.
    final actionable = p.isPending && left > Duration.zero;

    final tile = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: OrderHeadline(order: p.order, compact: true)),
            const SizedBox(width: AppSpace.sm),
            _StatusChip(status: p.isPending && !actionable ? ProposalStatus.expired : p.status),
          ],
        ),
        const SizedBox(height: AppSpace.xs),
        Text(
          [
            if (p.order.price == null) l10n.orderMarket else Fmt.money(p.order.price),
            if (p.order.product.isNotEmpty) p.order.product,
            p.order.exchange,
          ].join(' · '),
          style: context.text.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpace.xs),
        Wrap(
          spacing: AppSpace.md,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            _CopyId(id: p.id),
            Text(
              actionable
                  ? l10n.proposalExpiresIn(formatCountdown(left))
                  : Times.relative(p.createdAt),
              style: context.text.labelMedium?.copyWith(
                color: actionable && left.inSeconds < 60
                    ? AppColors.warning
                    : context.palette.textMuted,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
        if (p.orderId != null) ...[
          const SizedBox(height: AppSpace.xs),
          Text(
            l10n.proposalOrderId(p.orderId!),
            style: context.text.bodySmall?.copyWith(color: AppColors.gain),
          ),
        ],
        if (p.error != null) ...[
          const SizedBox(height: AppSpace.xs),
          Text(p.error!, style: context.text.bodySmall?.copyWith(color: AppColors.loss)),
        ],
        if (vm.outcomeFor(p.id) case final outcome?) ...[
          const SizedBox(height: AppSpace.md),
          _OutcomeNote(outcome: outcome),
        ],
        if (actionable) ...[
          const SizedBox(height: AppSpace.md),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  trackId: 'proposal_approve',
                  label: l10n.proposalApprove,
                  icon: Icons.check_rounded,
                  size: AppButtonSize.medium,
                  loading: approving,
                  onPressed: approving || rejecting ? null : () => unawaited(_approve()),
                ),
              ),
              const SizedBox(width: AppSpace.md),
              Expanded(
                child: AppButton(
                  trackId: 'proposal_reject',
                  label: l10n.proposalReject,
                  icon: Icons.close_rounded,
                  size: AppButtonSize.medium,
                  variant: AppButtonVariant.secondary,
                  loading: rejecting,
                  onPressed: approving || rejecting ? null : () => unawaited(_reject()),
                ),
              ),
            ],
          ),
        ],
      ],
    );

    if (!actionable || approving) return tile;
    // Swiping can only reject: approval always goes through confirmation.
    return Dismissible(
      key: ValueKey('reject_${p.id}'),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        context.trackTap('proposal_swipe_reject');
        await _reject();
        return false; // the refreshed list redraws it as rejected
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpace.lg),
        color: AppColors.loss.withValues(alpha: 0.15),
        child: Text(
          l10n.proposalReject,
          style: context.text.labelLarge?.copyWith(color: AppColors.loss),
        ),
      ),
      child: tile,
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status});

  final ProposalStatus status;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (label, color) = switch (status) {
      ProposalStatus.pending => (l10n.statusPending, AppColors.warning),
      ProposalStatus.approved => (l10n.statusApproved, AppColors.sky),
      ProposalStatus.executed => (l10n.statusExecuted, AppColors.gain),
      ProposalStatus.failed => (l10n.statusFailed, AppColors.loss),
      ProposalStatus.rejected => (l10n.statusRejected, AppColors.textMuted),
      ProposalStatus.expired => (l10n.statusExpired, AppColors.textMuted),
      ProposalStatus.unknown => (l10n.statusUnknown, AppColors.textMuted),
    };
    return StatusChip(label.toUpperCase(), color: color);
  }
}

/// The id `APPROVE <id>` in the chat expects, so it can be copied.
class _CopyId extends StatelessWidget {
  const _CopyId({required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(6),
      onTap: () {
        context.trackTap('proposal_copy_id');
        unawaited(Clipboard.setData(ClipboardData(text: id)));
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(l10n.proposalIdCopied)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              id,
              style: context.text.labelMedium?.copyWith(
                fontFamily: 'monospace',
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.copy_rounded, size: 12, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }
}

/// What happened when this proposal was approved here, in plain words.
class _OutcomeNote extends StatelessWidget {
  const _OutcomeNote({required this.outcome});

  final ApprovalOutcome outcome;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (variant, title, message, toOrders) = switch (outcome) {
      OrderPlaced(:final orderId) => (
        AppAlertVariant.success,
        l10n.outcomePlaced,
        orderId == null ? l10n.outcomePlacedBody : l10n.proposalOrderId(orderId),
        false,
      ),
      OrderNotPlaced(:final reason) => (
        AppAlertVariant.error,
        l10n.outcomeNotPlaced,
        reason,
        false,
      ),
      ApprovalNotReceived() => (
        AppAlertVariant.warning,
        l10n.outcomeNotReceived,
        l10n.outcomeNotReceivedBody,
        false,
      ),
      OrderInProgress() => (
        AppAlertVariant.info,
        l10n.outcomeInProgress,
        l10n.outcomeInProgressBody,
        true,
      ),
      OutcomeUnconfirmed() => (
        AppAlertVariant.warning,
        l10n.outcomeUnconfirmed,
        l10n.outcomeUnconfirmedBody,
        true,
      ),
    };
    return AppAlert(
      variant: variant,
      title: title,
      message: message,
      action: toOrders
          ? AppButton(
              trackId: 'outcome_open_orders',
              label: l10n.outcomeOpenOrders,
              size: AppButtonSize.medium,
              variant: AppButtonVariant.secondary,
              onPressed: () => context.go(Routes.portfolioOrders),
            )
          : null,
    );
  }
}
