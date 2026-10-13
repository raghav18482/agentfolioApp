import 'dart:async';
import 'dart:math' as math;

import 'package:agentfolio/app/splash/app_startup.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/brand/logo_painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// The animated launch screen.
///
/// Its first frame is an empty navy screen, identical to the native launch
/// screen, so the hand-off is invisible. The logo then builds itself from the
/// icon's own shapes:
///
/// | ms        | what happens                                         |
/// |-----------|------------------------------------------------------|
/// | 0–350     | gradient border traces round the square              |
/// | 200–600   | the square's tinted fill fades in                    |
/// | 250–750   | three bars grow, 80 ms apart, with a slight overshoot |
/// | 650–1050  | the trend line draws left to right                   |
/// | 1000–1200 | the dot pops (0 → 1.15 → 1) with a glow              |
/// | 1100–1400 | the wordmark rises into place                        |
///
/// If launch work is still running after that, the dot's glow breathes until
/// it is done. Reduce-motion shows the finished logo at once.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  static const _introDuration = Duration(milliseconds: 1400);
  static const _logoSize = 112.0;

  late final AnimationController _intro = AnimationController(
    vsync: this,
    duration: _introDuration,
  );
  late final AnimationController _breath = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  );

  late final Animation<double> _border = _interval(0, 350, Curves.easeInOutCubic);
  late final Animation<double> _fill = _interval(200, 600, Curves.easeOut);
  late final List<Animation<double>> _bars = [
    for (var i = 0; i < 3; i++) _interval(250 + i * 80, 590 + i * 80, Curves.easeOutBack),
  ];
  late final Animation<double> _line = _interval(650, 1050, Curves.easeInOutCubic);
  late final Animation<double> _dot = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween<double>(begin: 0, end: 1.15).chain(CurveTween(curve: Curves.easeOut)),
      weight: 60,
    ),
    TweenSequenceItem(
      tween: Tween<double>(begin: 1.15, end: 1).chain(CurveTween(curve: Curves.easeInOut)),
      weight: 40,
    ),
  ]).animate(_curvedInterval(1000, 1200, Curves.linear));
  late final Animation<double> _popGlow = TweenSequence<double>([
    TweenSequenceItem(tween: Tween<double>(begin: 0, end: 1), weight: 40),
    TweenSequenceItem(tween: Tween<double>(begin: 1, end: 0.35), weight: 60),
  ]).animate(_curvedInterval(1000, 1400, Curves.easeOut));
  late final Animation<double> _wordmark = _interval(1100, 1400, AppMotion.enter);

  bool _started = false;

  Animation<double> _interval(int startMs, int endMs, Curve curve) =>
      Tween<double>(begin: 0, end: 1).animate(_curvedInterval(startMs, endMs, curve));

  CurvedAnimation _curvedInterval(int startMs, int endMs, Curve curve) {
    final total = _introDuration.inMilliseconds;
    return CurvedAnimation(
      parent: _intro,
      curve: Interval(startMs / total, math.min(endMs / total, 1), curve: curve),
    );
  }

  @override
  void initState() {
    super.initState();
    _intro.addStatusListener((status) {
      if (status != AnimationStatus.completed) return;
      context.read<AppStartup>().introFinished();
      if (!MediaQuery.disableAnimationsOf(context)) _breath.repeat(reverse: true);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_started) return;
    _started = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _intro.value = 1; // fires `completed`, which tells the startup we are done
    } else {
      _intro.forward();
    }
  }

  @override
  void dispose() {
    _intro.dispose();
    _breath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Semantics(
                  label: l10n.appName,
                  image: true,
                  child: RepaintBoundary(
                    child: AnimatedBuilder(
                      animation: Listenable.merge([_intro, _breath]),
                      builder: (context, _) => CustomPaint(
                        size: const Size.square(_logoSize),
                        painter: LogoPainter(_progress()),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpace.xl),
                _Wordmark(animation: _wordmark, title: l10n.appName, tagline: l10n.appTagline),
              ],
            ),
          ),
          const Positioned(
            left: AppSpace.xl,
            right: AppSpace.xl,
            bottom: 0,
            child: SafeArea(top: false, child: _StartupStatus()),
          ),
        ],
      ),
    );
  }

  LogoProgress _progress() {
    final breathing = _breath.isAnimating || _breath.value > 0;
    final glow = breathing
        ? 0.35 + 0.45 * Curves.easeInOut.transform(_breath.value)
        : _popGlow.value;
    return LogoProgress(
      border: _border.value,
      fill: _fill.value,
      bars: [for (final bar in _bars) bar.value],
      line: _line.value,
      dotScale: _dot.value,
      glow: glow,
    );
  }
}

class _Wordmark extends StatelessWidget {
  const _Wordmark({required this.animation, required this.title, required this.tagline});

  final Animation<double> animation;
  final String title;
  final String tagline;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: animation,
    builder: (context, child) => Opacity(
      opacity: animation.value,
      child: Transform.translate(offset: Offset(0, 8 * (1 - animation.value)), child: child),
    ),
    child: Column(
      children: [
        Text(title, style: context.text.headlineLarge),
        const SizedBox(height: AppSpace.xs),
        Text(
          tagline,
          style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

/// What the splash says while it waits: nothing at first, then a calm
/// "connecting", then a nudge to check the connection, or Retry when the
/// server could not be reached at all.
class _StartupStatus extends StatelessWidget {
  const _StartupStatus();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final phase = context.select<AppStartup, StartupPhase>((s) => s.phase);

    final child = switch (phase) {
      StartupPhase.running ||
      StartupPhase.ready => const SizedBox(key: ValueKey('empty'), height: 120),
      StartupPhase.slow => _StatusText(key: const ValueKey('slow'), text: l10n.splashConnecting),
      StartupPhase.stalled => _StatusText(key: const ValueKey('stalled'), text: l10n.splashSlow),
      StartupPhase.offline => _OfflinePanel(key: const ValueKey('offline'), l10n: l10n),
    };

    return SizedBox(
      height: 160,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedSwitcher(
          duration: AppMotion.of(context, AppMotion.medium),
          switchInCurve: AppMotion.enter,
          child: child,
        ),
      ),
    );
  }
}

class _StatusText extends StatelessWidget {
  const _StatusText({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpace.xxl),
    child: Semantics(
      liveRegion: true,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: context.text.bodySmall?.copyWith(color: AppColors.textSecondary),
      ),
    ),
  );
}

class _OfflinePanel extends StatelessWidget {
  const _OfflinePanel({required this.l10n, super.key});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpace.xl),
    child: Semantics(
      liveRegion: true,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.splashOfflineTitle, style: context.text.titleMedium),
          const SizedBox(height: AppSpace.xs),
          Text(
            l10n.splashOfflineBody,
            textAlign: TextAlign.center,
            style: context.text.bodySmall?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppSpace.lg),
          AppButton(
            trackId: 'splash_retry',
            label: l10n.commonRetry,
            icon: Icons.refresh_rounded,
            variant: AppButtonVariant.secondary,
            expand: true,
            onPressed: () => unawaited(context.read<AppStartup>().retry()),
          ),
        ],
      ),
    ),
  );
}
