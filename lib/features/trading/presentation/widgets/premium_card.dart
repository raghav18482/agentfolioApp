import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/presentation/widgets/phone_field.dart';
import 'package:agentfolio/features/trading/presentation/view_models/premium_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// What Premium adds, and turning it on with a WhatsApp number.
class PremiumCard extends StatelessWidget {
  const PremiumCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<PremiumViewModel>();
    return SectionCard(
      title: l10n.premiumTitle,
      subtitle: l10n.premiumSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final (icon, text) in [
            (Icons.lightbulb_outline_rounded, l10n.premiumPerkIdeas),
            (Icons.verified_user_outlined, l10n.premiumPerkApprove),
            (Icons.show_chart_rounded, l10n.premiumPerkLive),
            (Icons.chat_outlined, l10n.premiumPerkBrief),
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpace.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, size: 20, color: AppColors.brandSoft),
                  const SizedBox(width: AppSpace.md),
                  Expanded(
                    child: Text(text, style: context.text.bodyMedium?.copyWith(height: 1.4)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppSpace.sm),
          SectionState<AuthConfig>(
            state: vm.config.state,
            retryTrackId: 'premium_config_retry',
            onRetry: () => unawaited(vm.config.load(force: true)),
            skeletonHeight: 120,
            builder: (context, config) => _Form(config: config),
          ),
        ],
      ),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form({required this.config});

  final AuthConfig config;

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final _number = TextEditingController();
  late Country _country = widget.config.defaultCountry;

  @override
  void dispose() {
    _number.dispose();
    super.dispose();
  }

  Future<void> _activate() async {
    FocusScope.of(context).unfocus();
    await context.read<PremiumViewModel>().activate(
      PhoneNumber(dialCode: _country.dialCode, national: _number.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<PremiumViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (vm.failure case final failure?) ...[
          AppAlert(message: failure.message),
          const SizedBox(height: AppSpace.md),
        ],
        PhoneField(
          controller: _number,
          countries: widget.config.countries,
          country: _country,
          onCountryChanged: (c) => setState(() => _country = c),
          helper: l10n.premiumNumberHelp,
          error: vm.blank ? l10n.premiumNumberMissing : null,
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => unawaited(_activate()),
        ),
        const SizedBox(height: AppSpace.lg),
        AppButton(
          trackId: 'premium_activate',
          label: l10n.premiumActivate,
          icon: Icons.workspace_premium_outlined,
          loading: vm.submitting,
          onPressed: () => unawaited(_activate()),
        ),
      ],
    );
  }
}
