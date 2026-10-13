import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_choice_chips.dart';
import 'package:agentfolio/core/presentation/widgets/app_segmented.dart';
import 'package:agentfolio/core/presentation/widgets/app_text_field.dart';
import 'package:agentfolio/core/presentation/widgets/confirm_sheet.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/domain/trading_logic.dart';
import 'package:agentfolio/features/trading/presentation/view_models/risk_profile_view_model.dart';
import 'package:agentfolio/features/trading/presentation/widgets/risk_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

/// Sets the limits the trading agent and every approval must respect.
class RiskProfileScreen extends StatefulWidget {
  const RiskProfileScreen({super.key});

  @override
  State<RiskProfileScreen> createState() => _RiskProfileScreenState();
}

class _RiskProfileScreenState extends State<RiskProfileScreen> {
  late final RiskProfileViewModel _vm = context.read<RiskProfileViewModel>();
  late final _age = TextEditingController(text: _vm.age);
  late final _horizon = TextEditingController(text: _vm.horizon);
  late final _maxOrder = TextEditingController(text: _vm.maxOrderValue);
  late final _maxPosition = TextEditingController(text: _vm.maxPosition);
  late final _maxTrades = TextEditingController(text: _vm.maxDailyTrades);
  late final _tax = TextEditingController(text: _vm.taxBracket);

  /// Common slabs; anything else saved before is offered too.
  static const _slabs = ['0%', '5%', '10%', '15%', '20%', '30%'];

  @override
  void dispose() {
    for (final c in [_age, _horizon, _maxOrder, _maxPosition, _maxTrades, _tax]) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    FocusScope.of(context).unfocus();
    final saved = await _vm.save();
    if (saved == null) return;
    messenger.showSnackBar(SnackBar(content: Text(l10n.profileSaved)));
    navigator.pop(saved);
  }

  Future<bool> _confirmDiscard() => showConfirmSheet(
    context,
    trackId: 'profile_discard',
    title: AppLocalizations.of(context).profileDiscardTitle,
    message: AppLocalizations.of(context).profileDiscardBody,
    confirmLabel: AppLocalizations.of(context).profileDiscard,
    destructive: true,
  );

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<RiskProfileViewModel>();
    final problems = vm.problems;
    final slabs = {..._slabs, if (vm.taxBracket.isNotEmpty) vm.taxBracket}.toList();

    String? problem(ProfileField f, String text) => problems.contains(f) ? text : null;

