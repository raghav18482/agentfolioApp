import 'package:agentfolio/core/presentation/widgets/brand/logo_painter.dart';
import 'package:flutter/widgets.dart';

/// The static Agentfolio logo, for headers and empty states.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 48});

  final double size;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Agentfolio',
    image: true,
    child: RepaintBoundary(
      child: CustomPaint(
        size: Size.square(size),
        painter: const LogoPainter(LogoProgress.complete),
      ),
    ),
  );
}
