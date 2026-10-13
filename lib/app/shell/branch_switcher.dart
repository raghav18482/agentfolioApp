import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:flutter/material.dart';

/// Holds every tab's navigator alive (like an IndexedStack, so each tab keeps
/// its scroll position and state) and fades the newly selected tab in with a
/// slight scale. Hidden tabs are offstage and their tickers paused, so they
/// cost nothing while out of sight.
class BranchSwitcher extends StatefulWidget {
  const BranchSwitcher({required this.currentIndex, required this.children, super.key});

  final int currentIndex;
  final List<Widget> children;

  @override
  State<BranchSwitcher> createState() => _BranchSwitcherState();
}

class _BranchSwitcherState extends State<BranchSwitcher> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: AppMotion.medium,
    value: 1,
  );
  late final Animation<double> _fade = CurvedAnimation(parent: _controller, curve: AppMotion.enter);
  late final Animation<double> _scale = Tween<double>(begin: 0.985, end: 1).animate(_fade);

  @override
  void didUpdateWidget(BranchSwitcher oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex == widget.currentIndex) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else {
      _controller.forward(from: 0).ignore();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    fit: StackFit.expand,
    children: [
      for (var i = 0; i < widget.children.length; i++) _branch(i, active: i == widget.currentIndex),
    ],
  );

  Widget _branch(int index, {required bool active}) {
    final child = widget.children[index];
    if (!active) {
      return Offstage(child: TickerMode(enabled: false, child: child));
    }
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(scale: _scale, child: child),
    );
  }
}