    return PopScope(
      canPop: !vm.dirty || vm.saving,
      onPopInvokedWithResult: (didPop, _) async {
        if (didPop) return;
        final navigator = Navigator.of(context);
        if (await _confirmDiscard()) navigator.pop();
      },
      child: Scaffold(
        appBar: AppBar(title: Text(vm.isNew ? l10n.profileSetUp : l10n.profileEditTitle)),
        body: SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpace.page,
              AppSpace.sm,
              AppSpace.page,
              AppSpace.xxl,
            ),
            children: [
              Text(
                l10n.profileIntro,
                style: context.text.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.45,
                ),
              ),
              if (vm.saveFailure case final failure?) ...[
                const SizedBox(height: AppSpace.lg),
                AppAlert(message: failure.message),
              ],
              _Heading(l10n.profileAboutYou),
              _NumberRow(
                children: [
                  AppTextField(
                    controller: _age,
                    label: l10n.profileAge,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    error: problem(ProfileField.age, l10n.profileAgeProblem),
                    onChanged: (v) => vm.update((f) => f.age = v),
                  ),
                  AppTextField(
                    controller: _horizon,
                    label: l10n.profileHorizonYears,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    error: problem(ProfileField.horizon, l10n.profileHorizonProblem),
                    onChanged: (v) => vm.update((f) => f.horizon = v),
                  ),
                ],
              ),
              const SizedBox(height: AppSpace.lg),
              Text(l10n.profileGoal, style: context.text.labelLarge),
              const SizedBox(height: AppSpace.sm),
              AppChoiceChips<InvestmentGoal>(
                trackId: 'profile_goal',
                selected: vm.goal,
                onChanged: (g) => vm.update((f) => f.goal = g),
                options: [
                  for (final g in InvestmentGoal.values)
                    AppSegment(value: g, label: goalLabel(l10n, g), id: g.name),
                ],
              ),
              const SizedBox(height: AppSpace.lg),
              Text(l10n.profileTolerance, style: context.text.labelLarge),
              const SizedBox(height: AppSpace.sm),
              AppSegmented<RiskTolerance>(
                trackId: 'profile_tolerance',
                selected: vm.tolerance,
                onChanged: (t) => vm.update((f) => f.tolerance = t),
                segments: [
                  for (final t in RiskTolerance.values)
                    AppSegment(value: t, label: toleranceLabel(l10n, t), id: t.name),
                ],
              ),
              const SizedBox(height: AppSpace.lg),
              Text(l10n.profileTax, style: context.text.labelLarge),
              const SizedBox(height: AppSpace.sm),
              AppChoiceChips<String>(
                trackId: 'profile_tax',
                selected: vm.taxBracket,
                onChanged: (t) => vm.update((f) => f.taxBracket = t),
                options: [for (final s in slabs) AppSegment(value: s, label: s, id: 'slab')],
              ),
              _Heading(l10n.profileLimits),
              AppTextField(
                controller: _maxOrder,
                label: l10n.profileMaxOrderLabel,
                helper: l10n.profileMaxOrderHelp,
                prefix: const Padding(
                  padding: EdgeInsets.only(left: AppSpace.md),
                  child: Text('₹'),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                error: problem(ProfileField.maxOrderValue, l10n.profileMaxOrderProblem),
                onChanged: (v) => vm.update((f) => f.maxOrderValue = v),
              ),
              const SizedBox(height: AppSpace.lg),
              _NumberRow(
                children: [
                  AppTextField(
                    controller: _maxPosition,
                    label: l10n.profileMaxPositionLabel,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    textInputAction: TextInputAction.next,
                    error: problem(ProfileField.maxPosition, l10n.profilePercentProblem),
                    onChanged: (v) => vm.update((f) => f.maxPosition = v),
                  ),
                  AppTextField(
                    controller: _maxTrades,
                    label: l10n.profileMaxTrades,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    error: problem(ProfileField.maxDailyTrades, l10n.profileTradesProblem),
                    onChanged: (v) => vm.update((f) => f.maxDailyTrades = v),
                  ),
                ],
              ),
              const SizedBox(height: AppSpace.lg),
              Text(l10n.profileProducts, style: context.text.labelLarge),
              for (final p in ProductType.values)
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  value: vm.products.contains(p),
                  onChanged: (_) {
                    HapticFeedback.selectionClick().ignore();
                    vm.toggleProduct(p);
                  },
                  title: Text(productLabel(l10n, p)),
                  subtitle: Text(
                    p == ProductType.delivery ? l10n.productDeliveryHint : l10n.productIntradayHint,
                  ),
                ),
              if (problems.contains(ProfileField.products))
                Text(
                  l10n.profileProductsProblem,
                  style: context.text.bodySmall?.copyWith(color: AppColors.loss),
                ),
              const SizedBox(height: AppSpace.xl),
              AppButton(
                trackId: 'profile_save',
                label: l10n.profileSave,
                loading: vm.saving,
                onPressed: () => unawaited(_save()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Heading extends StatelessWidget {
  const _Heading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpace.xl, bottom: AppSpace.md),
    child: Text(text.toUpperCase(), style: context.text.labelSmall),
  );
}

/// Two short number fields side by side; stacked on a narrow screen.
class _NumberRow extends StatelessWidget {
  const _NumberRow({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => constraints.maxWidth < 340
        ? Column(
            children: [
              for (final (i, c) in children.indexed) ...[
                if (i > 0) const SizedBox(height: AppSpace.lg),
                c,
              ],
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final (i, c) in children.indexed) ...[
                if (i > 0) const SizedBox(width: AppSpace.md),
                Expanded(child: c),
              ],
            ],
          ),
  );
}
