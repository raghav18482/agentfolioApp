import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_text_field.dart';
import 'package:agentfolio/core/presentation/widgets/confirm_sheet.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/features/ai/domain/entities/ai.dart';
import 'package:agentfolio/features/ai/presentation/providers/ai_key_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Where the user's OpenRouter key is saved and the model chosen. Insights
/// and Ask read both from here; the agent and stock summaries need neither.
class AiSettingsScreen extends StatelessWidget {
  const AiSettingsScreen({super.key});

  static final Uri openRouterKeys = Uri.parse('https://openrouter.ai/keys');

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.aiSettingsTitle)),
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
              l10n.aiSettingsIntro,
              style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpace.lg),
            const _KeyCard(),
            const SizedBox(height: AppSpace.lg),
            const _ModelCard(),
            const SizedBox(height: AppSpace.lg),
            const _HowKeyIsKept(),
          ],
        ),
      ),
    );
  }
}

class _KeyCard extends StatefulWidget {
  const _KeyCard();

  @override
  State<_KeyCard> createState() => _KeyCardState();
}

class _KeyCardState extends State<_KeyCard> {
  final _controller = TextEditingController();
  String? _error;
  bool _saving = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _problemText(AppLocalizations l10n, KeyProblem? problem) => switch (problem) {
    null => null,
    KeyProblem.empty => l10n.aiKeyEmpty,
    KeyProblem.whitespace => l10n.aiKeyWhitespace,
    KeyProblem.tooShort => l10n.aiKeyTooShort,
  };

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final problem = AiKeyRules.check(_controller.text);
    if (problem != null) {
      setState(() => _error = _problemText(l10n, problem));
      return;
    }
    setState(() {
      _error = null;
      _saving = true;
    });
    final messenger = ScaffoldMessenger.of(context);
    try {
      await context.read<AiKeyProvider>().saveKey(_controller.text);
      _controller.clear();
      FocusManager.instance.primaryFocus?.unfocus();
      messenger.showSnackBar(SnackBar(content: Text(l10n.aiKeySaved)));
    } on Object {
      messenger.showSnackBar(SnackBar(content: Text(l10n.aiKeySaveFailed)));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _remove() async {
    final l10n = AppLocalizations.of(context);
    final provider = context.read<AiKeyProvider>();
    final confirmed = await showConfirmSheet(
      context,
      trackId: 'ai_key_remove',
      title: l10n.aiKeyRemoveTitle,
      message: l10n.aiKeyRemoveBody,
      confirmLabel: l10n.aiKeyRemove,
      destructive: true,
    );
    if (confirmed) await provider.removeKey();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasKey = context.select<AiKeyProvider, bool>((p) => p.hasKey);
    final text = _controller.text;
    final unusual = text.trim().isNotEmpty && !AiKeyRules.looksLikeOpenRouter(text);

    return SectionCard(
      title: l10n.aiKeyTitle,
      trailing: StatusChip(
        hasKey ? l10n.aiKeyStatusSaved : l10n.aiKeyStatusMissing,
        color: hasKey ? AppColors.emerald : AppColors.textMuted,
        icon: hasKey ? Icons.lock_rounded : Icons.lock_open_rounded,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppTextField(
            controller: _controller,
            label: hasKey ? l10n.aiKeyReplaceLabel : l10n.aiKeyLabel,
            hint: 'sk-or-v1-…',
            helper: unusual ? l10n.aiKeyUnusualPrefix : null,
            error: _error,
            secret: true,
            pasteable: true,
            trackId: 'ai_key_field',
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            onChanged: (_) => setState(() => _error = null),
            onSubmitted: (_) => unawaited(_save()),
          ),
          const SizedBox(height: AppSpace.md),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  trackId: 'ai_key_save',
                  label: hasKey ? l10n.aiKeyReplace : l10n.aiKeySave,
                  icon: Icons.lock_outline_rounded,
                  loading: _saving,
                  onPressed: text.trim().isEmpty ? null : () => unawaited(_save()),
                ),
              ),
              if (hasKey) ...[
                const SizedBox(width: AppSpace.md),
                AppButton(
                  trackId: 'ai_key_remove_open',
                  label: l10n.aiKeyRemove,
                  variant: AppButtonVariant.secondary,
                  onPressed: () => unawaited(_remove()),
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpace.sm),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                context.trackTap('ai_key_get');
                unawaited(
                  context.read<LinkOpener>().open(
                    AiSettingsScreen.openRouterKeys,
                    id: 'openrouter_keys',
                  ),
                );
              },
              icon: const Icon(Icons.open_in_new_rounded, size: 16),
              label: Text(l10n.aiKeyGet),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModelCard extends StatefulWidget {
  const _ModelCard();

  @override
  State<_ModelCard> createState() => _ModelCardState();
}

class _ModelCardState extends State<_ModelCard> {
  late final TextEditingController _custom;
  late bool _customMode;
  String? _error;

  @override
  void initState() {
    super.initState();
    final current = context.read<AiKeyProvider>().model;
    _customMode = !AiModels.presets.contains(current);
    _custom = TextEditingController(text: _customMode ? current : '');
  }

  @override
  void dispose() {
    _custom.dispose();
    super.dispose();
  }

  void _pick(String model) {
    context.trackChange('ai_model', model);
    setState(() {
      _customMode = false;
      _error = null;
    });
    unawaited(context.read<AiKeyProvider>().setModel(model));
  }

  void _applyCustom() {
    final id = _custom.text.trim();
    if (!AiModels.isValidId(id)) {
      setState(() => _error = AppLocalizations.of(context).aiModelInvalid);
      return;
    }
    setState(() => _error = null);
    context.trackChange('ai_model', 'custom');
    unawaited(context.read<AiKeyProvider>().setModel(id));
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final model = context.select<AiKeyProvider, String>((p) => p.model);

    return SectionCard(
      title: l10n.aiModelTitle,
      subtitle: l10n.aiModelSubtitle,
      padding: const EdgeInsets.symmetric(vertical: AppSpace.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final preset in AiModels.presets)
            _ModelOption(
              label: preset,
              selected: !_customMode && model == preset,
              onTap: () => _pick(preset),
            ),
          _ModelOption(
            label: l10n.aiModelOther,
            selected: _customMode,
            onTap: () => setState(() => _customMode = true),
          ),
          if (_customMode)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpace.lg,
                AppSpace.sm,
                AppSpace.lg,
                AppSpace.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AppTextField(
                    controller: _custom,
                    label: l10n.aiModelCustomLabel,
                    hint: 'provider/model-id',
                    helper: model == _custom.text.trim() ? l10n.aiModelInUse : null,
                    error: _error,
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _applyCustom(),
                    onChanged: (_) => setState(() => _error = null),
                  ),
                  const SizedBox(height: AppSpace.sm),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AppButton(
                      trackId: 'ai_model_custom_use',
                      label: l10n.aiModelUse,
                      size: AppButtonSize.medium,
                      variant: AppButtonVariant.secondary,
                      onPressed: _applyCustom,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ModelOption extends StatelessWidget {
  const _ModelOption({required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    button: true,
    child: InkWell(
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg, vertical: AppSpace.sm),
          child: Row(
            children: [
              Icon(
                selected ? Icons.radio_button_checked_rounded : Icons.radio_button_off_rounded,
                size: 20,
                color: selected ? AppColors.brandSoft : AppColors.textMuted,
              ),
              const SizedBox(width: AppSpace.md),
              Expanded(
                child: Text(
                  label,
                  style: context.text.bodyMedium?.copyWith(
                    color: selected ? AppColors.textPrimary : AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _HowKeyIsKept extends StatelessWidget {
  const _HowKeyIsKept();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpace.lg),
      decoration: BoxDecoration(
        borderRadius: AppRadius.card,
        border: Border.all(color: context.palette.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.shield_outlined, size: 18, color: AppColors.textMuted),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: Text(l10n.aiKeyHowKept, style: context.text.bodySmall?.copyWith(height: 1.5)),
          ),
        ],
      ),
    );
  }
}
