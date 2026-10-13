import 'dart:async';

import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/app_text_field.dart';
import 'package:agentfolio/core/presentation/widgets/confirm_sheet.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/presentation/widgets/skeleton.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:agentfolio/features/agent/domain/agent_logic.dart';
import 'package:agentfolio/features/agent/domain/entities/agent.dart';
import 'package:agentfolio/features/agent/presentation/view_models/agent_chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Saved conversations: a drawer on phones, a side pane on tablets.
class ThreadsPane extends StatelessWidget {
  const ThreadsPane({required this.onPicked, super.key});

  /// After a conversation is picked or started; closes the drawer.
  final VoidCallback onPicked;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<AgentChatViewModel>();

    return SafeArea(
      right: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.lg, AppSpace.lg, AppSpace.lg, AppSpace.sm),
            child: Row(
              children: [
                Expanded(child: Text(l10n.chatConversations, style: context.text.titleMedium)),
                AppButton(
                  trackId: 'chat_threads_new',
                  label: l10n.chatNew,
                  icon: Icons.add_rounded,
                  size: AppButtonSize.medium,
                  variant: AppButtonVariant.secondary,
                  onPressed: vm.busy
                      ? null
                      : () {
                          unawaited(vm.newConversation());
                          onPicked();
                        },
                ),
              ],
            ),
          ),
          Expanded(
            child: !vm.premium && vm.ready
                ? _Note(l10n.chatSavedIsPremium)
                : switch (vm.threads.state) {
                    ViewIdle() || ViewLoading() => const _ListSkeleton(),
                    ViewError(:final failure) => Padding(
                      padding: const EdgeInsets.all(AppSpace.lg),
                      child: SectionFailure(
                        failure: failure,
                        retryTrackId: 'chat_threads_retry',
                        onRetry: () => unawaited(vm.threads.load(force: true)),
                      ),
                    ),
                    ViewData(:final data) when data.threads.isEmpty => _Note(l10n.chatNoThreads),
                    ViewData(:final data) => RefreshIndicator(
                      onRefresh: () => vm.threads.load(force: true),
                      child: _ThreadList(threads: data.threads, onPicked: onPicked),
                    ),
                  },
          ),
        ],
      ),
    );
  }
}

class _ThreadList extends StatelessWidget {
  const _ThreadList({required this.threads, required this.onPicked});

  final List<ChatThread> threads;
  final VoidCallback onPicked;

  String _label(AppLocalizations l10n, ThreadAge age) => switch (age) {
    ThreadAge.today => l10n.chatToday,
    ThreadAge.yesterday => l10n.chatYesterday,
    ThreadAge.thisWeek => l10n.chatThisWeek,
    ThreadAge.older => l10n.chatOlder,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final groups = groupThreads(threads, DateTime.now());
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: AppSpace.xl),
      children: [
        for (final (age, list) in groups) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.lg, AppSpace.lg, AppSpace.lg, AppSpace.xs),
            child: Text(_label(l10n, age).toUpperCase(), style: context.text.labelSmall),
          ),
          for (final thread in list) _ThreadTile(thread: thread, onPicked: onPicked),
        ],
      ],
    );
  }
}

enum _ThreadAction { rename, delete }

class _ThreadTile extends StatelessWidget {
  const _ThreadTile({required this.thread, required this.onPicked});

  final ChatThread thread;
  final VoidCallback onPicked;

