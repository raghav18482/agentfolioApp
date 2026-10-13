import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/features/ai/presentation/providers/ai_key_provider.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ai_widgets.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ask_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Quick questions about the portfolio. Each opens the Ask sheet, where the
/// answer arrives and follow-ups can be asked.
class AskAiCard extends StatelessWidget {
  const AskAiCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (ready, hasKey) = context.select<AiKeyProvider, (bool, bool)>(
      (p) => (p.isReady, p.hasKey),
    );

    return SectionCard(
      title: l10n.askTitle,
      subtitle: l10n.askSubtitle,
      onInfo: () => showResponsibleAi(context),
      infoTrackId: 'ask_info',
      child: !ready
          ? const SkeletonBox(width: double.infinity, height: 72)
          : !hasKey
          ? AiKeyNeeded(message: l10n.askNeedKey, trackId: 'ask_set_up')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: AppSpace.sm,
                  runSpacing: AppSpace.sm,
                  children: [
                    for (final (i, question) in askStarters(l10n).indexed)
                      ActionChip(
                        label: Text(question),
                        onPressed: () => unawaited(
                          showAskSheet(context, question: question, trackId: 'ask_starter_$i'),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppSpace.md),
                AppButton(
                  trackId: 'ask_own',
                  label: l10n.askOwn,
                  icon: Icons.edit_outlined,
                  variant: AppButtonVariant.secondary,
                  onPressed: () => unawaited(showAskSheet(context, trackId: 'ask_own_open')),
                ),
              ],
            ),
    );
  }
}
