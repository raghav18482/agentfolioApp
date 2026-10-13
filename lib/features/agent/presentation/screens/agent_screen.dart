import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/app/shell/tab_actions.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/responsive/window_size.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_icon_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_segmented.dart';
import 'package:agentfolio/core/presentation/widgets/empty_state.dart';
import 'package:agentfolio/core/presentation/widgets/error_view.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/features/agent/domain/agent_logic.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:agentfolio/features/agent/presentation/view_models/agent_chat_view_model.dart';
import 'package:agentfolio/features/agent/presentation/widgets/chat_message_view.dart';
import 'package:agentfolio/features/agent/presentation/widgets/threads_pane.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ai_widgets.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/trading/presentation/widgets/trade_approval.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

typedef AgentViewModelFactory = AgentChatViewModel Function(AgentType type);

/// The Agent tab: chat with the finance agent or, on Premium, the trading
/// agent. Each keeps its own conversation while the other is shown.
class AgentScreen extends StatefulWidget {
  const AgentScreen({required this.create, super.key, this.aboutSymbol, this.showAgent});

  final AgentViewModelFactory create;

  /// From "Ask the agent" on a stock: start a conversation about it.
  final String? aboutSymbol;

  /// From a link elsewhere (the Trade tab): open on this agent.
  final AgentType? showAgent;

  @override
  State<AgentScreen> createState() => _AgentScreenState();
}

class _AgentScreenState extends State<AgentScreen> {
  final _scaffold = GlobalKey<ScaffoldState>();
  final Map<AgentType, AgentChatViewModel> _vms = {};
  AgentType _type = AgentType.finance;
  String? _handledAbout;

  AgentChatViewModel _vmFor(AgentType type) => _vms.putIfAbsent(type, () {
    final vm = widget.create(type);
    unawaited(vm.load());
    return vm;
  });

  @override
  void initState() {
    super.initState();
    _applyAbout();
    _applyShowAgent();
  }

  @override
  void didUpdateWidget(AgentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _applyAbout();
    _applyShowAgent();
  }

  void _applyShowAgent() {
    final type = widget.showAgent;
    if (type == null) return;
    _type = type;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.go(Routes.agent);
    });
  }

  /// Opens a new finance conversation with a question about the stock ready
  /// to send, then drops the parameter so returning to the tab does not
  /// start another.
  void _applyAbout() {
    final symbol = widget.aboutSymbol;
    if (symbol == null) {
      _handledAbout = null; // asking about the same stock again starts afresh
      return;
    }
    if (symbol == _handledAbout) return;
    _handledAbout = symbol;
    _type = AgentType.finance;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      unawaited(_vmFor(AgentType.finance).prefill(l10n.agentAskAbout(symbol)));
      context.go(Routes.agent);
    });
  }

  @override
  void dispose() {
    for (final vm in _vms.values) {
      vm.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final premium = context.select<SessionProvider, bool>(
      (s) => s.signedIn?.user.premium.registered ?? false,
    );
    final locked = _type == AgentType.trading && !premium;
    final wide = WindowSize.of(context).twoPane;

    final chat = locked
        ? const _TradingLocked()
        : ChangeNotifierProvider<AgentChatViewModel>.value(
            value: _vmFor(_type),
            child: Builder(
              builder: (context) {
                final saved = context.select<AgentChatViewModel, bool>((v) => v.premium);
                final body = _ChatView(key: ValueKey(_type));
                if (!wide) return body;
                return Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: saved ? ThreadsPane(onPicked: () {}) : const _UnsavedPane(),
                    ),
                    VerticalDivider(width: 1, color: context.palette.border),
                    Expanded(child: body),
                  ],
                );
              },
            ),
          );

    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text(l10n.agentTitle),
        actions: [
          if (!locked) _ChatActions(vm: _vmFor(_type), wide: wide, scaffold: _scaffold),
          const TabActions(),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.sm),
            child: AppSegmented<AgentType>(
              trackId: 'agent_type',
              selected: _type,
              onChanged: (type) => setState(() => _type = type),
              segments: [
                AppSegment(value: AgentType.finance, label: l10n.agentFinance, id: 'finance'),
                AppSegment(value: AgentType.trading, label: l10n.agentTrading, id: 'trading'),
              ],
            ),
          ),
        ),
      ),
      endDrawer: wide || locked
          ? null
          : ChangeNotifierProvider<AgentChatViewModel>.value(
              value: _vmFor(_type),
              child: Drawer(
                child: ThreadsPane(onPicked: () => _scaffold.currentState?.closeEndDrawer()),
              ),
            ),
      body: chat,
    );
  }
}

/// New chat, and on phones the saved conversations.
class _ChatActions extends StatelessWidget {
  const _ChatActions({required this.vm, required this.wide, required this.scaffold});

