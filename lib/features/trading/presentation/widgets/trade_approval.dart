import 'dart:async';

import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/hold_to_confirm.dart';
import 'package:agentfolio/core/security/device_auth.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/user_hash.dart';
import 'package:agentfolio/core/time/server_clock.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/domain/trading_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// Asks the user to confirm placing a real order, the only way any order is
/// approved in the app:
///
/// 1. the risk disclosure, once per user;
/// 2. a sheet with the order, the account it goes to, and how long the
///    proposal has left (by the server's clock);
/// 3. Face ID, fingerprint or the device passcode. A device with no screen
///    lock holds a button down instead. Never a swipe.
///
/// [proposal] is null when only the id is known (an `APPROVE` typed in chat).
/// True only when every step was passed.
Future<bool> confirmTradeApproval(
  BuildContext context, {
  required String proposalId,
  TradeProposal? proposal,
  double? lastPrice,
}) async {
  final prefs = context.read<Prefs>();
  final userId = context.read<SessionProvider>().signedIn?.user.id;
  if (userId == null) return false;
  final scope = hashUserId(userId);

  if (!prefs.riskDisclosureAccepted(scope)) {
    final accepted = await showModalBottomSheet<bool>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (_) => const _RiskDisclosure(),
    );
    if (accepted != true || !context.mounted) return false;
    await prefs.setRiskDisclosureAccepted(scope);
    if (!context.mounted) return false;
  }

  final confirmed = await showModalBottomSheet<bool>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    builder: (_) =>
        _ApprovalSheet(proposalId: proposalId, proposal: proposal, lastPrice: lastPrice),
  );
  return confirmed ?? false;
}

class _RiskDisclosure extends StatefulWidget {
  const _RiskDisclosure();

  @override
  State<_RiskDisclosure> createState() => _RiskDisclosureState();
}

class _RiskDisclosureState extends State<_RiskDisclosure> {
  bool _understood = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.gpp_maybe_outlined, color: AppColors.warning, size: 32),
          const SizedBox(height: AppSpace.md),
          Text(Disclaimers.tradingRiskTitle, style: context.text.titleLarge),
          const SizedBox(height: AppSpace.lg),
          for (final point in Disclaimers.tradingRiskPoints)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpace.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 7),
                    child: Icon(Icons.circle, size: 6, color: AppColors.textSecondary),
                  ),
                  const SizedBox(width: AppSpace.md),
                  Expanded(
                    child: Text(point, style: context.text.bodyMedium?.copyWith(height: 1.45)),
                  ),
                ],
              ),
            ),
          CheckboxListTile(
            value: _understood,
            onChanged: (v) => setState(() => _understood = v ?? false),
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            title: const Text(Disclaimers.tradingRiskAccept),
          ),
          const SizedBox(height: AppSpace.md),
          AppButton(
            trackId: 'risk_disclosure_accept',
            label: l10n.commonContinue,
            onPressed: _understood ? () => Navigator.of(context).pop(true) : null,
          ),
        ],
      ),
    );
  }
}

class _ApprovalSheet extends StatefulWidget {
  const _ApprovalSheet({required this.proposalId, this.proposal, this.lastPrice});

  final String proposalId;
  final TradeProposal? proposal;
  final double? lastPrice;

  @override
  State<_ApprovalSheet> createState() => _ApprovalSheetState();
}

class _ApprovalSheetState extends State<_ApprovalSheet> {
  Timer? _ticker;
  bool _authenticating = false;
  bool _noLock = false;
  String? _authProblem;

