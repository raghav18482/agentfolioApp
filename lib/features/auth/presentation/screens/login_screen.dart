import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_text_field.dart';
import 'package:agentfolio/core/presentation/widgets/async_view.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/auth/presentation/view_models/login_view_model.dart';
import 'package:agentfolio/features/auth/presentation/widgets/auth_layout.dart';
import 'package:agentfolio/features/auth/presentation/widgets/phone_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    unawaited(context.read<LoginViewModel>().loadConfig());
  }

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final vm = context.read<LoginViewModel>();
    if (!vm.canSubmit) return;
    FocusScope.of(context).unfocus();
    final signedIn = await vm.submit(national: _phone.text, appPassword: _password.text);
    if (!mounted) return;
    if (signedIn) {
      // Lets the password manager offer to save the number and password.
      TextInput.finishAutofillContext();
      unawaited(HapticFeedback.mediumImpact());
    } else {
      _password.clear();
      unawaited(HapticFeedback.heavyImpact());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<LoginViewModel>();
    final broker = context.read<BrokerRegistry>().resolve(null);
    final links = context.read<LinkOpener>();
    final retryIn = vm.retryIn;

    return AuthLayout(
      title: l10n.loginTitle,
      subtitle: l10n.loginSubtitle(broker.displayName),
      bottom: AppButton(
        trackId: 'login_submit',
        label: retryIn == null ? l10n.loginSubmit : l10n.loginRetryIn(_formatWait(retryIn)),
        loading: vm.submitting,
        expand: true,
        onPressed: vm.canSubmit ? () => unawaited(_submit()) : null,
      ),
      children: [
        AsyncView<AuthConfig>(
          state: vm.config,
          retryTrackId: 'login_config_retry',
          onRetry: () => unawaited(vm.loadConfig()),
          skeleton: const _FormSkeleton(),
          builder: (context, config) => _LoginForm(
            config: config,
            phone: _phone,
            password: _password,
            passwordFocus: _passwordFocus,
            onSubmit: () => unawaited(_submit()),
          ),
        ),
        const SizedBox(height: AppSpace.xl),
        AuthFooterLink(
          trackId: 'login_to_link_account',
          prompt: l10n.loginNewHere,
          action: l10n.loginSetUpLink,
          onTap: () => context.push(Routes.linkAccount),
        ),
        if (broker.accountOpeningUrl case final url?)
          AuthFooterLink(
            trackId: 'login_open_demat',
            prompt: l10n.loginNoBrokerAccount(broker.displayName),
            action: l10n.loginOpenDemat,
            onTap: () => unawaited(links.open(url, id: 'broker_account_opening')),
          ),
        const SizedBox(height: AppSpace.lg),
        AppAlert(
          variant: AppAlertVariant.info,
          icon: Icons.verified_user_outlined,
          title: Disclaimers.securityNoticeLead,
          message: Disclaimers.securityNotice(broker.displayName),
        ),
      ],
    );
  }

  static String _formatWait(Duration d) {
    final seconds = d.inSeconds + 1;
    return seconds < 60
        ? '${seconds}s'
        : '${seconds ~/ 60}:${(seconds % 60).toString().padLeft(2, '0')}';
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    required this.config,
    required this.phone,
    required this.password,
    required this.passwordFocus,
    required this.onSubmit,
  });

  final AuthConfig config;
  final TextEditingController phone;
  final TextEditingController password;
  final FocusNode passwordFocus;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<LoginViewModel>();
    final problem = vm.problem;
    String? fieldError(String field) =>
        problem is LoginFieldProblem && problem.field == field ? problem.message : null;

    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: switch (problem) {
              LoginFormProblem(:final message) => _Banner(AppAlert(message: message)),
              LoginSessionNotLoaded() => _Banner(AppAlert(message: l10n.loginSessionLoadFailed)),
              LoginBrokerRejected(:final message) => _Banner(
                AppAlert(
                  message: message,
                  action: AppButton(
                    trackId: 'login_relink',
                    label: l10n.loginRelink,
                    size: AppButtonSize.medium,
                    variant: AppButtonVariant.secondary,
                    onPressed: () => context.push(Routes.linkAccount),
                  ),
                ),
              ),
              _
                  when context.select<SessionProvider, bool>(
                    (s) => s.lastSignOut == SignOutReason.accountDeleted,
                  ) =>
                _Banner(
                  AppAlert(
                    variant: AppAlertVariant.success,
                    title: l10n.deletedTitle,
                    message: l10n.deletedBody,
                  ),
                ),
              _ => const SizedBox(width: double.infinity),
            },
          ),
          PhoneField(
            controller: phone,
            countries: config.countries,
            country: vm.country ?? config.defaultCountry,
            onCountryChanged: vm.selectCountry,
            error: fieldError('whatsapp_number'),
            enabled: !vm.submitting,
            isLoginIdentifier: true,
            onChanged: (_) => vm.edited('whatsapp_number'),
            onSubmitted: (_) => passwordFocus.requestFocus(),
          ),
          const SizedBox(height: AppSpace.lg),
          AppTextField(
            controller: password,
            focusNode: passwordFocus,
            trackId: 'login_password',
            label: l10n.fieldAppPassword,
            hint: l10n.fieldAppPasswordLoginHint,
            error: fieldError('app_password'),
            secret: true,
            enabled: !vm.submitting,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            onChanged: (_) => vm.edited('app_password'),
            onSubmitted: (_) => onSubmit(),
          ),
        ],
      ),
    );
  }
}

class _Banner extends StatelessWidget {
  const _Banner(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpace.lg),
    child: child,
  );
}

/// The form's shape while the country list loads.
class _FormSkeleton extends StatelessWidget {
  const _FormSkeleton();

  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SkeletonBox(width: 120),
      SizedBox(height: AppSpace.sm),
      SkeletonBox(height: 56, width: double.infinity, radius: AppRadius.md),
      SizedBox(height: AppSpace.lg),
      SkeletonBox(width: 100),
      SizedBox(height: AppSpace.sm),
      SkeletonBox(height: 56, width: double.infinity, radius: AppRadius.md),
    ],
  );
}