  final AgentChatViewModel vm;
  final bool wide;
  final GlobalKey<ScaffoldState> scaffold;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!wide && vm.premium)
            AppIconButton(
              trackId: 'chat_threads_open',
              icon: Icons.history_rounded,
              tooltip: l10n.chatConversations,
              onPressed: () => scaffold.currentState?.openEndDrawer(),
            ),
          AppIconButton(
            trackId: 'chat_new',
            icon: Icons.edit_square,
            tooltip: l10n.chatNew,
            onPressed: vm.busy || !vm.ready ? null : () => unawaited(vm.newConversation()),
          ),
        ],
      ),
    );
  }
}

class _ChatView extends StatefulWidget {
  const _ChatView({super.key});

  @override
  State<_ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<_ChatView> {
  late final AgentChatViewModel _vm = context.read<AgentChatViewModel>();
  late final _controller = TextEditingController(text: _vm.draft);
  late int _draftVersion = _vm.draftVersion;
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text != _vm.draft) _vm.setDraft(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  /// Sends from the composer, a starter or "Send again". An approval places
  /// a real order, so it is confirmed first; cancelled, the text stays.
  Future<void> _submit(String raw) async {
    final text = raw.trim();
    if (text.isEmpty || _vm.busy) return;
    final command = _vm.type == AgentType.trading ? parseApprovalCommand(text) : null;
    if (command != null && command.verb == ApprovalVerb.approve) {
      // The same confirmation as the Approve button: the server places the
      // order the moment it reads this message.
      final confirmed = await confirmTradeApproval(context, proposalId: command.proposalId);
      if (!confirmed || !mounted) return;
    }
    if (_controller.text.trim() == text) _controller.clear();
    unawaited(_vm.send(text));
  }

  void _resend(String messageId) {
    final text = _vm.takeForResend(messageId);
    if (text != null) unawaited(_submit(text));
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<AgentChatViewModel>();
    // A prefill from elsewhere replaces what is in the composer.
    if (vm.draftVersion != _draftVersion) {
      _draftVersion = vm.draftVersion;
      _controller.value = TextEditingValue(
        text: vm.draft,
        selection: TextSelection.collapsed(offset: vm.draft.length),
      );
      WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
    }

    final messages = vm.messages;
    final Widget content = switch (vm.history) {
      _ when !vm.ready => const _ChatSkeleton(),
      ViewIdle() || ViewLoading() => const _ChatSkeleton(),
      ViewError(:final failure) => ErrorView(
        failure: failure,
        retryTrackId: 'chat_history_retry',
        onRetry: () => unawaited(vm.loadHistory(vm.activeThreadId!)),
      ),
      ViewData() when messages.isEmpty && !vm.answeringHere => _EmptyChat(
        type: vm.type,
        saved: vm.premium,
        onStarter: (prompt) => unawaited(_submit(prompt)),
      ),
      ViewData() => _MessageList(
        messages: messages,
        answering: vm.answeringHere,
        since: vm.busySince,
        actions: MessageActions(
          onResend: _resend,
          onCheckAgain: () => unawaited(vm.loadHistory(vm.activeThreadId!)),
          saved: vm.activeThreadId != null,
        ),
      ),
    };

    return Column(
      children: [
        Expanded(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: KeyedSubtree(
              key: ValueKey((vm.activeThreadId, vm.history.runtimeType, messages.isEmpty)),
              child: content,
            ),
          ),
        ),
        _Composer(
          controller: _controller,
          focusNode: _focus,
          type: vm.type,
          canSend: vm.ready && !vm.busy,
          onSend: () => unawaited(_submit(_controller.text)),
        ),
      ],
    );
  }
}

class _MessageList extends StatelessWidget {
  const _MessageList({
    required this.messages,
    required this.answering,
    required this.since,
    required this.actions,
  });

  final List<ChatMessage> messages;
  final bool answering;
  final DateTime? since;
  final MessageActions actions;

  @override
  Widget build(BuildContext context) {
    final extra = answering ? 1 : 0;
    // Reversed: the newest sits just above the composer, and the list stays
    // anchored there as replies arrive and the keyboard opens.
    return ListView.separated(
      reverse: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(AppSpace.page, AppSpace.lg, AppSpace.page, AppSpace.lg),
      itemCount: messages.length + extra,
      separatorBuilder: (_, _) => const SizedBox(height: AppSpace.lg),
      itemBuilder: (context, i) {
        if (answering && i == 0) return TypingIndicator(since: since);
        final message = messages[messages.length - 1 - (i - extra)];
        return ChatMessageView(key: ValueKey(message.id), message: message, actions: actions);
      },
    );
  }
}

class _EmptyChat extends StatelessWidget {
  const _EmptyChat({required this.type, required this.saved, required this.onStarter});

