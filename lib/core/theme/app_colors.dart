import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ─────────────────────────────────────────────
  // Brand Colors
  // ─────────────────────────────────────────────

  static const Color primary = Color(0xFF000000);
  static const Color secondary = Color(0xFF1A1A1A);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  // ─────────────────────────────────────────────
  // Background Colors
  // ─────────────────────────────────────────────

  static const Color background = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF7F7F7);
  static const Color surfaceDark = Color(0xFF111111);


  

  // ─────────────────────────────────────────────
  // Text Colors
  // ─────────────────────────────────────────────

  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textTertiary = Color(0xFF999999);
  static const Color textDisabled = Color(0xFFBDBDBD);

  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // ─────────────────────────────────────────────
  // Border / Divider
  // ─────────────────────────────────────────────

  static const Color border = Color(0xFFE5E5E5);
  static const Color borderDark = Color(0xFFBDBDBD);
  static const Color divider = Color(0xFFEEEEEE);

  // ─────────────────────────────────────────────
  // Icon Colors
  // ─────────────────────────────────────────────

  static const Color iconPrimary = Color(0xFF111111);
  static const Color iconSecondary = Color(0xFF757575);
  static const Color iconDisabled = Color(0xFFBDBDBD);

  // ─────────────────────────────────────────────
  // Button Colors
  // ─────────────────────────────────────────────

  static const Color buttonPrimary = Color(0xFF000000);
  static const Color buttonPrimaryText = Color(0xFFFFFFFF);

  static const Color buttonSecondary = Color(0xFFFFFFFF);
  static const Color buttonSecondaryText = Color(0xFF000000);

  static const Color buttonDisabled = Color(0xFFE0E0E0);
  static const Color buttonDisabledText = Color(0xFF9E9E9E);

  // ─────────────────────────────────────────────
  // Status Colors
  // Keep usage minimal to preserve monochrome theme
  // ─────────────────────────────────────────────


  static const Color success =Color(0xFF16A34A);
  //static const Color success = Color(0xFF1E7D3E);
  static const Color error = Color(0xFFD32F2F);
  static const Color warning = Color(0xFFE08A00);
  static const Color info = Color(0xFF424242);

  // ─────────────────────────────────────────────
  // Other
  // ─────────────────────────────────────────────

  static const Color transparent = Colors.transparent;

  static const Color shadow = Color(0x14000000);

  static const Color shimmerBase = Color(0xFFEEEEEE);
  static const Color shimmerHighlight = Color(0xFFF7F7F7);
}