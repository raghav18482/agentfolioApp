import 'dart:async';

import 'package:agentfolio/core/platform/link_opener.dart';
import 'package:agentfolio/core/presentation/privacy/privacy_provider.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/utils/amount_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:provider/provider.dart';

/// Markdown written by a model: summaries, insights, agent replies.
///
/// * Links open only when they are plain web links. Model output is not
///   trusted to choose a scheme (`tel:`, `intent:`, an app's deep link).
/// * With "Hide balances" on, rupee amounts in the text are masked too.
class AiMarkdown extends StatelessWidget {
  const AiMarkdown(this.data, {required this.linkTrackId, super.key, this.selectable = true});

  final String data;

  /// Telemetry id for a tapped link. The URL itself is never recorded.
  final String linkTrackId;
  final bool selectable;

  @override
  Widget build(BuildContext context) {
    final hidden = context.select<PrivacyProvider, bool>((p) => p.hideBalances);
    return MarkdownBody(
      data: hidden ? AmountMask.apply(data) : data,
      selectable: selectable,
      styleSheet: aiMarkdownStyle(context),
      onTapLink: (text, href, title) {
        final uri = href == null ? null : Uri.tryParse(href);
        if (uri != null && (uri.isScheme('https') || uri.isScheme('http'))) {
          unawaited(context.read<LinkOpener>().open(uri, id: linkTrackId));
        }
      },
    );
  }
}

MarkdownStyleSheet aiMarkdownStyle(BuildContext context) {
  final body = context.text.bodyMedium?.copyWith(height: 1.55, color: AppColors.textPrimary);
  return MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
    p: body,
    listBullet: body,
    strong: body?.copyWith(fontWeight: FontWeight.w700),
    h1: context.text.titleLarge,
    h2: context.text.titleMedium,
    h3: context.text.titleSmall,
    a: body?.copyWith(color: AppColors.brandSoft),
    blockSpacing: AppSpace.md,
    tableBody: context.text.bodySmall,
    tableHead: context.text.bodySmall?.copyWith(fontWeight: FontWeight.w700),
    tableBorder: TableBorder.all(color: context.palette.border),
    tableCellsPadding: const EdgeInsets.symmetric(horizontal: AppSpace.sm, vertical: AppSpace.xs),
    code: context.text.bodySmall?.copyWith(
      fontFamily: 'monospace',
      backgroundColor: AppColors.surfaceRaised,
    ),
    codeblockDecoration: BoxDecoration(
      color: context.palette.surfaceRaised,
      borderRadius: AppRadius.card,
    ),
    blockquoteDecoration: BoxDecoration(
      color: context.palette.surfaceRaised,
      border: const Border(left: BorderSide(color: AppColors.brandSoft, width: 3)),
    ),
  );
}
