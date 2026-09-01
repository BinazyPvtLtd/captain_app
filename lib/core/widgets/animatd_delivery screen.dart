import 'dart:math' as math;

import 'package:driver_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class AnimatedDeliveryScene extends StatefulWidget {
  final double height;

  const AnimatedDeliveryScene({
    super.key,
    required this.height,
  });

  @override
  State<AnimatedDeliveryScene> createState() =>
      _AnimatedDeliverySceneState();
}

class _AnimatedDeliverySceneState
    extends State<AnimatedDeliveryScene>
    with TickerProviderStateMixin {
  // =========================================================
  // CONTROLLERS
  // =========================================================

  late final AnimationController _roadController;
  late final AnimationController _truckController;

  // =========================================================
  // TRUCK MOVEMENT
  // =========================================================

  late final Animation<double> _truckBounce;

  @override
  void initState() {
    super.initState();

    // =======================================================
    // SCENERY MOVEMENT
    // =======================================================

    _roadController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 10,
      ),
    )..repeat();

    // =======================================================
    // TRUCK SUSPENSION / BOUNCE
    // =======================================================

    _truckController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 900,
      ),
    )..repeat(
        reverse: true,
      );

    _truckBounce = Tween<double>(
      begin: -1.5,
      end: 1.5,
    ).animate(
      CurvedAnimation(
        parent: _truckController,
        curve: Curves.easeInOutSine,
      ),
    );
  }

  @override
  void dispose() {
    _roadController.dispose();
    _truckController.dispose();

    super.dispose();
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // ===============================================
            // SKY
            // ===============================================

            const Positioned.fill(
              child: ColoredBox(
                color: Color(0xFFF8F8F6),
              ),
            ),

            // ===============================================
            // MOVING BACKGROUND
            // ===============================================

            Positioned.fill(
              child: AnimatedBuilder(
                animation: _roadController,
                builder: (
                  context,
                  child,
                ) {
                  return CustomPaint(
                    painter: _MovingSceneryPainter(
                      progress:
                          _roadController.value,
                    ),
                  );
                },
              ),
            ),

            // ===============================================
            // ROAD
            // ===============================================

            Positioned(
              left: 0,
              right: 0,
              bottom: 22,
              height: 44,
              child: AnimatedBuilder(
                animation: _roadController,
                builder: (
                  context,
                  child,
                ) {
                  return CustomPaint(
                    painter: _MovingRoadPainter(
                      progress:
                          _roadController.value,
                    ),
                  );
                },
              ),
            ),

            // ===============================================
            // TRUCK
            // ===============================================

            Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: AnimatedBuilder(
                animation: _truckBounce,
                builder: (
                  context,
                  child,
                ) {
                  return Transform.translate(
                    offset: Offset(
                      0,
                      _truckBounce.value,
                    ),
                    child: child,
                  );
                },
                child: Center(
                  child: Image.asset(
                    AppAssets.loginTruck,
                    width: 235,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// MOVING SCENERY
// =====================================================================

class _MovingSceneryPainter
    extends CustomPainter {
  final double progress;

  const _MovingSceneryPainter({
    required this.progress,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final buildingPaint = Paint()
      ..color = const Color(
        0xFFE5E5E2,
      );

    final buildingDarkPaint = Paint()
      ..color = const Color(
        0xFFD7D7D3,
      );

    final treePaint = Paint()
      ..color = const Color(
        0xFFDCDCD7,
      );

    final treeTrunkPaint = Paint()
      ..color = const Color(
        0xFFCACAC5,
      );

    // One complete repeating scenery width.
    final double sceneWidth =
        size.width * 1.6;

    final double offset =
        progress * sceneWidth;

    // Draw two copies so loop doesn't jump.
    for (int copy = -1;
        copy <= 2;
        copy++) {
      final double startX =
          (copy * sceneWidth) -
              offset;

      _drawScene(
        canvas,
        size,
        startX,
        buildingPaint,
        buildingDarkPaint,
        treePaint,
        treeTrunkPaint,
      );
    }
  }

  void _drawScene(
    Canvas canvas,
    Size size,
    double startX,
    Paint buildingPaint,
    Paint buildingDarkPaint,
    Paint treePaint,
    Paint treeTrunkPaint,
  ) {
    final double groundY =
        size.height - 58;

    // =======================================================
    // BUILDING 1
    // =======================================================

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          startX + 20,
          groundY - 75,
          52,
          75,
        ),
        const Radius.circular(4),
      ),
      buildingPaint,
    );

    // WINDOWS

    for (int row = 0;
        row < 3;
        row++) {
      for (int column = 0;
          column < 2;
          column++) {
        canvas.drawRect(
          Rect.fromLTWH(
            startX +
                30 +
                (column * 22),
            groundY -
                62 +
                (row * 20),
            9,
            8,
          ),
          buildingDarkPaint,
        );
      }
    }

    // =======================================================
    // TREE
    // =======================================================

    final double treeX =
        startX + 115;

    canvas.drawRect(
      Rect.fromLTWH(
        treeX - 3,
        groundY - 38,
        6,
        38,
      ),
      treeTrunkPaint,
    );

    canvas.drawCircle(
      Offset(
        treeX,
        groundY - 45,
      ),
      20,
      treePaint,
    );

    // =======================================================
    // BUILDING 2
    // =======================================================

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          startX + 170,
          groundY - 105,
          72,
          105,
        ),
        const Radius.circular(5),
      ),
      buildingDarkPaint,
    );

    for (int row = 0;
        row < 4;
        row++) {
      for (int column = 0;
          column < 3;
          column++) {
        canvas.drawRect(
          Rect.fromLTWH(
            startX +
                182 +
                (column * 19),
            groundY -
                88 +
                (row * 20),
            8,
            8,
          ),
          buildingPaint,
        );
      }
    }

    // =======================================================
    // SECOND TREE
    // =======================================================

    final double tree2X =
        startX + 295;

    canvas.drawRect(
      Rect.fromLTWH(
        tree2X - 3,
        groundY - 35,
        6,
        35,
      ),
      treeTrunkPaint,
    );

    canvas.drawCircle(
      Offset(
        tree2X,
        groundY - 43,
      ),
      18,
      treePaint,
    );

    // =======================================================
    // WAREHOUSE
    // =======================================================

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          startX + 345,
          groundY - 65,
          110,
          65,
        ),
        const Radius.circular(4),
      ),
      buildingPaint,
    );

    canvas.drawRect(
      Rect.fromLTWH(
        startX + 375,
        groundY - 42,
        48,
        42,
      ),
      buildingDarkPaint,
    );
  }

  @override
  bool shouldRepaint(
    covariant _MovingSceneryPainter
        oldDelegate,
  ) {
    return oldDelegate.progress !=
        progress;
  }
}

// =====================================================================
// MOVING ROAD
// =====================================================================

class _MovingRoadPainter
    extends CustomPainter {
  final double progress;

  const _MovingRoadPainter({
    required this.progress,
  });

  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    // =======================================================
    // ROAD
    // =======================================================

    final roadPaint = Paint()
      ..color = const Color(
        0xFFE9E9E6,
      );

    canvas.drawRect(
      Offset.zero & size,
      roadPaint,
    );

    // =======================================================
    // ROAD LINE
    // =======================================================

    final linePaint = Paint()
      ..color = const Color(
        0xFFBEBEBA,
      )
      ..strokeWidth = 3
      ..strokeCap =
          StrokeCap.round;

    const double dashWidth =
        34;

    const double gap =
        24;

    final double cycle =
        dashWidth + gap;

    final double offset =
        (progress * cycle * 8) %
            cycle;

    for (double x = -cycle;
        x < size.width + cycle;
        x += cycle) {
      canvas.drawLine(
        Offset(
          x - offset,
          size.height / 2,
        ),
        Offset(
          x +
              dashWidth -
              offset,
          size.height / 2,
        ),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(
    covariant _MovingRoadPainter
        oldDelegate,
  ) {
    return oldDelegate.progress !=
        progress;
  }
}