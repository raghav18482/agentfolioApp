import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/broker/broker_registry.dart';
import 'package:agentfolio/core/config/env.dart';
import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_tile.dart';
import 'package:agentfolio/core/presentation/widgets/confirm_sheet.dart';
import 'package:agentfolio/core/presentation/widgets/info_sheet.dart';
import 'package:agentfolio/core/security/app_lock.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:agentfolio/features/accounts/domain/entities/broker_account.dart';
import 'package:agentfolio/features/ai/presentation/providers/ai_key_provider.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

/// Account: the linked broker, AI, privacy and security, guides, legal,
/// sign-out and account deletion.
class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final session = context.read<SessionProvider>();
    final confirmed = await showConfirmSheet(
      context,
      trackId: 'logout',
      title: l10n.accountLogoutTitle,
      message: l10n.accountLogoutBody,
      confirmLabel: l10n.accountLogout,
      destructive: true,
    );
    // Signing out flips the session; the router then shows Login.
    if (confirmed) await session.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final account = context.select<SessionProvider, BrokerAccount?>((s) => s.activeAccount);
    final broker = account == null
        ? null
        : context.read<BrokerRegistry>().resolve(account.brokerId);
    final env = context.read<Env>();
    final links = context.read<LinkOpener>();

    return Scaffold(
      appBar: AppBar(title: Text(l10n.accountTitle)),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
        children: [
          if (account != null && broker != null) ...[
            _SectionLabel(l10n.accountLinkedBroker),
            AppTile(
              trackId: 'account_linked_broker',
              icon: Icons.account_balance_rounded,
              iconColor: AppColors.emerald,
              title: broker.displayName,
              subtitle: account.clientCode,
              onTap: null,
            ),
          ],
          _SectionLabel(l10n.accountAi),
          const _AiTile(),
          _SectionLabel(l10n.accountPrivacy),
          const _PrivacyTiles(),
          _SectionLabel(l10n.accountGuides),
          AppTile(
            trackId: 'account_setup_guide',
            icon: Icons.menu_book_rounded,
            title: l10n.accountSetupGuide,
            subtitle: l10n.accountSetupGuideHint,
            trailing: const Icon(Icons.open_in_new_rounded, size: 18, color: AppColors.textMuted),
            onTap: () => unawaited(links.open(env.webPage('/setup'), id: 'setup_guide')),
          ),
          AppTile(
            trackId: 'account_connect_mcp',
            icon: Icons.hub_outlined,
            title: l10n.accountConnectMcp,
            subtitle: l10n.accountConnectMcpHint,
            trailing: const Icon(Icons.open_in_new_rounded, size: 18, color: AppColors.textMuted),
            onTap: () => unawaited(links.open(env.webPage('/connect'), id: 'connect_mcp')),
          ),
          AppTile(
            trackId: 'account_learn',
            icon: Icons.school_outlined,
            iconColor: AppColors.sky,
            title: l10n.accountLearn,
            subtitle: l10n.accountLearnHint,
            onTap: () => unawaited(context.push(Routes.learn)),
          ),
          _SectionLabel(l10n.accountLegal),
          if (env.privacyUrl case final url?)
            _LinkTile(
              trackId: 'legal_privacy',
              title: l10n.legalPrivacy,
              url: url,
              icon: Icons.privacy_tip_outlined,
            ),
          if (env.termsUrl case final url?)
            _LinkTile(
              trackId: 'legal_terms',
              title: l10n.legalTerms,
              url: url,
              icon: Icons.gavel_rounded,
            ),
          AppTile(
            trackId: 'legal_risk',
            icon: Icons.gpp_maybe_outlined,
            title: l10n.legalRisk,
            onTap: () => unawaited(
              showInfoSheet(
                context,
                title: Disclaimers.tradingRiskTitle,
                body: Disclaimers.tradingRiskPoints.map((p) => '• $p').join('\n\n'),
              ),
            ),
          ),
          AppTile(
            trackId: 'legal_ai',
            icon: Icons.shield_outlined,
            title: Disclaimers.responsibleAiEyebrow,
            onTap: () => unawaited(
              showInfoSheet(
                context,
                title: Disclaimers.responsibleAiTitle,
                body: '${Disclaimers.responsibleAiBody}\n\n${Disclaimers.responsibleAiFineprint}',
              ),
            ),
          ),
          AppTile(
            trackId: 'legal_licences',
            icon: Icons.code_rounded,
            title: l10n.legalLicences,
            onTap: () => showLicensePage(context: context, applicationName: l10n.appName),
          ),
          const SizedBox(height: AppSpace.lg),
          Divider(color: context.palette.border),
          AppTile(
            trackId: 'account_logout',
            icon: Icons.logout_rounded,
            title: l10n.accountLogout,
            destructive: true,
            trailing: const SizedBox.shrink(),
            onTap: () => unawaited(_logout(context)),
          ),
          AppTile(
            trackId: 'account_delete',
            icon: Icons.delete_forever_outlined,
            title: l10n.deleteTitle,
            subtitle: l10n.deleteTileHint,
            destructive: true,
            onTap: () => unawaited(context.push(Routes.deleteAccount)),
          ),
          const _VersionLabel(),
        ],
      ),
    );
  }
}

