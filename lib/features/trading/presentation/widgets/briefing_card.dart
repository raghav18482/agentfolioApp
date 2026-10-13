import 'dart:async';

import 'package:agentfolio/core/error/result.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/confirm_sheet.dart';
import 'package:agentfolio/core/presentation/widgets/section_card.dart';
import 'package:agentfolio/core/presentation/widgets/section_state.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/utils/time.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:agentfolio/features/trading/domain/entities/trading.dart';
import 'package:agentfolio/features/trading/presentation/view_models/trade_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The daily WhatsApp brief: when it goes out, sending one now, and what
/// happened to the last few.
class BriefingCard extends StatelessWidget {
  const BriefingCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<TradeViewModel>();
    final number = context.select<SessionProvider, String?>(
      (s) => s.signedIn?.user.premium.whatsappNumber,
    );

    return SectionCard(
      title: l10n.briefTitle,
      subtitle: l10n.briefSubtitle(number ?? l10n.briefYourWhatsapp),
      child: SectionState<BriefingSchedule?>(
        state: vm.schedule.state,
        retryTrackId: 'brief_retry',
        onRetry: () => unawaited(vm.schedule.load(force: true)),
        skeletonHeight: 120,
        builder: (context, schedule) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _Schedule(schedule: schedule, number: number),
            const _Logs(),
          ],
        ),
      ),
    );
  }
}

class _Schedule extends StatelessWidget {
  const _Schedule({required this.schedule, required this.number});

  final BriefingSchedule? schedule;
  final String? number;

  /// The saved send time as IST wall-clock, or 08:30.
  TimeOfDay get _time {
    final next = schedule?.nextRun;
    if (next == null) return const TimeOfDay(hour: 8, minute: 30);
    final ist = Times.toIst(next);
    return TimeOfDay(hour: ist.hour, minute: ist.minute);
  }

  Future<void> _pickTime(BuildContext context, {required bool enabled}) async {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<TradeViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    final picked = await showTimePicker(
      context: context,
      initialTime: _time,
      helpText: l10n.briefPickTime,
      // The send time is India time whatever the phone's zone; a 24-hour
      // clock avoids AM/PM confusion across zones.
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (picked == null) return;
    final result = await vm.saveSchedule(
      hour: picked.hour,
      minute: picked.minute,
      enabled: enabled,
    );
    messenger.showSnackBar(
      SnackBar(
        content: Text(switch (result) {
          Success(:final value) => l10n.briefSaved(
            Times.formatIst(value.nextRun?.toIso8601String()),
          ),
          Err(:final failure) => failure.message,
        }),
      ),
    );
  }

  Future<void> _toggle(BuildContext context, {required bool on}) async {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<TradeViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    if (!on) {
      final confirmed = await showConfirmSheet(
        context,
        trackId: 'brief_pause',
        title: l10n.briefPauseTitle,
        message: l10n.briefPauseBody,
        confirmLabel: l10n.briefPause,
      );
      if (!confirmed) return;
      final result = await vm.disableSchedule();
      if (result case Err(:final failure)) {
        messenger.showSnackBar(SnackBar(content: Text(failure.message)));
      }
      return;
    }
    final t = _time;
    final result = await vm.saveSchedule(hour: t.hour, minute: t.minute, enabled: true);
    if (result case Err(:final failure)) {
      messenger.showSnackBar(SnackBar(content: Text(failure.message)));
    }
  }

  Future<void> _sendNow(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final vm = context.read<TradeViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showConfirmSheet(
      context,
      trackId: 'brief_send_now',
      title: l10n.briefSendNowTitle,
      message: l10n.briefSendNowBody(number ?? l10n.briefYourWhatsapp),
      confirmLabel: l10n.briefSendNow,
    );
    if (!confirmed) return;
    final result = await vm.sendBriefingNow();
    messenger.showSnackBar(
      SnackBar(
        content: Text(switch (result) {
          Success(:final value) => value.isEmpty ? l10n.briefStarted : value,
          Err(:final failure) => failure.message,
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<TradeViewModel>();
    final s = schedule;
    final enabled = s?.enabled ?? false;
    final busy = vm.briefingBusy;
    final time = _time;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          value: enabled,
          onChanged: busy
              ? null
              : (on) {
                  context.trackChange('brief_auto', on ? 'on' : 'off');
                  unawaited(_toggle(context, on: on));
                },
          title: Text(l10n.briefAutoSend),
          subtitle: Text(
            s == null
                ? l10n.briefNotSet
                : enabled
                ? l10n.briefNext(Times.formatIst(s.nextRun?.toIso8601String()))
                : l10n.briefPaused,
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.schedule_rounded),
          title: Text(l10n.briefTimeIst),
          trailing: Text(
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')} IST',
            style: context.text.titleSmall,
          ),
          onTap: busy ? null : () => unawaited(_pickTime(context, enabled: s?.enabled ?? true)),
        ),
        if (s?.lastRun != null)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpace.sm),
            child: Text(
              l10n.briefLast(Times.formatIst(s!.lastRun!.toIso8601String())),
              style: context.text.bodySmall?.copyWith(color: context.palette.textMuted),
            ),
          ),
        const SizedBox(height: AppSpace.sm),
        AppButton(
          trackId: 'brief_send_now_open',
          label: l10n.briefSendNow,
          icon: Icons.send_rounded,
          variant: AppButtonVariant.secondary,
          loading: busy,
          onPressed: busy ? null : () => unawaited(_sendNow(context)),
        ),
      ],
    );
  }
}

class _Logs extends StatelessWidget {
  const _Logs();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final vm = context.watch<TradeViewModel>();
    final logs = vm.logs.data ?? const <BriefingLog>[];
    if (logs.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: AppSpace.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(l10n.briefActivity.toUpperCase(), style: context.text.labelSmall),
              ),
              TextButton(
                onPressed: () => unawaited(vm.logs.load(force: true)),
                child: Text(l10n.briefRefresh),
              ),
            ],
          ),
          for (final log in logs.take(5))
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpace.xs),
              child: Row(
                children: [
                  Icon(
                    switch (log.outcome) {
                      BriefingOutcome.success => Icons.check_circle_rounded,
                      BriefingOutcome.running => Icons.timelapse_rounded,
                      BriefingOutcome.failed => Icons.error_rounded,
                    },
                    size: 16,
                    color: switch (log.outcome) {
                      BriefingOutcome.success => AppColors.gain,
                      BriefingOutcome.running => AppColors.sky,
                      BriefingOutcome.failed => AppColors.loss,
                    },
                  ),
                  const SizedBox(width: AppSpace.sm),
                  Expanded(
                    child: Text(
                      [
                        Times.formatIst(log.at?.toIso8601String()),
                        if (log.duration != null)
                          '${(log.duration!.inMilliseconds / 1000).toStringAsFixed(1)}s',
                      ].join(' · '),
                      style: context.text.bodySmall,
                    ),
                  ),
                  Text(switch (log.outcome) {
                    BriefingOutcome.success => l10n.briefSent,
                    BriefingOutcome.running => l10n.briefRunning,
                    BriefingOutcome.failed => l10n.briefFailed,
                  }, style: context.text.labelMedium?.copyWith(color: context.palette.textMuted)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
