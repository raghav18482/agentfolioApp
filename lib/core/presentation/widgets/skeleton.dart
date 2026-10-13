import 'package:agentfolio/core/presentation/theme/app_colors.dart';
import 'package:agentfolio/core/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Shimmers every [SkeletonBox] below it with one shared animation.
///
/// Skeletons are laid out like the content they stand in for, so nothing
/// moves when the data arrives. With reduce-motion on, the boxes stay still.
class Shimmer extends StatefulWidget {
  const Shimmer({required this.child, super.key});

  final Widget child;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.stop();
    } else if (!_controller.isAnimating) {
      _controller.repeat().ignore();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Loading',
    child: ExcludeSemantics(
      child: AnimatedBuilder(
        animation: _controller,
        child: widget.child,
        builder: (context, child) => ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final shift = _controller.value * 2 - 0.5;
            return LinearGradient(
              begin: Alignment(-1 + shift * 2, -0.3),
              end: Alignment(1 + shift * 2, 0.3),
              colors: const [
                AppColors.surfaceRaised,
                AppColors.surfaceHighest,
                AppColors.surfaceRaised,
              ],
              stops: const [0.35, 0.5, 0.65],
            ).createShader(bounds);
          },
          child: child,
        ),
      ),
    ),
  );
}

/// A placeholder block inside a [Shimmer].
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, this.width, this.height = 14, this.radius = AppRadius.sm});

  final double? width;
  final double height;
  final Radius radius;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: AppColors.surfaceRaised,
      borderRadius: BorderRadius.all(radius),
    ),
  );
}
