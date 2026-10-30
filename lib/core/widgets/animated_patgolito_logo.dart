import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Reference artwork is based on a 1536 x 1024 canvas.
/// All positions scale together, keeping the pins above P and O.
class AnimatedPatgolitoLogo extends StatefulWidget {
  const AnimatedPatgolitoLogo({super.key});

  @override
  State<AnimatedPatgolitoLogo> createState() => _AnimatedPatgolitoLogoState();
}

class _AnimatedPatgolitoLogoState extends State<AnimatedPatgolitoLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward(); // Once only. Never repeat or reverse.
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final availableWidth = constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : MediaQuery.sizeOf(context).width;
      final width = math.min(availableWidth * 0.96, 440.0);
      final scale = width / 1536.0;
      return SizedBox(
        width: width,
        height: 560 * scale,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) => Stack(
            clipBehavior: Clip.none,
            children: [
              // Arrow is painted BEHIND the stationary truck.
              Positioned.fill(
                child: CustomPaint(
                  painter: _ArrowPainter(
                    progress: Curves.easeInOutCubic.transform(_controller.value),
                  ),
                ),
              ),
              _asset('left_pin.png', 102, 398 - 224, 116, 168, scale),
              _asset('right_pin.png', 1315, 398 - 224, 123, 168, scale),
              _asset('truck.png', 600, 0, 359, 241, scale),
              _asset('word.png', 82, 575 - 224, 1372, 194, scale),
            ],
          ),
        ),
      );
    });
  }

  Widget _asset(String file, double x, double y, double w, double h, double s) {
    return Positioned(
      left: x * s,
      top: y * s,
      width: w * s,
      height: h * s,
      child: Image.asset(
        'assets/images/logo/splash/$file',
        fit: BoxFit.fill,
        filterQuality: FilterQuality.high,
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  const _ArrowPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final sx = size.width / 1536;
    final sy = size.height / 560;
    canvas.save();
    canvas.scale(sx, sy);
    canvas.translate(0, -224);

    // Route shape and thickness approximate the provided reference.
    final path = Path()
      ..moveTo(225, 523)
      ..cubicTo(320, 436, 465, 370, 600, 350)
      ..cubicTo(780, 320, 1055, 352, 1219, 473)
      ..cubicTo(1242, 493, 1265, 512, 1294, 523);

    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true;

    for (final metric in path.computeMetrics()) {
      canvas.drawPath(metric.extractPath(0, metric.length * progress), paint);
    }

    // Reveal arrowhead only as the drawing reaches the destination.
    if (progress > 0.90) {
      final headProgress = ((progress - 0.90) / 0.10).clamp(0.0, 1.0);
      final head = Path()
        ..moveTo(1228, 395)
        ..quadraticBezierTo(1260, 440, 1294, 523)
        ..quadraticBezierTo(1235, 537, 1155, 515);
      for (final metric in head.computeMetrics()) {
        canvas.drawPath(
          metric.extractPath(0, metric.length * headProgress),
          paint..strokeWidth = 23,
        );
      }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _ArrowPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
