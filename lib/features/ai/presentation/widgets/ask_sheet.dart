import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/view_state.dart';
import 'package:agentfolio/core/presentation/widgets/ai_markdown.dart';
import 'package:agentfolio/core/presentation/widgets/app_icon_button.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/features/ai/presentation/view_models/ask_view_model.dart';
import 'package:agentfolio/features/ai/presentation/widgets/ai_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Builds a fresh [AskViewModel] for each sheet. Provided by the Home route.
typedef AskViewModelFactory = AskViewModel Function();

/// The questions offered before anything is asked, from the web app.
List<String> askStarters(AppLocalizations l10n) => [
  l10n.askStarterDiversified,
  l10n.askStarterUnderperforming,
  l10n.askStarterRisk,
  l10n.askStarterRebalance,
  l10n.askStarterHealth,
];

/// Opens the Ask sheet, asking [question] straight away when given.
Future<void> showAskSheet(BuildContext context, {required String trackId, String? question}) {
  context.trackTap(trackId);
  final create = context.read<AskViewModelFactory>();
  return showModalBottomSheet<void>(
    context: context,
    useSafeArea: true,
    isScrollControlled: true,
    // The sheet is a route of its own, outside Home's providers, so it gets
    // its view model here.
    builder: (_) => ChangeNotifierProvider<AskViewModel>(
      create: (_) {
        final vm = create();
        if (question != null) unawaited(vm.ask(question));
        return vm;
      },
      child: const FractionallySizedBox(heightFactor: 0.9, child: _AskSheet()),
    ),
  );
}

class _AskSheet extends StatefulWidget {
  const _AskSheet();

  @override
  State<_AskSheet> createState() => _AskSheetState();
}

class _AskSheetState extends State<_AskSheet> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();
  final _focus = FocusNode();
  int _shown = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
    // Opened to type: bring the keyboard up. Opened from a starter: don't.
    if (context.read<AskViewModel>().exchanges.isEmpty) _focus.requestFocus();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _submit() {
    final vm = context.read<AskViewModel>();
    final text = _controller.text.trim();
    if (text.isEmpty || vm.busy) return;
    context.trackTap('ask_send');
    _controller.clear();
    unawaited(vm.ask(text));
  }

  /// Keep the newest question in view as the exchange grows.
  void _followNewest(int count) {
    if (count == _shown) return;
    _shown = count;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<AskViewModel>();
    final exchanges = vm.exchanges;
    _followNewest(exchanges.length);
    final canSend = _controller.text.trim().isNotEmpty && !vm.busy;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.sm, AppSpace.sm),
            child: Row(
              children: [
                Expanded(child: Text(l10n.askTitle, style: context.text.titleLarge)),
                AppIconButton(
                  trackId: 'ask_close',
                  icon: Icons.close_rounded,
                  tooltip: l10n.commonClose,
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Expanded(
            child: exchanges.isEmpty
                ? _Starters(onPick: (q) => unawaited(vm.ask(q)))
                : ListView.separated(
                    controller: _scroll,
                    padding: const EdgeInsets.fromLTRB(
                      AppSpace.page,
                      AppSpace.sm,
                      AppSpace.page,
                      AppSpace.lg,
                    ),
                    itemCount: exchanges.length,
                    separatorBuilder: (_, _) => const SizedBox(height: AppSpace.xl),
                    itemBuilder: (context, i) => _ExchangeView(exchange: exchanges[i]),
                  ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: context.palette.border)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpace.page,
                AppSpace.md,
                AppSpace.sm,
                AppSpace.md,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      focusNode: _focus,
                      minLines: 1,
                      maxLines: 4,
                      maxLength: AskViewModel.maxLength,
                      textCapitalization: TextCapitalization.sentences,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _submit(),
                      decoration: InputDecoration(
                        hintText: l10n.askPlaceholder,
                        counterText: '',
                        isDense: true,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpace.xs),
                  AppIconButton(
                    trackId: 'ask_send_button',
                    icon: Icons.arrow_upward_rounded,
                    tooltip: l10n.chatSend,
                    color: canSend ? AppColors.brandSoft : null,
                    onPressed: canSend ? _submit : null,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Starters extends StatelessWidget {
  const _Starters({required this.onPick});

  final ValueChanged<String> onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: AppSpace.page, vertical: AppSpace.lg),
      children: [
        Text(
          l10n.askIntro,
          style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpace.lg),
        Wrap(
          spacing: AppSpace.sm,
          runSpacing: AppSpace.sm,
          children: [
            for (final (i, q) in askStarters(l10n).indexed)
              ActionChip(
                label: Text(q),
                onPressed: () {
                  context.trackTap('ask_sheet_starter_$i');
                  onPick(q);
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _ExchangeView extends StatelessWidget {
  const _ExchangeView({required this.exchange});

  final AskExchange exchange;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<AskViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpace.lg, vertical: AppSpace.md),
              decoration: const BoxDecoration(
                color: AppColors.brand,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(4),
                ),
              ),
              child: Text(
                exchange.question,
                style: context.text.bodyMedium?.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpace.md),
        switch (exchange.answer) {
          ViewIdle() || ViewLoading() => AiWriting(label: l10n.askThinking, lines: 4),
          ViewError(:final failure) => AiFailureView(
            failure: failure,
            retryTrackId: 'ask_retry',
            onRetry: () => unawaited(vm.retry(exchange.id)),
          ),
          ViewData(:final data) => AiMarkdown(data, linkTrackId: 'ask_link'),
        },
      ],
    );
  }
}
