import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  // ─────────────────────────────────────────────
  // Font Family
  // ─────────────────────────────────────────────

  static const String fontFamily = 'Inter';

  // Agar custom font use nahi kar rahe ho to:
  // static const String? fontFamily = null;

  // ─────────────────────────────────────────────
  // Font Sizes
  // ─────────────────────────────────────────────

  static const double displayLarge = 32.0;
  static const double displayMedium = 28.0;
  static const double displaySmall = 24.0;

  static const double headingLarge = 22.0;
  static const double headingMedium = 20.0;
  static const double headingSmall = 18.0;

  static const double titleLarge = 18.0;
  static const double titleMedium = 16.0;
  static const double titleSmall = 14.0;

  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;

  static const double labelLarge = 15.0;
  static const double labelMedium = 13.0;
  static const double labelSmall = 11.0;

  // ─────────────────────────────────────────────
  // Font Weights
  // ─────────────────────────────────────────────

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;

  // ─────────────────────────────────────────────
  // Line Heights
  // ─────────────────────────────────────────────

  static const double tightHeight = 1.15;
  static const double normalHeight = 1.35;
  static const double relaxedHeight = 1.5;

  // ─────────────────────────────────────────────
  // Letter Spacing
  // ─────────────────────────────────────────────

  static const double tightLetterSpacing = -0.3;
  static const double normalLetterSpacing = 0.0;
  static const double wideLetterSpacing = 0.3;
}