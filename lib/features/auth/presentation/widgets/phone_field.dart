import 'dart:async';

import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/app_text_field.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/features/auth/domain/entities/auth_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A WhatsApp number: the country's flag and dial code, which opens a
/// searchable sheet, then the number itself.
class PhoneField extends StatelessWidget {
  const PhoneField({
    required this.controller,
    required this.countries,
    required this.country,
    required this.onCountryChanged,
    super.key,
    this.helper,
    this.error,
    this.focusNode,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.onChanged,
    this.enabled = true,
    this.isLoginIdentifier = false,
  });

  final TextEditingController controller;
  final List<Country> countries;
  final Country country;
  final ValueChanged<Country> onCountryChanged;
  final String? helper;
  final String? error;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool enabled;

  /// The number is the username at login, so password managers pair it with
  /// the app password.
  final bool isLoginIdentifier;

  Future<void> _pick(BuildContext context) async {
    context.trackTap('country_picker');
    final picked = await showModalBottomSheet<Country>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _CountrySheet(countries: countries, selected: country),
    );
    if (picked != null && picked != country) {
      HapticFeedback.selectionClick().ignore();
      onCountryChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppTextField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      label: l10n.fieldWhatsapp,
      hint: l10n.fieldWhatsappHint,
      helper: helper,
      error: error,
      keyboardType: TextInputType.phone,
      textInputAction: textInputAction,
      onSubmitted: onSubmitted,
      onChanged: onChanged,
      autofillHints: [
        if (isLoginIdentifier) AutofillHints.username,
        AutofillHints.telephoneNumberNational,
      ],
      prefix: Semantics(
        button: true,
        label: l10n.countryPickerButton(country.dialLabel),
        excludeSemantics: true,
        child: InkWell(
          onTap: enabled ? () => unawaited(_pick(context)) : null,
          borderRadius: const BorderRadius.horizontal(left: AppRadius.md),
          child: Padding(
            padding: const EdgeInsets.only(left: 14, right: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(country.flag, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 6),
                Text(country.dialLabel, style: context.text.bodyLarge),
                const Icon(Icons.arrow_drop_down_rounded, color: AppColors.textSecondary),
                Container(
                  width: 1,
                  height: 24,
                  margin: const EdgeInsets.only(left: 4),
                  color: context.palette.border,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CountrySheet extends StatefulWidget {
  const _CountrySheet({required this.countries, required this.selected});

  final List<Country> countries;
  final Country selected;

  @override
  State<_CountrySheet> createState() => _CountrySheetState();
}

class _CountrySheetState extends State<_CountrySheet> {
  final _search = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<Country> get _matches {
    final q = _query.trim().toLowerCase().replaceFirst('+', '');
    if (q.isEmpty) return widget.countries;
    return widget.countries
        .where(
          (c) =>
              c.name.toLowerCase().contains(q) ||
              c.dialCode.startsWith(q) ||
              c.iso.toLowerCase() == q,
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final matches = _matches;
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scrollController) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpace.page, 0, AppSpace.page, AppSpace.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(l10n.countryPickerTitle, style: context.text.titleLarge),
                const SizedBox(height: AppSpace.md),
                TextField(
                  controller: _search,
                  textInputAction: TextInputAction.search,
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    hintText: l10n.countryPickerSearch,
                    prefixIcon: const Icon(Icons.search_rounded),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: matches.isEmpty
                ? Center(
                    child: Text(
                      l10n.countryPickerNoMatch(_query),
                      style: context.text.bodyMedium?.copyWith(color: AppColors.textSecondary),
                    ),
                  )
                : ListView.builder(
                    controller: scrollController,
                    itemCount: matches.length,
                    itemBuilder: (context, i) {
                      final c = matches[i];
                      final selected = c == widget.selected;
                      return ListTile(
                        selected: selected,
                        leading: Text(c.flag, style: const TextStyle(fontSize: 24)),
                        title: Text(c.name),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(c.dialLabel, style: context.text.bodyMedium),
                            if (selected) ...[
                              const SizedBox(width: AppSpace.sm),
                              const Icon(Icons.check_rounded, color: AppColors.brandSoft),
                            ],
                          ],
                        ),
                        onTap: () => Navigator.of(context).pop(c),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
