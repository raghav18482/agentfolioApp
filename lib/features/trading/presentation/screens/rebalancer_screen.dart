import 'dart:async';
import 'dart:math' as math;

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_card.dart';
import 'package:agentfolio/core/presentation/widgets/empty_state.dart';
import 'package:agentfolio/core/presentation/widgets/error_view.dart';
import 'package:agentfolio/core/presentation/widgets/money.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/format.dart';
import 'package:agentfolio/features/trading/domain/trading_logic.dart';
import 'package:agentfolio/features/trading/presentation/view_models/rebalancer_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Sell parts of holdings, reinvest the cash, see the result. A simulation:
/// nothing here reaches the broker.
class RebalancerScreen extends StatefulWidget {
  const RebalancerScreen({super.key});

  @override
  State<RebalancerScreen> createState() => _RebalancerScreenState();
}

class _RebalancerScreenState extends State<RebalancerScreen> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<RebalancerViewModel>().load());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<RebalancerViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.rebalancerTitle),
        actions: [
          TextButton(
            onPressed: vm.touched
                ? () {
                    context.trackTap('rebalancer_reset');
                    vm.reset();
                  }
                : null,
            child: Text(l10n.rebalancerReset),
          ),
        ],
      ),
      body: switch (vm.snapshot.state) {
        ViewIdle() || ViewLoading() => const Padding(
          padding: EdgeInsets.all(AppSpace.page),
          child: Shimmer(child: SkeletonBox(width: double.infinity, height: 400)),
        ),
        ViewError(:final failure) => ErrorView(
          failure: failure,
          retryTrackId: 'rebalancer_retry',
          onRetry: () => unawaited(vm.snapshot.load(force: true)),
        ),
        ViewData() when vm.rows.isEmpty => EmptyState(
          icon: Icons.tune_rounded,
          title: l10n.rebalancerEmpty,
        ),
        ViewData() => const _Simulator(),
      },
    );
  }
}

class _Simulator extends StatelessWidget {
  const _Simulator();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<RebalancerViewModel>();
    final sim = vm.simulation;
    final rows = vm.rows;
    final top = rows.fold<double>(
      0,
      (m, r) => math.max(m, math.max(r.original, sim.after[r.symbol] ?? 0)),
    );

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(AppSpace.page, AppSpace.sm, AppSpace.page, AppSpace.xxl),
      children: [
        Text(
          l10n.rebalancerIntro,
          style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary, height: 1.45),
        ),
        const SizedBox(height: AppSpace.lg),
        Row(
          children: [
            Expanded(
              child: _Stat(label: l10n.rebalancerFreed, value: sim.freed),
            ),
            const SizedBox(width: AppSpace.md),
            Expanded(
              child: _Stat(label: l10n.rebalancerLeft, value: sim.remaining),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.lg),
        AppCard(
          child: Column(
            children: [
              for (final (i, r) in rows.indexed) ...[
                if (i > 0) Divider(height: AppSpace.xl, color: context.palette.border),
                _Row(row: r, after: sim.after[r.symbol] ?? r.original, top: top),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpace.lg),
        _Reinvest(rows: rows),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) => AppCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.text.labelMedium?.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: AppSpace.xs),
        MoneyText(value, format: MoneyStyle.rupees, style: context.text.titleMedium),
      ],
    ),
  );
}

class _Row extends StatelessWidget {
  const _Row({required this.row, required this.after, required this.top});

  final RebalanceRow row;
  final double after;
  final double top;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<RebalancerViewModel>();
    final sold = context.select<RebalancerViewModel, double>((v) => v.soldPercent(row.symbol));
    final added = context.select<RebalancerViewModel, double>((v) => v.reinvested(row.symbol));
    final changed = (after - row.original).abs() > 0.5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(child: Text(row.label, style: context.text.titleSmall)),
            MoneyText(
              after,
              format: MoneyStyle.rupees,
              style: context.text.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: changed ? AppColors.brandSoft : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpace.sm),
        // Before (faint) and after, on one scale across all rows.
        _Bars(before: row.original / top, after: top == 0 ? 0 : after / top),
        Row(
          children: [
            Expanded(
              child: Slider(
                value: sold,
                max: 100,
                divisions: 20,
                label: '${sold.round()}%',
                semanticFormatterCallback: (v) =>
                    l10n.rebalancerSoldSemantics(v.round(), row.label),
                onChanged: (v) => vm.setSold(row.symbol, v),
                onChangeEnd: (v) => context.trackChange('rebalancer_sell', '${v.round()}'),
              ),
            ),
            SizedBox(
              width: 72,
              child: Text(
                added > 0 ? '+${Fmt.compact(added)}' : l10n.rebalancerSold(sold.round()),
                textAlign: TextAlign.end,
                style: context.text.labelMedium?.copyWith(
                  color: added > 0 ? AppColors.gain : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Bars extends StatelessWidget {
  const _Bars({required this.before, required this.after});

  final double before;
  final double after;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 10,
    child: Stack(
      children: [
        FractionallySizedBox(
          widthFactor: before.clamp(0, 1),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.textMuted.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        AnimatedFractionallySizedBox(
          duration: const Duration(milliseconds: 200),
          widthFactor: after.clamp(0, 1),
          heightFactor: 0.6,
          alignment: Alignment.centerLeft,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.brandSoft,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    ),
  );
}

class _Reinvest extends StatefulWidget {
  const _Reinvest({required this.rows});

  final List<RebalanceRow> rows;

  @override
  State<_Reinvest> createState() => _ReinvestState();
}

class _ReinvestState extends State<_Reinvest> {
  final _amount = TextEditingController();
  String? _target;
  ReinvestProblem? _problem;

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  void _apply() {
    context.trackTap('rebalancer_reinvest');
    final amount = double.tryParse(_amount.text.trim().replaceAll(',', ''));
    final problem = context.read<RebalancerViewModel>().reinvest(_target, amount);
    setState(() => _problem = problem);
    if (problem == null) {
      _amount.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final remaining = context.select<RebalancerViewModel, double>((v) => v.simulation.remaining);
    final problem = switch (_problem) {
      null => null,
      ReinvestProblem.noTarget => l10n.rebalancerPickStock,
      ReinvestProblem.notPositive => l10n.rebalancerAmountPositive,
      ReinvestProblem.tooMuch => l10n.rebalancerTooMuch(Fmt.rupees(remaining)),
    };

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.rebalancerReinvest, style: context.text.titleSmall),
          const SizedBox(height: AppSpace.md),
          Wrap(
            spacing: AppSpace.sm,
            runSpacing: AppSpace.sm,
            children: [
              for (final r in widget.rows)
                ChoiceChip(
                  label: Text(r.label),
                  selected: _target == r.symbol,
                  onSelected: (_) => setState(() {
                    _target = r.symbol;
                    _problem = null;
                  }),
                ),
            ],
          ),
          const SizedBox(height: AppSpace.md),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  controller: _amount,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _apply(),
                  decoration: InputDecoration(
                    isDense: true,
                    prefixText: '₹ ',
                    hintText: l10n.rebalancerAmount,
                    errorText: problem,
                    errorMaxLines: 2,
                  ),
                ),
              ),
              const SizedBox(width: AppSpace.md),
              AppButton(
                trackId: 'rebalancer_apply',
                label: l10n.rebalancerApply,
                size: AppButtonSize.medium,
                variant: AppButtonVariant.secondary,
                onPressed: _apply,
              ),
            ],
          ),
          const SizedBox(height: AppSpace.sm),
          Text(
            l10n.rebalancerNote,
            style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
          ),
        ],
      ),
    );
  }
}
