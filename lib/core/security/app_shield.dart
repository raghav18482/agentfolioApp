import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/brand/brand_mark.dart';
import 'package:agentfolio/core/security/app_lock.dart';
import 'package:agentfolio/features/auth/presentation/providers/session_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Sits above every screen:
/// * covers the app while it is not in front, so the app switcher's snapshot
///   shows the brand, never a portfolio (Android 13+ also refuses the
///   snapshot natively, see `MainActivity`);
/// * shows the lock screen while [AppLock] is locked.
class AppShield extends StatefulWidget {
  const AppShield({required this.child, super.key});

  final Widget child;

  @override
  State<AppShield> createState() => _AppShieldState();
}

class _AppShieldState extends State<AppShield> {
  late final AppLifecycleListener _lifecycle;
  bool _covered = false;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onInactive: () => setState(() => _covered = true),
      onHide: () {
        context.read<AppLock>().onBackground();
        setState(() => _covered = true);
      },
      onShow: () => context.read<AppLock>().onForeground(),
      onResume: () => setState(() => _covered = false),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locked = context.select<AppLock, bool>((l) => l.locked);
    return Stack(
      fit: StackFit.expand,
      children: [
        // Hidden from screen readers and taps while locked.
        ExcludeSemantics(
          excluding: locked,
          child: AbsorbPointer(absorbing: locked, child: widget.child),
        ),
        if (locked) const _LockScreen(),
        if (_covered && !locked) const _Cover(),
      ],
    );
  }
}

class _Cover extends StatelessWidget {
  const _Cover();

  @override
  Widget build(BuildContext context) => const ColoredBox(
    color: AppColors.background,
    child: Center(child: BrandMark(size: 72)),
  );
}

class _LockScreen extends StatefulWidget {
  const _LockScreen();

  @override
  State<_LockScreen> createState() => _LockScreenState();
}

class _LockScreenState extends State<_LockScreen> {
  String? _note;

  @override
  void initState() {
    super.initState();
    // Ask straight away: that is what the user opened the app to do.
    WidgetsBinding.instance.addPostFrameCallback((_) => unawaited(_unlock()));
  }

  Future<void> _unlock() async {
    final l10n = AppLocalizations.of(context);
    final result = await context.read<AppLock>().unlock(l10n.lockReason);
    if (!mounted) return;
    setState(() {
      _note = switch (result) {
        UnlockResult.stillLocked => l10n.lockTryAgain,
        UnlockResult.lockRemoved || UnlockResult.unlocked => null,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final unlocking = context.select<AppLock, bool>((l) => l.unlocking);
    return Material(
      color: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpace.page),
          child: Column(
            children: [
              const Spacer(),
              const BrandMark(size: 72),
              const SizedBox(height: AppSpace.xl),
              Text(l10n.lockTitle, style: context.text.titleLarge, textAlign: TextAlign.center),
              const SizedBox(height: AppSpace.sm),
              Text(
                _note ?? l10n.lockBody,
                textAlign: TextAlign.center,
                style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary),
              ),
              const Spacer(),
              AppButton(
                trackId: 'lock_unlock',
                label: l10n.lockUnlock,
                icon: Icons.lock_open_rounded,
                loading: unlocking,
                onPressed: () => unawaited(_unlock()),
              ),
              const SizedBox(height: AppSpace.sm),
              TextButton(
                onPressed: () => unawaited(context.read<SessionProvider>().signOut()),
                child: Text(l10n.lockSignOut, style: TextStyle(color: context.palette.textMuted)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
