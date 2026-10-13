import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// The app's text input: label above, hint and error below.
///
/// [secret] obscures the text with a reveal toggle and turns off everything a
/// keyboard might remember (suggestions, autocorrect, personalised learning),
/// so a password or API key never ends up in the keyboard's dictionary.
/// [pasteable] adds a Paste button for long generated values (API keys, TOTP
/// secrets) that nobody should have to type.
class AppTextField extends StatefulWidget {
  const AppTextField({
    required this.controller,
    required this.label,
    super.key,
    this.hint,
    this.helper,
    this.error,
    this.secret = false,
    this.pasteable = false,
    this.trackId,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.enabled = true,
    this.prefix,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? helper;
  final String? error;
  final bool secret;
  final bool pasteable;

  /// Reported when the reveal or paste buttons are used. Never the text.
  final String? trackId;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  /// Shown inside the field before the text, e.g. the country picker.
  final Widget? prefix;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscured = widget.secret;

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text?.trim();
    if (text == null || text.isEmpty) return;
    widget.controller
      ..text = text
      ..selection = TextSelection.collapsed(offset: text.length);
    widget.onChanged?.call(text);
    if (mounted && widget.trackId != null) context.trackTap('${widget.trackId}_paste');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final error = widget.error;
    final below = error ?? widget.helper;
    final suffix = <Widget>[
      if (widget.pasteable)
        TextButton(onPressed: widget.enabled ? _paste : null, child: Text(l10n.commonPaste)),
      if (widget.secret)
        IconButton(
          tooltip: _obscured ? l10n.commonShow : l10n.commonHide,
          icon: Icon(_obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined),
          color: AppColors.textSecondary,
          onPressed: () {
            setState(() => _obscured = !_obscured);
            if (widget.trackId != null) {
              context.trackChange('${widget.trackId}_reveal', _obscured ? 'hidden' : 'shown');
            }
          },
        ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpace.sm),
          child: Text(
            widget.label,
            style: context.text.labelLarge?.copyWith(color: AppColors.textSecondary),
          ),
        ),
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          enabled: widget.enabled,
          obscureText: _obscured,
          autocorrect: !widget.secret && widget.keyboardType != TextInputType.visiblePassword,
          enableSuggestions: !widget.secret && widget.keyboardType != TextInputType.visiblePassword,
          enableIMEPersonalizedLearning: !widget.secret,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          textCapitalization: widget.textCapitalization,
          autofillHints: widget.enabled ? widget.autofillHints : null,
          onSubmitted: widget.onSubmitted,
          onChanged: widget.onChanged,
          style: context.text.bodyLarge,
          decoration: InputDecoration(
            hintText: widget.hint,
            errorText: error == null ? null : '',
            errorStyle: const TextStyle(height: 0, fontSize: 0),
            prefixIcon: widget.prefix,
            suffixIcon: suffix.isEmpty
                ? null
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [...suffix, const SizedBox(width: 4)],
                  ),
          ),
        ),
        AnimatedSize(
          duration: AppMotion.of(context, AppMotion.short),
          alignment: Alignment.topLeft,
          child: below == null
              ? const SizedBox(width: double.infinity)
              : Padding(
                  padding: const EdgeInsets.only(top: AppSpace.sm),
                  child: Semantics(
                    liveRegion: error != null,
                    child: Text(
                      below,
                      style: context.text.bodySmall?.copyWith(
                        color: error != null ? context.palette.loss : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