  Future<void> _rename(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<AgentChatViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    final title = await showRenameSheet(context, current: thread.title);
    if (title == null || title == thread.title) return;
    final result = await vm.rename(thread.id, title);
    if (result case Err(:final failure)) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.chatRenameFailed(failure.message))));
    }
  }

  Future<void> _delete(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<AgentChatViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showConfirmSheet(
      context,
      trackId: 'chat_thread_delete',
      title: l10n.chatDeleteTitle,
      message: l10n.chatDeleteBody(thread.title),
      confirmLabel: l10n.chatDelete,
      destructive: true,
    );
    if (!confirmed) return;
    final result = await vm.delete(thread.id);
    if (result case Err(:final failure)) {
      messenger.showSnackBar(SnackBar(content: Text(l10n.chatDeleteFailed(failure.message))));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<AgentChatViewModel>();
    final active = context.select<AgentChatViewModel, bool>((v) => v.activeThreadId == thread.id);
    final at = thread.updatedAt ?? thread.createdAt;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.sm),
      child: Material(
        color: active ? AppColors.brandSoft.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: AppRadius.card,
        child: InkWell(
          borderRadius: AppRadius.card,
          onTap: () {
            context.trackTap('chat_thread_open');
            vm.openThread(thread.id);
            onPicked();
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.md, AppSpace.sm, 0, AppSpace.sm),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        thread.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.text.bodyMedium?.copyWith(
                          color: active ? AppColors.textPrimary : AppColors.textSecondary,
                          fontWeight: active ? FontWeight.w600 : null,
                        ),
                      ),
                      if (at != null)
                        Text(
                          Times.relative(at),
                          style: context.text.labelSmall?.copyWith(
                            color: context.palette.textMuted,
                            letterSpacing: 0,
                          ),
                        ),
                    ],
                  ),
                ),
                PopupMenuButton<_ThreadAction>(
                  tooltip: l10n.chatThreadMenu,
                  icon: const Icon(Icons.more_horiz_rounded, size: 20),
                  onSelected: (action) => unawaited(switch (action) {
                    _ThreadAction.rename => _rename(context),
                    _ThreadAction.delete => _delete(context),
                  }),
                  itemBuilder: (context) => [
                    PopupMenuItem(value: _ThreadAction.rename, child: Text(l10n.chatRename)),
                    PopupMenuItem(
                      value: _ThreadAction.delete,
                      child: Text(l10n.chatDelete, style: const TextStyle(color: AppColors.loss)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Asks for a conversation's new name. Null when cancelled.
Future<String?> showRenameSheet(BuildContext context, {required String current}) =>
    showModalBottomSheet<String>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (context) => _RenameSheet(current: current),
    );

class _RenameSheet extends StatefulWidget {
  const _RenameSheet({required this.current});

  final String current;

  @override
  State<_RenameSheet> createState() => _RenameSheetState();
}

class _RenameSheetState extends State<_RenameSheet> {
  late final _controller = TextEditingController(text: widget.current);

  /// The server keeps the first 120 characters.
  static const _maxLength = 120;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final title = _controller.text.trim();
    if (title.isEmpty) return;
    Navigator.of(context).pop(title.length > _maxLength ? title.substring(0, _maxLength) : title);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpace.page,
        0,
        AppSpace.page,
        AppSpace.xl + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l10n.chatRenameTitle, style: context.text.titleLarge),
          const SizedBox(height: AppSpace.lg),
          AppTextField(
            controller: _controller,
            label: l10n.chatRenameLabel,
            textCapitalization: TextCapitalization.sentences,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _save(),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpace.lg),
          AppButton(
            trackId: 'chat_rename_save',
            label: l10n.commonSave,
            onPressed: _controller.text.trim().isEmpty ? null : _save,
          ),
        ],
      ),
    );
  }
}

class _Note extends StatelessWidget {
  const _Note(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(AppSpace.lg),
    child: Text(
      text,
      style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary, height: 1.45),
    ),
  );
}

class _ListSkeleton extends StatelessWidget {
  const _ListSkeleton();

  @override
  Widget build(BuildContext context) => Shimmer(
    child: Padding(
      padding: const EdgeInsets.all(AppSpace.lg),
      child: Column(
        children: [
          for (final w in const [0.9, 0.7, 0.8, 0.6])
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpace.lg),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: w,
                child: const SkeletonBox(),
              ),
            ),
        ],
      ),
    ),
  );
}