  final AgentType type;
  final bool saved;
  final ValueChanged<String> onStarter;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final starters = switch (type) {
      AgentType.finance => [
        (l10n.agentStarterHealth, l10n.agentStarterHealthPrompt),
        (l10n.agentStarterRisk, l10n.agentStarterRiskPrompt),
        (l10n.agentStarterLaggards, l10n.agentStarterLaggardsPrompt),
        (l10n.agentStarterExplain, l10n.agentStarterExplainPrompt),
      ],
      AgentType.trading => [
        (l10n.tradingStarterSuggest, l10n.tradingStarterSuggestPrompt),
        (l10n.tradingStarterAnalyze, l10n.tradingStarterAnalyzePrompt),
        (l10n.tradingStarterPending, l10n.tradingStarterPendingPrompt),
        (l10n.tradingStarterMargin, l10n.tradingStarterMarginPrompt),
      ],
    };

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(AppSpace.page, AppSpace.xxl, AppSpace.page, AppSpace.lg),
      children: [
        const Center(child: _BigAvatar()),
        const SizedBox(height: AppSpace.lg),
        Text(
          type == AgentType.finance ? l10n.agentEmptyTitle : l10n.tradingEmptyTitle,
          textAlign: TextAlign.center,
          style: context.text.titleLarge,
        ),
        const SizedBox(height: AppSpace.sm),
        Text(
          type == AgentType.finance ? l10n.agentEmptyBody : l10n.tradingEmptyBody,
          textAlign: TextAlign.center,
          style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary, height: 1.45),
        ),
        const SizedBox(height: AppSpace.xl),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: AppSpace.sm,
          runSpacing: AppSpace.sm,
          children: [
            for (final (i, (label, prompt)) in starters.indexed)
              ActionChip(
                avatar: const Icon(Icons.north_east_rounded, size: 16),
                label: Text(label),
                onPressed: () {
                  context.trackTap('chat_starter_${type.wire}_$i');
                  onStarter(prompt);
                },
              ),
          ],
        ),
        if (!saved) ...[
          const SizedBox(height: AppSpace.xl),
          Text(
            l10n.chatNotSaved,
            textAlign: TextAlign.center,
            style: context.text.labelMedium?.copyWith(color: context.palette.textMuted),
          ),
        ],
      ],
    );
  }
}

class _BigAvatar extends StatelessWidget {
  const _BigAvatar();

  @override
  Widget build(BuildContext context) => Container(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      gradient: AppColors.brandGradient,
      shape: BoxShape.circle,
      boxShadow: [BoxShadow(color: AppColors.brand.withValues(alpha: 0.35), blurRadius: 24)],
    ),
    child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 26),
  );
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.focusNode,
    required this.type,
    required this.canSend,
    required this.onSend,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final AgentType type;
  final bool canSend;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.palette.surface,
        border: Border(top: BorderSide(color: context.palette.border)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpace.page, AppSpace.sm, AppSpace.sm, AppSpace.sm),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (context, value, _) {
                  final length = value.text.trim().length;
                  final ready = canSend && length > 0 && length <= maxMessageLength;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          minLines: 1,
                          maxLines: 6,
                          maxLength: maxMessageLength,
                          // The count only once it matters.
                          buildCounter:
                              (context, {required currentLength, required isFocused, maxLength}) =>
                                  currentLength > maxMessageLength - 500
                                  ? Text('$currentLength / $maxLength')
                                  : null,
                          keyboardType: TextInputType.multiline,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: type == AgentType.finance
                                ? l10n.agentPlaceholder
                                : l10n.tradingPlaceholder,
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpace.xs),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 2),
                        child: IconButton.filled(
                          tooltip: l10n.chatSend,
                          onPressed: ready
                              ? () {
                                  context.trackTap('chat_send');
                                  onSend();
                                }
                              : null,
                          icon: const Icon(Icons.arrow_upward_rounded),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: AppSpace.xs),
              InkWell(
                onTap: () => showResponsibleAi(context),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppSpace.xs),
                  child: Text(
                    type == AgentType.finance ? l10n.agentFootnote : l10n.tradingFootnote,
                    style: context.text.labelSmall?.copyWith(
                      color: context.palette.textMuted,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatSkeleton extends StatelessWidget {
  const _ChatSkeleton();

  @override
  Widget build(BuildContext context) => Shimmer(
    child: ListView(
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpace.page),
      children: [
        for (final (mine, width) in const [(false, 0.8), (true, 0.5), (false, 0.7), (true, 0.4)])
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpace.lg),
            child: Align(
              alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: width,
                child: SkeletonBox(height: mine ? 40 : 72),
              ),
            ),
          ),
      ],
    ),
  );
}

class _UnsavedPane extends StatelessWidget {
  const _UnsavedPane();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(AppSpace.lg),
    child: Text(
      AppLocalizations.of(context).chatSavedIsPremium,
      style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary, height: 1.45),
    ),
  );
}

class _TradingLocked extends StatelessWidget {
  const _TradingLocked();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return EmptyState(
      icon: Icons.lock_outline_rounded,
      title: l10n.tradingLockedTitle,
      message: l10n.tradingLockedBody,
      action: AppButton(
        trackId: 'trading_locked_go_trade',
        label: l10n.tradingLockedAction,
        variant: AppButtonVariant.secondary,
        onPressed: () => context.go(Routes.trade),
      ),
    );
  }
}
