import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/ai_markdown.dart';
import 'package:agentfolio/core/presentation/widgets/app_alert.dart';
import 'package:agentfolio/core/presentation/widgets/app_icon_button.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/features/agent/domain/agent_logic.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// What the user can do about a message that did not get an answer.
class MessageActions {
  const MessageActions({required this.onResend, required this.onCheckAgain, required this.saved});

  final void Function(String messageId) onResend;
  final VoidCallback onCheckAgain;

  /// The conversation is saved, so the server can say what happened.
  final bool saved;
}

class ChatMessageView extends StatelessWidget {
  const ChatMessageView({required this.message, required this.actions, super.key});

  final ChatMessage message;
  final MessageActions actions;

  @override
  Widget build(BuildContext context) => switch (message.role) {
    ChatRole.user => _UserMessage(message: message, actions: actions),
    ChatRole.assistant => _AssistantMessage(message: message),
  };
}

class _UserMessage extends StatelessWidget {
  const _UserMessage({required this.message, required this.actions});

  final ChatMessage message;
  final MessageActions actions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final maxWidth = MediaQuery.sizeOf(context).width * 0.8;
    final failed = message.delivery == Delivery.failed;
    final unknown = message.delivery == Delivery.unknown;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Semantics(
            label: l10n.chatYouSaid,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg, vertical: AppSpace.md),
              decoration: BoxDecoration(
                color: failed ? AppColors.brand.withValues(alpha: 0.45) : AppColors.brand,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: SelectableText(
                message.text,
                style: context.text.bodyMedium?.copyWith(color: Colors.white, height: 1.4),
              ),
            ),
          ),
        ),
        if (failed || unknown)
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth),
            child: _DeliveryNote(message: message, actions: actions),
          ),
      ],
    );
  }
}

/// Under a message that got no answer: what happened, in plain words, and
/// the one safe thing to do next.
class _DeliveryNote extends StatelessWidget {
  const _DeliveryNote({required this.message, required this.actions});

  final ChatMessage message;
  final MessageActions actions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isApproval = parseApprovalCommand(message.text) != null;
    final failed = message.delivery == Delivery.failed;

    final (String note, String? action, VoidCallback? onAction, Color color) = switch (true) {
      _ when failed => (
        message.failure ?? l10n.chatNotSent,
        l10n.chatSendAgain,
        () => actions.onResend(message.id),
        AppColors.loss,
      ),
      // Unknown, saved: the server has the message and is still answering.
      _ when actions.saved => (
        l10n.chatStillWorking,
        l10n.chatCheckAgain,
        actions.onCheckAgain,
        AppColors.warning,
      ),
      // Unknown, unsaved, an approval: resending could act twice.
      _ when isApproval => (l10n.chatApprovalUnknown, null, null, AppColors.warning),
      _ => (
        l10n.chatLostConnection,
        l10n.chatSendAgain,
        () => actions.onResend(message.id),
        AppColors.warning,
      ),
    };

    return Padding(
      padding: const EdgeInsets.only(top: AppSpace.xs),
      child: Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpace.sm,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                failed ? Icons.error_outline_rounded : Icons.schedule_rounded,
                size: 14,
                color: color,
              ),
              const SizedBox(width: AppSpace.xs),
              Flexible(
                child: Text(
                  note,
                  textAlign: TextAlign.end,
                  style: context.text.labelMedium?.copyWith(color: color),
                ),
              ),
            ],
          ),
          if (action != null && onAction != null)
            TextButton(
              onPressed: () {
                context.trackTap(failed ? 'chat_send_again' : 'chat_check_again');
                onAction();
              },
              style: TextButton.styleFrom(
                minimumSize: const Size(48, 36),
                padding: const EdgeInsets.symmetric(horizontal: AppSpace.sm),
              ),
              child: Text(action),
            ),
        ],
      ),
    );
  }
}

class _AssistantMessage extends StatelessWidget {
  const _AssistantMessage({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AgentAvatar(),
        const SizedBox(width: AppSpace.md),
        Expanded(
          child: Semantics(
            label: l10n.chatAgentSaid,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.approvalResult case final result?) ...[
                  AppAlert(
                    variant: AppAlertVariant.info,
                    icon: Icons.receipt_long_rounded,
                    message: result,
                  ),
                  const SizedBox(height: AppSpace.md),
                ],
                AiMarkdown(message.text, linkTrackId: 'chat_link'),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppIconButton(
                    trackId: 'chat_copy',
                    icon: Icons.copy_rounded,
                    tooltip: l10n.chatCopy,
                    color: context.palette.textMuted,
                    onPressed: () {
                      unawaited(Clipboard.setData(ClipboardData(text: message.text)));
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(content: Text(l10n.chatCopied)));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// The agent's mark beside its replies.
class AgentAvatar extends StatelessWidget {
  const AgentAvatar({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: 30,
    height: 30,
    decoration: const BoxDecoration(gradient: AppColors.brandGradient, shape: BoxShape.circle),
    child: const Icon(Icons.auto_awesome_rounded, size: 16, color: Colors.white),
  );
}

/// The agent at work: three dots, then how long it has been, since a reply
/// that checks live data can take a minute or more.
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({required this.since, super.key});

  final DateTime? since;

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator> with SingleTickerProviderStateMixin {
  late final _dots = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200));
  Timer? _tick;

  @override
  void initState() {
    super.initState();
    _tick = Timer.periodic(const Duration(seconds: 1), (_) => setState(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Respect reduce motion: still dots, the timer text is enough.
    if (MediaQuery.disableAnimationsOf(context)) {
      _dots.stop();
    } else if (!_dots.isAnimating) {
      _dots.repeat();
    }
  }

  @override
  void dispose() {
    _tick?.cancel();
    _dots.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final since = widget.since;
    final seconds = since == null ? 0 : DateTime.now().difference(since).inSeconds;
    final label = seconds < 8
        ? l10n.chatThinking
        : seconds < 45
        ? l10n.chatWorkingFor(seconds)
        : l10n.chatWorkingLong(seconds);

    return Semantics(
      liveRegion: true,
      label: label,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AgentAvatar(),
          const SizedBox(width: AppSpace.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpace.lg,
                    vertical: AppSpace.md,
                  ),
                  decoration: BoxDecoration(
                    color: context.palette.surfaceRaised,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: AnimatedBuilder(
                    animation: _dots,
                    builder: (context, _) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (var i = 0; i < 3; i++) ...[
                          if (i > 0) const SizedBox(width: 5),
                          Opacity(opacity: _dotOpacity(i), child: const _Dot()),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.xs),
                ExcludeSemantics(
                  child: Text(
                    label,
                    style: context.text.labelMedium?.copyWith(color: context.palette.textMuted),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  double _dotOpacity(int i) {
    final t = (_dots.value - i * 0.15) % 1.0;
    return 0.3 + 0.7 * (t < 0.5 ? t * 2 : (1 - t) * 2);
  }
}

class _Dot extends StatelessWidget {
  const _Dot();

  @override
  Widget build(BuildContext context) => const SizedBox.square(
    dimension: 7,
    child: DecoratedBox(
      decoration: BoxDecoration(color: AppColors.textSecondary, shape: BoxShape.circle),
    ),
  );
}