class _PrivacyTiles extends StatefulWidget {
  const _PrivacyTiles();

  @override
  State<_PrivacyTiles> createState() => _PrivacyTilesState();
}

class _PrivacyTilesState extends State<_PrivacyTiles> {
  late bool _analytics = context.read<Prefs>().analyticsEnabled;

  Future<void> _setLock(bool on) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final result = await context.read<AppLock>().setEnabled(
      enabled: on,
      reason: l10n.lockEnableReason,
    );
    if (result == EnableResult.noScreenLock) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.lockNeedsScreenLock)));
    }
  }

  void _setAnalytics(bool on) {
    setState(() => _analytics = on);
    context.read<Telemetry>().analyticsEnabled = on;
    unawaited(context.read<Prefs>().setAnalyticsEnabled(enabled: on));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hidden = context.select<PrivacyProvider, bool>((p) => p.hideBalances);
    final locked = context.select<AppLock, bool>((l) => l.enabled);
    return Column(
      children: [
        AppSwitchTile(
          trackId: 'privacy_hide_balances',
          title: l10n.privacyHideBalances,
          subtitle: l10n.privacyHideBalancesHint,
          value: hidden,
          onChanged: (_) => context.read<PrivacyProvider>().toggle(),
        ),
        AppSwitchTile(
          trackId: 'privacy_app_lock',
          title: l10n.lockSetting,
          subtitle: l10n.lockSettingHint,
          value: locked,
          onChanged: (on) => unawaited(_setLock(on)),
        ),
        AppSwitchTile(
          trackId: 'privacy_analytics',
          title: l10n.privacyAnalytics,
          subtitle: l10n.privacyAnalyticsHint,
          value: _analytics,
          onChanged: _setAnalytics,
        ),
      ],
    );
  }
}

class _LinkTile extends StatelessWidget {
  const _LinkTile({
    required this.trackId,
    required this.title,
    required this.url,
    required this.icon,
  });

  final String trackId;
  final String title;
  final Uri url;
  final IconData icon;

  @override
  Widget build(BuildContext context) => AppTile(
    trackId: trackId,
    icon: icon,
    title: title,
    trailing: const Icon(Icons.open_in_new_rounded, size: 18, color: AppColors.textMuted),
    onTap: () => unawaited(context.read<LinkOpener>().open(url, id: trackId)),
  );
}

class _AiTile extends StatelessWidget {
  const _AiTile();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (hasKey, model) = context.select<AiKeyProvider, (bool, String)>(
      (p) => (p.hasKey, p.model),
    );
    return AppTile(
      trackId: 'account_ai',
      icon: Icons.auto_awesome_outlined,
      iconColor: AppColors.brandSoft,
      title: l10n.accountAiKey,
      subtitle: hasKey ? l10n.accountAiKeySaved(model) : l10n.accountAiKeyMissing,
      onTap: () => unawaited(context.push(Routes.aiSettings)),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(AppSpace.lg, AppSpace.lg, AppSpace.lg, AppSpace.xs),
    child: Text(text.toUpperCase(), style: context.text.labelSmall),
  );
}

class _VersionLabel extends StatelessWidget {
  const _VersionLabel();

  @override
  Widget build(BuildContext context) => FutureBuilder<PackageInfo>(
    future: PackageInfo.fromPlatform(),
    builder: (context, snapshot) {
      final info = snapshot.data;
      if (info == null) return const SizedBox(height: AppSpace.xxl);
      return Padding(
        padding: const EdgeInsets.all(AppSpace.xl),
        child: Text(
          AppLocalizations.of(context).accountVersion('${info.version} (${info.buildNumber})'),
          textAlign: TextAlign.center,
          style: context.text.bodySmall?.copyWith(color: AppColors.textMuted),
        ),
      );
    },
  );
}
