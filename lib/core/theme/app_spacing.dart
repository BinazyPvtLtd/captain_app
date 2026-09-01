import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  // ─────────────────────────────────────────────
  // Base Spacing
  // ─────────────────────────────────────────────

  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
  static const double xxxl = 40.0;
  static const double huge = 48.0;

  // ─────────────────────────────────────────────
  // Screen Padding
  // ─────────────────────────────────────────────

  static const double screenHorizontal = 20.0;
  static const double screenVertical = 20.0;

  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
  );

  static const EdgeInsets screenPaddingAll = EdgeInsets.symmetric(
    horizontal: screenHorizontal,
    vertical: screenVertical,
  );

  // ─────────────────────────────────────────────
  // Card Padding
  // ─────────────────────────────────────────────

  static const EdgeInsets cardPadding = EdgeInsets.all(16.0);

  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(20.0);

  // ─────────────────────────────────────────────
  // Input Padding
  // ─────────────────────────────────────────────

  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: 16.0,
    vertical: 16.0,
  );

  // ─────────────────────────────────────────────
  // Button Padding
  // ─────────────────────────────────────────────

  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: 20.0,
    vertical: 16.0,
  );

  // ─────────────────────────────────────────────
  // Common Gaps
  // ─────────────────────────────────────────────

  static const SizedBox gapXXS = SizedBox(height: xxs);
  static const SizedBox gapXS = SizedBox(height: xs);
  static const SizedBox gapSM = SizedBox(height: sm);
  static const SizedBox gapMD = SizedBox(height: md);
  static const SizedBox gapLG = SizedBox(height: lg);
  static const SizedBox gapXL = SizedBox(height: xl);
  static const SizedBox gapXXL = SizedBox(height: xxl);
  static const SizedBox gapXXXL = SizedBox(height: xxxl);

  // ─────────────────────────────────────────────
  // Horizontal Gaps
  // ─────────────────────────────────────────────

  static const SizedBox horizontalXXS = SizedBox(width: xxs);
  static const SizedBox horizontalXS = SizedBox(width: xs);
  static const SizedBox horizontalSM = SizedBox(width: sm);
  static const SizedBox horizontalMD = SizedBox(width: md);
  static const SizedBox horizontalLG = SizedBox(width: lg);
  static const SizedBox horizontalXL = SizedBox(width: xl);

  // ─────────────────────────────────────────────
  // Radius
  // ─────────────────────────────────────────────

  static const double radiusXS = 6.0;
  static const double radiusSM = 10.0;
  static const double radiusMD = 14.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 20.0;
  static const double radiusXXL = 24.0;
  static const double radiusCircular = 999.0;

  // ─────────────────────────────────────────────
  // Component Heights
  // ─────────────────────────────────────────────

  static const double buttonHeight = 54.0;
  static const double inputHeight = 56.0;
  static const double appBarHeight = 56.0;
  static const double bottomNavigationHeight = 72.0;

  // ─────────────────────────────────────────────
  // Icon Sizes
  // ─────────────────────────────────────────────

  static const double iconXS = 16.0;
  static const double iconSM = 20.0;
  static const double iconMD = 24.0;
  static const double iconLG = 28.0;
  static const double iconXL = 32.0;
  static const double iconXXL = 40.0;
}