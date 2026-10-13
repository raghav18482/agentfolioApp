import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A checkbox with a label that can carry links (consent rows). The whole row
/// toggles; links inside [label] stay tappable on their own.
class AppCheckboxTile extends StatelessWidget {
  const AppCheckboxTile({
    required this.trackId,
    required this.value,
    required this.onChanged,
    required this.label,
    super.key,
  });

  final String trackId;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Widget label;

  void _toggle(BuildContext context) {
    HapticFeedback.selectionClick().ignore();
    context.trackChange(trackId, value ? 'unchecked' : 'checked');
    onChanged(!value);
  }

  @override
  Widget build(BuildContext context) => MergeSemantics(
    child: InkWell(
      borderRadius: AppRadius.card,
      onTap: () => _toggle(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpace.xs),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(value: value, onChanged: (_) => _toggle(context)),
            const SizedBox(width: AppSpace.xs),
            Expanded(
              child: Padding(padding: const EdgeInsets.only(top: 12), child: label),
            ),
          ],
        ),
      ),
    ),
  );
}
