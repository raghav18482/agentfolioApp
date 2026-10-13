import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/brand/brand_mark.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:flutter/material.dart';

/// The frame shared by the sign-in screens: the mark, a title and subtitle,
/// a scrolling body, and an optional [bottom] action pinned above the
/// keyboard, so the main button is always one thumb away while typing.
///
/// On tablets the content keeps a comfortable reading width instead of
/// stretching edge to edge.
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    required this.title,
    required this.children,
    super.key,
    this.subtitle,
    this.header,
    this.bottom,
    this.showMark = true,
    this.appBar,
  });

  final String title;
  final String? subtitle;

  /// Above the title, e.g. a step indicator.
  final Widget? header;
  final List<Widget> children;
  final Widget? bottom;
  final bool showMark;
  final PreferredSizeWidget? appBar;

  static const maxWidth = 440.0;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: appBar,
    body: SafeArea(
      bottom: bottom == null,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(
                AppSpace.page,
                AppSpace.xl,
                AppSpace.page,
                AppSpace.xl,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: maxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (header != null) ...[header!, const SizedBox(height: AppSpace.xl)],
                      if (showMark) ...[
                        const Align(alignment: Alignment.centerLeft, child: BrandMark(size: 52)),
                        const SizedBox(height: AppSpace.xl),
                      ],
                      Text(title, style: context.text.headlineLarge),
                      if (subtitle != null) ...[
                        const SizedBox(height: AppSpace.sm),
                        Text(
                          subtitle!,
                          style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                      const SizedBox(height: AppSpace.xl),
                      ...children,
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (bottom != null)
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border(top: BorderSide(color: context.palette.border)),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpace.page,
                    AppSpace.md,
                    AppSpace.page,
                    AppSpace.md,
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: maxWidth),
                      child: bottom,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
  );
}

/// "Question? Action" — the small text links under auth forms.
class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    required this.trackId,
    required this.prompt,
    required this.action,
    required this.onTap,
    super.key,
  });

  final String trackId;
  final String prompt;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(prompt, style: context.text.bodySmall, textAlign: TextAlign.center),
        TextButton(
          onPressed: () {
            context.trackTap(trackId);
            onTap();
          },
          child: Text('$action →'),
        ),
      ],
    ),
  );
}
