import 'dart:async';

import 'package:agentfolio/core/broker/broker_descriptor.dart';
import 'package:agentfolio/core/config/env.dart';
import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_checkbox_tile.dart';
import 'package:agentfolio/core/presentation/widgets/app_text_field.dart';
import 'package:agentfolio/core/presentation/widgets/async_view.dart';
import 'package:agentfolio/core/presentation/widgets/confirm_sheet.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/presentation/view_models/link_account_view_model.dart';
import 'package:agentfolio/features/auth/presentation/widgets/auth_layout.dart';
import 'package:agentfolio/features/auth/presentation/widgets/phone_field.dart';
import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LinkAccountScreen extends StatefulWidget {
  const LinkAccountScreen({super.key});

  @override
  State<LinkAccountScreen> createState() => _LinkAccountScreenState();
}

class _LinkAccountScreenState extends State<LinkAccountScreen> {
  late final LinkAccountViewModel _vm = context.read<LinkAccountViewModel>();
  late final Map<String, TextEditingController> _credentials = {
    for (final field in _vm.broker.credentialFields) field.key: TextEditingController(),
  };
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void initState() {
    super.initState();
    unawaited(_vm.loadConfig());
  }

  @override
  void dispose() {
    for (final c in [..._credentials.values, _phone, _password, _confirm]) {
      c.dispose();
    }
    super.dispose();
  }

  Map<String, String> get _credentialValues => {
    for (final entry in _credentials.entries) entry.key: entry.value.text,
  };

  bool get _hasInput =>
      _credentials.values.any((c) => c.text.isNotEmpty) ||
      _phone.text.isNotEmpty ||
      _password.text.isNotEmpty;

  void _continue() {
    FocusScope.of(context).unfocus();
    if (_vm.continueToSignIn(_credentialValues)) {
      unawaited(HapticFeedback.selectionClick());
    } else {
      unawaited(HapticFeedback.heavyImpact());
    }
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final signedIn = await _vm.submit(
      credentials: _credentialValues,
      national: _phone.text,
      appPassword: _password.text,
      appPasswordConfirm: _confirm.text,
    );
    if (!mounted) return;
    if (signedIn) {
      TextInput.finishAutofillContext();
      unawaited(HapticFeedback.mediumImpact());
    } else {
      unawaited(HapticFeedback.heavyImpact());
    }
  }

  /// Back on step two returns to step one. Leaving with anything typed asks
  /// first: those are broker credentials the user had to go and find.
  Future<void> _handleBack() async {
    if (_vm.back()) return;
    if (!_hasInput) {
      if (mounted) context.pop();
      return;
    }
    final l10n = AppLocalizations.of(context);
    final discard = await showConfirmSheet(
      context,
      trackId: 'link_account_discard',
      title: l10n.linkDiscardTitle,
      message: l10n.linkDiscardBody,
      confirmLabel: l10n.commonDiscard,
      cancelLabel: l10n.commonKeepEditing,
      destructive: true,
    );
    if (discard && mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<LinkAccountViewModel>();
    final onSignIn = vm.step == LinkStep.signIn;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) unawaited(_handleBack());
      },
      child: AuthLayout(
        title: l10n.linkTitle,
        showMark: false,
        appBar: AppBar(leading: BackButton(onPressed: () => unawaited(_handleBack()))),
        header: _StepIndicator(step: vm.stepNumber, total: LinkAccountViewModel.stepCount),
        bottom: AppButton(
          trackId: onSignIn ? 'link_account_submit' : 'link_account_continue',
          label: !onSignIn
              ? l10n.linkContinue
              : vm.submitting
              ? l10n.linkVerifying(vm.broker.displayName)
              : l10n.linkSubmit,
          loading: vm.submitting,
          expand: true,
          onPressed: vm.config.dataOrNull == null
              ? null
              : onSignIn
              ? () => unawaited(_submit())
              : _continue,
        ),
        children: [
          AsyncView<AuthConfig>(
            state: vm.config,
            retryTrackId: 'link_account_config_retry',
            onRetry: () => unawaited(vm.loadConfig()),
            skeleton: const _StepSkeleton(),
            builder: (context, config) => PageTransitionSwitcher(
              duration: AppMotion.of(context, AppMotion.medium),
              reverse: !onSignIn,
              transitionBuilder: (child, primary, secondary) => SharedAxisTransition(
                animation: primary,
                secondaryAnimation: secondary,
                transitionType: SharedAxisTransitionType.horizontal,
                fillColor: Colors.transparent,
                child: child,
              ),
              child: onSignIn
                  ? _SignInStep(
                      key: const ValueKey('sign_in'),
                      config: config,
                      phone: _phone,
                      password: _password,
                      confirm: _confirm,
                      onSubmit: () => unawaited(_submit()),
                    )
                  : _BrokerStep(
                      key: const ValueKey('broker'),
                      controllers: _credentials,
                      onDone: _continue,
                    ),
            ),
          ),
          if (!onSignIn) ...[
            const SizedBox(height: AppSpace.xl),
            AuthFooterLink(
              trackId: 'link_account_to_login',
              prompt: l10n.linkAlreadySetUp,
              action: l10n.linkLogInInstead,
              onTap: () => unawaited(_handleBack()),
            ),
          ],
        ],
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.step, required this.total});

  final int step;
  final int total;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.linkStepOf(step, total).toUpperCase(),
          style: context.text.labelSmall?.copyWith(color: AppColors.brandSoft),
        ),
        const SizedBox(height: AppSpace.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: step / total),
            duration: AppMotion.of(context, AppMotion.medium),
            curve: AppMotion.enter,
            builder: (context, value, _) => LinearProgressIndicator(value: value, minHeight: 4),
          ),
        ),
      ],
    );
  }
}