  @override
  void initState() {
    super.initState();
    if (widget.proposal != null) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _confirm() async {
    final l10n = AppLocalizations.of(context);
    setState(() {
      _authenticating = true;
      _authProblem = null;
    });
    final result = await context.read<DeviceAuth>().confirm(l10n.approveAuthReason);
    if (!mounted) return;
    setState(() => _authenticating = false);
    switch (result) {
      case DeviceAuthResult.confirmed:
        Navigator.of(context).pop(true);
      case DeviceAuthResult.cancelled:
        break;
      case DeviceAuthResult.unavailable:
        setState(() => _noLock = true);
      case DeviceAuthResult.failed:
        HapticFeedback.vibrate().ignore();
        setState(() => _authProblem = l10n.approveAuthFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final proposal = widget.proposal;
    final order = proposal?.order;
    final account = context.read<SessionProvider>().activeAccount;
    final broker = account == null
        ? l10n.chatYourBroker
        : context.read<BrokerRegistry>().resolve(account.brokerId).displayName;
    final left = proposal == null ? null : timeLeft(proposal, context.read<ServerClock>().now());
    final expired = left == Duration.zero;
    final value = order == null ? null : orderValue(order, lastPrice: widget.lastPrice);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.approveTitle, style: context.text.titleLarge),
          const SizedBox(height: AppSpace.lg),
          if (order != null) ...[
            OrderHeadline(order: order),
            const SizedBox(height: AppSpace.lg),
            _Facts(
              rows: [
                (l10n.orderPrice, order.price == null ? l10n.orderMarket : Fmt.money(order.price)),
                if (order.triggerPrice != null) (l10n.orderTrigger, Fmt.money(order.triggerPrice)),
                if (value != null)
                  (order.price == null ? l10n.orderValueApprox : l10n.orderValue, Fmt.money(value)),
                if (order.product.isNotEmpty) (l10n.orderProduct, order.product),
                if (order.orderType.isNotEmpty) (l10n.orderType, order.orderType),
                (l10n.orderExchange, order.exchange),
                (l10n.orderAccount, '$broker · ${account?.clientCode ?? '—'}'),
                (l10n.orderProposal, widget.proposalId),
              ],
            ),
          ] else
            _Facts(
              rows: [
                (l10n.orderProposal, widget.proposalId),
                (l10n.orderAccount, '$broker · ${account?.clientCode ?? '—'}'),
              ],
            ),
          const SizedBox(height: AppSpace.lg),
          if (left != null)
            _Countdown(left: left)
          else
            Text(
              l10n.approveNoDetails,
              style: context.text.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          const SizedBox(height: AppSpace.md),
          Text(
            l10n.approveWarning(broker),
            style: context.text.bodyMedium?.copyWith(color: AppColors.warning, height: 1.45),
          ),
          if (_authProblem != null) ...[
            const SizedBox(height: AppSpace.md),
            Text(_authProblem!, style: context.text.bodySmall?.copyWith(color: AppColors.loss)),
          ],
          const SizedBox(height: AppSpace.xl),
          if (_noLock) ...[
            Text(
              l10n.approveNoLock,
              style: context.text.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpace.md),
            HoldToConfirm(
              trackId: 'approve_hold',
              label: l10n.approveHold,
              onConfirmed: expired ? null : () => Navigator.of(context).pop(true),
            ),
          ] else
            AppButton(
              trackId: 'approve_confirm',
              label: l10n.approveConfirm,
              icon: Icons.fingerprint_rounded,
              variant: AppButtonVariant.destructive,
              loading: _authenticating,
              onPressed: expired ? null : () => unawaited(_confirm()),
            ),
          const SizedBox(height: AppSpace.sm),
          AppButton(
            trackId: 'approve_cancel',
            label: l10n.commonCancel,
            variant: AppButtonVariant.ghost,
            onPressed: () => Navigator.of(context).pop(false),
          ),
        ],
      ),
    );
  }
}

/// `BUY 10 × TCS`, coloured by side, never by colour alone.
class OrderHeadline extends StatelessWidget {
  const OrderHeadline({required this.order, super.key, this.compact = false});

  final ProposedOrder order;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final buy = order.side == TradeSide.buy;
    final color = buy ? AppColors.gain : AppColors.loss;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.sm, vertical: 2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            buy ? l10n.orderBuy : l10n.orderSell,
            style: context.text.labelMedium?.copyWith(color: color, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(width: AppSpace.sm),
        Flexible(
          child: Text(
            l10n.orderHeadline(order.quantity, Fmt.symbol(order.symbol)),
            overflow: TextOverflow.ellipsis,
            style: compact ? context.text.titleSmall : context.text.titleMedium,
          ),
        ),
      ],
    );
  }
}

class _Facts extends StatelessWidget {
  const _Facts({required this.rows});

  final List<(String, String)> rows;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg, vertical: AppSpace.sm),
    decoration: BoxDecoration(color: context.palette.surfaceRaised, borderRadius: AppRadius.card),
    child: Column(
      children: [
        for (final (label, value) in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpace.xs + 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: context.text.bodySmall?.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(width: AppSpace.lg),
                Expanded(
                  child: Text(
                    value,
                    textAlign: TextAlign.end,
                    style: context.text.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

/// `Expires in 3:42`, amber in the last minute, and a plain statement once
/// it has.
class _Countdown extends StatelessWidget {
  const _Countdown({required this.left});

  final Duration left;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (left == Duration.zero) {
      return Text(
        l10n.proposalExpiredNow,
        style: context.text.bodyMedium?.copyWith(color: AppColors.loss),
      );
    }
    return Row(
      children: [
        Icon(
          Icons.timer_outlined,
          size: 16,
          color: left.inSeconds < 60 ? AppColors.warning : AppColors.textSecondary,
        ),
        const SizedBox(width: AppSpace.xs),
        Text(
          l10n.proposalExpiresIn(formatCountdown(left)),
          style: context.text.bodyMedium?.copyWith(
            color: left.inSeconds < 60 ? AppColors.warning : AppColors.textSecondary,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}

/// `4:05`, `0:09`.
String formatCountdown(Duration d) =>
    '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';
