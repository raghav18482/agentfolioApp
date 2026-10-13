import 'dart:async';

import 'package:agentfolio/core/presentation/theme/app_motion.dart';
import 'package:flutter/material.dart';

/// Fades and lifts its child into place once, after [delay]. Give siblings
/// increasing delays for a staggered entrance on a screen's first load.
/// Shows the child at once when the user has asked for reduced motion.
class FadeSlideIn extends StatefulWidget {
  const FadeSlideIn({required this.child, super.key, this.delay = Duration.zero});

  final Widget child;
  final Duration delay;

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: AppMotion.long);
  late final _curve = CurvedAnimation(parent: _controller, curve: AppMotion.enter);
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_controller.isAnimating || _controller.isCompleted || _timer != null) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else {
      _timer = Timer(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _curve,
    child: AnimatedBuilder(
      animation: _curve,
      child: widget.child,
      builder: (context, child) =>
          Transform.translate(offset: Offset(0, 16 * (1 - _curve.value)), child: child),
    ),
  );
}