/// Step one: the broker's own credential fields, generated from its
/// descriptor, so another broker gets its own form with no screen changes.
class _BrokerStep extends StatelessWidget {
  const _BrokerStep({required this.controllers, required this.onDone, super.key});

  final Map<String, TextEditingController> controllers;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<LinkAccountViewModel>();
    final broker = vm.broker;
    final fields = broker.credentialFields;
    final links = context.read<LinkOpener>();
    final guide = broker.credentialsGuidePath;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _StepHeading(
          title: l10n.linkBrokerStepTitle(broker.displayName),
          subtitle: l10n.linkBrokerStepSubtitle(broker.displayName),
        ),
        if (vm.formError case final message?) ...[
          AppAlert(message: message),
          const SizedBox(height: AppSpace.lg),
        ],
        for (final (i, field) in fields.indexed) ...[
          AppTextField(
            controller: controllers[field.key]!,
            trackId: 'link_${field.key}',
            label: field.label,
            hint: field.hint,
            helper: field.helpText,
            error: vm.fieldErrors[field.key],
            secret: field.obscured,
            pasteable: field.pasteFriendly,
            enabled: !vm.submitting,
            keyboardType: field.kind == CredentialKind.secret
                ? TextInputType.visiblePassword
                : TextInputType.text,
            textCapitalization: field.uppercase
                ? TextCapitalization.characters
                : TextCapitalization.none,
            textInputAction: i == fields.length - 1 ? TextInputAction.done : TextInputAction.next,
            onChanged: (_) => vm.edited(field.key),
            onSubmitted: i == fields.length - 1 ? (_) => onDone() : null,
          ),
          const SizedBox(height: AppSpace.lg),
        ],
        if (guide != null)
          AuthFooterLink(
            trackId: 'link_account_setup_guide',
            prompt: l10n.linkWhereToFind,
            action: l10n.linkSetupGuide,
            onTap: () =>
                unawaited(links.open(context.read<Env>().webPage(guide), id: 'setup_guide')),
          ),
      ],
    );
  }
}

/// Step two: how the user signs in from now on, plus the informed-consent
/// text about storing credentials.
class _SignInStep extends StatelessWidget {
  const _SignInStep({
    required this.config,
    required this.phone,
    required this.password,
    required this.confirm,
    required this.onSubmit,
    super.key,
  });

