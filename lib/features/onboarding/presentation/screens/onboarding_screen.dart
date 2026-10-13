import 'dart:async';

import 'package:agentfolio/app/router/routes.dart';
import 'package:agentfolio/core/constants/disclaimers.dart';
import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_button.dart';
import 'package:agentfolio/core/presentation/widgets/brand/brand_mark.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/storage/prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// First-run welcome: what Agentfolio does, how the AI fits in, and the
/// Responsible AI statement, then Log in or Set up.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  static const _slideCount = 3;
  final _pages = PageController();
  int _page = 0;

  bool get _onLast => _page == _slideCount - 1;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _goTo(int page) {
    _pages.animateToPage(
      page,
      duration: AppMotion.of(context, AppMotion.medium),
      curve: AppMotion.enter,
    );
  }

  /// Onboarding is done once the user picks a way in; it never shows again.
  void _finish({required bool setUp}) {
    unawaited(context.read<Prefs>().setOnboardingSeen());
    // Link Account sits under Login, so one `go` builds Login → Link and Back
    // from setup lands on Login.
    context.go(setUp ? Routes.linkAccount : Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedOpacity(
                    opacity: _onLast ? 0 : 1,
                    duration: AppMotion.of(context, AppMotion.short),
                    child: TextButton(
                      onPressed: _onLast
                          ? null
                          : () {
                              context.trackTap('onboarding_skip');
                              _goTo(_slideCount - 1);
                            },
                      child: Text(l10n.onboardingSkip),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _pages,
                    onPageChanged: (page) {
                      HapticFeedback.selectionClick().ignore();
                      context.trackChange('onboarding_page', '${page + 1}');
                      setState(() => _page = page);
                    },
                    children: [
                      _FeatureSlide(
                        art: const _SlideArt(
                          icons: [Icons.pie_chart_rounded, Icons.trending_up_rounded],
                        ),
                        title: l10n.onboardingSlide1Title,
                        body: l10n.onboardingSlide1Body,
                      ),
                      _FeatureSlide(
                        art: const _SlideArt(
                          icons: [Icons.auto_awesome_rounded, Icons.forum_rounded],
                        ),
                        title: l10n.onboardingSlide2Title,
                        body: l10n.onboardingSlide2Body,
                      ),
                      const _ResponsibleAiSlide(),
                    ],
                  ),
                ),
                _PageDots(count: _slideCount, index: _page),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpace.page,
                    AppSpace.lg,
                    AppSpace.page,
                    AppSpace.lg,
                  ),
                  child: AnimatedSwitcher(
                    duration: AppMotion.of(context, AppMotion.medium),
                    child: _onLast
                        ? Column(
                            key: const ValueKey('finish'),
                            children: [
                              AppButton(
                                trackId: 'onboarding_login',
                                label: l10n.onboardingLogin,
                                variant: AppButtonVariant.gradient,
                                expand: true,
                                onPressed: () => _finish(setUp: false),
                              ),
                              const SizedBox(height: AppSpace.sm),
                              AppButton(
                                trackId: 'onboarding_set_up',
                                label: l10n.onboardingSetUp,
                                variant: AppButtonVariant.secondary,
                                expand: true,
                                onPressed: () => _finish(setUp: true),
                              ),
                            ],
                          )
                        : AppButton(
                            key: const ValueKey('next'),
                            trackId: 'onboarding_next',
                            label: l10n.onboardingNext,
                            expand: true,
                            onPressed: () => _goTo(_page + 1),
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
}

class _FeatureSlide extends StatelessWidget {
  const _FeatureSlide({required this.art, required this.title, required this.body});

  final Widget art;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: AppSpace.page),
    child: Column(
      children: [
        const SizedBox(height: AppSpace.xxl),
        art,
        const SizedBox(height: AppSpace.xxl),
        Text(title, style: context.text.headlineMedium, textAlign: TextAlign.center),
        const SizedBox(height: AppSpace.md),
        Text(
          body,
          textAlign: TextAlign.center,
          style: context.text.bodyLarge?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    ),
  );
}

/// The brand mark in a soft gradient halo, with two feature icons orbiting.
class _SlideArt extends StatelessWidget {
  const _SlideArt({required this.icons});

  final List<IconData> icons;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox.square(
      dimension: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [AppColors.indigo.withValues(alpha: 0.28), AppColors.background],
              ),
            ),
          ),
          const BrandMark(size: 96),
          Positioned(
            top: 18,
            right: 22,
            child: _Orbit(icon: icons[0], color: AppColors.emerald),
          ),
          Positioned(
            bottom: 22,
            left: 18,
            child: _Orbit(icon: icons[1], color: AppColors.sky),
          ),
        ],
      ),
    ),
  );
}

class _Orbit extends StatelessWidget {
  const _Orbit({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    width: 48,
    height: 48,
    decoration: BoxDecoration(
      color: context.palette.surfaceRaised,
      shape: BoxShape.circle,
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Icon(icon, color: color, size: 22),
  );
}

/// The Responsible AI statement, verbatim from the web app's landing page.
class _ResponsibleAiSlide extends StatelessWidget {
  const _ResponsibleAiSlide();

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: AppSpace.page),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpace.lg),
        Text(
          Disclaimers.responsibleAiEyebrow.toUpperCase(),
          style: context.text.labelSmall?.copyWith(color: AppColors.brandSoft),
        ),
        const SizedBox(height: AppSpace.sm),
        Text(Disclaimers.responsibleAiTitle, style: context.text.headlineMedium),
        const SizedBox(height: AppSpace.md),
        Text(
          Disclaimers.responsibleAiBody,
          style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: AppSpace.xl),
        const _Pillar(
          icon: Icons.shield_outlined,
          title: Disclaimers.responsibleAiPillarRiskTitle,
          body: Disclaimers.responsibleAiPillarRiskBody,
        ),
        const SizedBox(height: AppSpace.md),
        const _Pillar(
          icon: Icons.hourglass_bottom_rounded,
          title: Disclaimers.responsibleAiPillarLongTermTitle,
          body: Disclaimers.responsibleAiPillarLongTermBody,
        ),
        const SizedBox(height: AppSpace.xl),
        Text(
          Disclaimers.responsibleAiFineprint,
          style: context.text.bodySmall?.copyWith(color: AppColors.textMuted, height: 1.5),
        ),
        const SizedBox(height: AppSpace.lg),
      ],
    ),
  );
}

class _Pillar extends StatelessWidget {
  const _Pillar({required this.icon, required this.title, required this.body});

  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSpace.lg),
    decoration: BoxDecoration(
      color: context.palette.surface,
      borderRadius: AppRadius.card,
      border: Border.all(color: context.palette.border),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.emerald),
        const SizedBox(width: AppSpace.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: context.text.titleSmall),
              const SizedBox(height: AppSpace.xs),
              Text(body, style: context.text.bodySmall),
            ],
          ),
        ),
      ],
    ),
  );
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '${index + 1} of $count',
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: AppMotion.of(context, AppMotion.medium),
            curve: AppMotion.enter,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: i == index ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == index ? AppColors.brandSoft : AppColors.borderStrong,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
      ],
    ),
  );
}
