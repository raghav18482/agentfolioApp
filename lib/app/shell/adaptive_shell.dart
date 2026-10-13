import 'package:agentfolio/core/l10n/gen/app_localizations.dart';
import 'package:agentfolio/core/presentation/responsive/window_size.dart';
import 'package:agentfolio/core/presentation/theme/app_palette.dart';
import 'package:agentfolio/core/presentation/widgets/brand/brand_mark.dart';
import 'package:agentfolio/core/presentation/widgets/tracking.dart';
import 'package:agentfolio/core/telemetry/telemetry.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

/// One bottom tab / rail destination.
class ShellTab {
  const ShellTab({
    required this.id,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  /// Also the screen name telemetry reports for the tab.
  final String id;
  final IconData icon;
  final IconData selectedIcon;
  final String Function(AppLocalizations l10n) label;
}

/// The order here must match the branch order in the router.
final shellTabs = [
  ShellTab(
    id: 'home',
    icon: Icons.home_outlined,
    selectedIcon: Icons.home_rounded,
    label: (l10n) => l10n.tabHome,
  ),
  ShellTab(
    id: 'portfolio',
    icon: Icons.account_balance_wallet_outlined,
    selectedIcon: Icons.account_balance_wallet_rounded,
    label: (l10n) => l10n.tabPortfolio,
  ),
  ShellTab(
    id: 'markets',
    icon: Icons.insights_outlined,
    selectedIcon: Icons.insights_rounded,
    label: (l10n) => l10n.tabMarkets,
  ),
  ShellTab(
    id: 'trade',
    icon: Icons.candlestick_chart_outlined,
    selectedIcon: Icons.candlestick_chart_rounded,
    label: (l10n) => l10n.tabTrade,
  ),
  ShellTab(
    id: 'agent',
    icon: Icons.auto_awesome_outlined,
    selectedIcon: Icons.auto_awesome_rounded,
    label: (l10n) => l10n.tabAgent,
  ),
];

/// Bottom navigation on phones, a navigation rail on wider screens. The
/// content area is the same either way.
class AdaptiveShell extends StatelessWidget {
  const AdaptiveShell({required this.navigationShell, required this.body, super.key});

  final StatefulNavigationShell navigationShell;
  final Widget body;

  void _select(BuildContext context, int index) {
    final current = navigationShell.currentIndex;
    if (index != current) {
      HapticFeedback.selectionClick().ignore();
      context.trackChange('nav_tab', shellTabs[index].id);
      context.read<Telemetry>().screen(shellTabs[index].id);
    }
    // Tapping the tab you are on returns it to its first screen.
    navigationShell.goBranch(index, initialLocation: index == current);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final size = WindowSize.of(context);
    final index = navigationShell.currentIndex;

    if (!size.usesRail) {
      return Scaffold(
        body: body,
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (i) => _select(context, i),
          destinations: [
            for (final tab in shellTabs)
              NavigationDestination(
                icon: Icon(tab.icon),
                selectedIcon: Icon(tab.selectedIcon),
                label: tab.label(l10n),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: index,
            onDestinationSelected: (i) => _select(context, i),
            labelType: NavigationRailLabelType.all,
            groupAlignment: -0.85,
            leading: const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: BrandMark(size: 36),
            ),
            destinations: [
              for (final tab in shellTabs)
                NavigationRailDestination(
                  icon: Icon(tab.icon),
                  selectedIcon: Icon(tab.selectedIcon),
                  label: Text(tab.label(l10n)),
                ),
            ],
          ),
          VerticalDivider(width: 1, color: context.palette.border),
          Expanded(child: body),
        ],
      ),
    );
  }
}