  final AuthConfig config;
  final TextEditingController phone;
  final TextEditingController password;
  final TextEditingController confirm;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<LinkAccountViewModel>();
    final env = context.read<Env>();

    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StepHeading(title: l10n.linkSignInStepTitle, subtitle: l10n.linkSignInStepSubtitle),
          if (vm.formError case final message?) ...[
            AppAlert(message: message),
            const SizedBox(height: AppSpace.lg),
          ],
          PhoneField(
            controller: phone,
            countries: config.countries,
            country: vm.country ?? config.defaultCountry,
            onCountryChanged: vm.selectCountry,
            helper: l10n.fieldWhatsappHelp,
            error: vm.fieldErrors['whatsapp_number'],
            enabled: !vm.submitting,
            isLoginIdentifier: true,
            onChanged: (_) => vm.edited('whatsapp_number'),
          ),
          const SizedBox(height: AppSpace.lg),
          AppTextField(
            controller: password,
            trackId: 'link_app_password',
            label: l10n.fieldAppPassword,
            hint: l10n.fieldAppPasswordNewHint(config.minPasswordChars),
            helper: l10n.fieldAppPasswordNewHelp,
            error: vm.fieldErrors['app_password'],
            secret: true,
            enabled: !vm.submitting,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.newPassword],
            onChanged: (_) => vm.edited('app_password'),
          ),
          const SizedBox(height: AppSpace.lg),
          AppTextField(
            controller: confirm,
            trackId: 'link_app_password_confirm',
            label: l10n.fieldAppPasswordConfirm,
            error: vm.fieldErrors['app_password_confirm'],
            secret: true,
            enabled: !vm.submitting,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.newPassword],
            onChanged: (_) => vm.edited('app_password_confirm'),
            onSubmitted: (_) => onSubmit(),
          ),
          const SizedBox(height: AppSpace.xl),
          const AppAlert(
            variant: AppAlertVariant.warning,
            title: Disclaimers.linkAccountTradeOffLead,
            message: Disclaimers.linkAccountTradeOff,
          ),
          if (vm.consentRequired) ...[
            const SizedBox(height: AppSpace.md),
            _ConsentRow(env: env),
            if (vm.consentMissing)
              Padding(
                padding: const EdgeInsets.only(left: 48),
                child: Text(
                  l10n.linkConsentRequired,
                  style: context.text.bodySmall?.copyWith(color: context.palette.loss),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

class _ConsentRow extends StatefulWidget {
  const _ConsentRow({required this.env});

  final Env env;

  @override
  State<_ConsentRow> createState() => _ConsentRowState();
}

class _ConsentRowState extends State<_ConsentRow> {
  late final _terms = TapGestureRecognizer()..onTap = () => _open(widget.env.termsUrl, 'terms');
  late final _privacy = TapGestureRecognizer()
    ..onTap = () => _open(widget.env.privacyUrl, 'privacy');

  void _open(Uri? uri, String id) {
    if (uri != null) unawaited(context.read<LinkOpener>().open(uri, id: id));
  }

  @override
  void dispose() {
    _terms.dispose();
    _privacy.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<LinkAccountViewModel>();
    final link = context.text.bodyMedium?.copyWith(
      color: AppColors.brandSoft,
      fontWeight: FontWeight.w600,
    );
    // Build the sentence with markers where the two links go, then swap each
    // marker for a tappable span. Translations may put them in any order.
    const termsMarker = '{terms}';
    const privacyMarker = '{privacy}';
    final template = l10n.linkConsent(termsMarker, privacyMarker);
    final spans = <InlineSpan>[];
    var last = 0;
    for (final match in RegExp(r'\{terms\}|\{privacy\}').allMatches(template)) {
      if (match.start > last) spans.add(TextSpan(text: template.substring(last, match.start)));
      spans.add(
        match[0] == termsMarker
            ? TextSpan(text: l10n.linkConsentTerms, style: link, recognizer: _terms)
            : TextSpan(text: l10n.linkConsentPrivacy, style: link, recognizer: _privacy),
      );
      last = match.end;
    }
    if (last < template.length) spans.add(TextSpan(text: template.substring(last)));

    return AppCheckboxTile(
      trackId: 'link_account_consent',
      value: vm.consent,
      onChanged: (value) => vm.setConsent(value: value),
      label: Text.rich(TextSpan(children: spans), style: context.text.bodyMedium),
    );
  }
}

class _StepHeading extends StatelessWidget {
  const _StepHeading({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpace.xl),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: context.text.titleLarge),
        const SizedBox(height: AppSpace.xs),
        Text(subtitle, style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary)),
      ],
    ),
  );
}

class _StepSkeleton extends StatelessWidget {
  const _StepSkeleton();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SkeletonBox(width: 200, height: 20),
      const SizedBox(height: AppSpace.xl),
      for (var i = 0; i < 3; i++) ...const [
        SkeletonBox(width: 100),
        SizedBox(height: AppSpace.sm),
        SkeletonBox(height: 56, width: double.infinity, radius: AppRadius.md),
        SizedBox(height: AppSpace.lg),
      ],
    ],
  );
}
