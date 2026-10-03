import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

class AppTextStyles {
  AppTextStyles._();


  static const TextStyle splashLogoText = TextStyle(
  fontFamily: AppTypography.fontFamily,
  fontSize: 30,
  fontWeight: AppTypography.extraBold,
  color: AppColors.white,
  height: 1.1,
  letterSpacing: 2,
);

static const TextStyle splashTagline = TextStyle(
  fontFamily: AppTypography.fontFamily,
  fontSize: 14,
  fontWeight: AppTypography.medium,
  color: AppColors.white,
  height: 1.4,
  letterSpacing: 0.3,
);

// =========================================================
// LOGIN / AUTH
// =========================================================

static const TextStyle loginTitle = TextStyle(
  fontFamily: AppTypography.fontFamily,
  fontSize: 28,
  fontWeight: FontWeight.w700,
  color: AppColors.textPrimary,
  height: 1.20,
  letterSpacing: -0.3,
);

static const TextStyle loginSubtitle = TextStyle(
  fontFamily: AppTypography.fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: AppColors.textSecondary,
  height: 1.45,
);

static const TextStyle countryCode = TextStyle(
  fontFamily: AppTypography.fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: AppColors.textPrimary,
  height: 1.2,
);

static const TextStyle phoneInput = TextStyle(
  fontFamily: AppTypography.fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: AppColors.textPrimary,
  height: 1.2,
);

static const TextStyle phoneHint = TextStyle(
  fontFamily: AppTypography.fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: AppColors.textTertiary,
  height: 1.2,
);

static const TextStyle buttonText = TextStyle(
  fontFamily: AppTypography.fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.w600,
  color: AppColors.white,
  height: 1.2,
  letterSpacing: 0.1,
);

static const TextStyle termsText = TextStyle(
  fontFamily: AppTypography.fontFamily,
  fontSize: 13,
  fontWeight: FontWeight.w400,
  color: AppColors.textSecondary,
  height: 1.45,
);

static const TextStyle termsAction = TextStyle(
  fontFamily: AppTypography.fontFamily,
  fontSize: 13,
  fontWeight: FontWeight.w600,
  color: AppColors.textPrimary,
  height: 1.45,
);

  // ─────────────────────────────────────────────
  // Display
  // ─────────────────────────────────────────────

  static const TextStyle displayLarge = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.displayLarge,
    fontWeight: AppTypography.bold,
    color: AppColors.textPrimary,
    height: AppTypography.tightHeight,
    letterSpacing: AppTypography.tightLetterSpacing,
  );

  static const TextStyle displayMedium = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.displayMedium,
    fontWeight: AppTypography.bold,
    color: AppColors.textPrimary,
    height: AppTypography.tightHeight,
  );

  static const TextStyle displaySmall = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.displaySmall,
    fontWeight: AppTypography.bold,
    color: AppColors.textPrimary,
    height: AppTypography.tightHeight,
  );

  // ─────────────────────────────────────────────
  // Headings
  // ─────────────────────────────────────────────

  static const TextStyle headingLarge = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.headingLarge,
    fontWeight: AppTypography.bold,
    color: AppColors.textPrimary,
    height: AppTypography.normalHeight,
  );

  static const TextStyle headingMedium = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.headingMedium,
    fontWeight: AppTypography.semiBold,
    color: AppColors.textPrimary,
    height: AppTypography.normalHeight,
  );

  static const TextStyle headingSmall = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.headingSmall,
    fontWeight: AppTypography.semiBold,
    color: AppColors.textPrimary,
    height: AppTypography.normalHeight,
  );

  // ─────────────────────────────────────────────
  // Titles
  // ─────────────────────────────────────────────

  static const TextStyle titleLarge = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.titleLarge,
    fontWeight: AppTypography.semiBold,
    color: AppColors.textPrimary,
    height: AppTypography.normalHeight,
  );

  static const TextStyle titleMedium = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.titleMedium,
    fontWeight: AppTypography.semiBold,
    color: AppColors.textPrimary,
    height: AppTypography.normalHeight,
  );

  static const TextStyle titleSmall = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.titleSmall,
    fontWeight: AppTypography.semiBold,
    color: AppColors.textPrimary,
    height: AppTypography.normalHeight,
  );

  // ─────────────────────────────────────────────
  // Body
  // ─────────────────────────────────────────────

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.bodyLarge,
    fontWeight: AppTypography.regular,
    color: AppColors.textPrimary,
    height: AppTypography.relaxedHeight,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.bodyMedium,
    fontWeight: AppTypography.regular,
    color: AppColors.textPrimary,
    height: AppTypography.relaxedHeight,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.bodySmall,
    fontWeight: AppTypography.regular,
    color: AppColors.textSecondary,
    height: AppTypography.relaxedHeight,
  );

  // ─────────────────────────────────────────────
  // Secondary Body
  // ─────────────────────────────────────────────

  static const TextStyle bodyLargeSecondary = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.bodyLarge,
    fontWeight: AppTypography.regular,
    color: AppColors.textSecondary,
    height: AppTypography.relaxedHeight,
  );

  static const TextStyle bodyMediumSecondary = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.bodyMedium,
    fontWeight: AppTypography.regular,
    color: AppColors.textSecondary,
    height: AppTypography.relaxedHeight,
  );

  // ─────────────────────────────────────────────
  // Labels
  // ─────────────────────────────────────────────

  static const TextStyle labelLarge = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.labelLarge,
    fontWeight: AppTypography.semiBold,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.labelMedium,
    fontWeight: AppTypography.medium,
    color: AppColors.textSecondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: AppTypography.labelSmall,
    fontWeight: AppTypography.medium,
    color: AppColors.textTertiary,
  );

  // ─────────────────────────────────────────────
  // Button
  // ─────────────────────────────────────────────

  static const TextStyle primaryButton = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: 16,
    fontWeight: AppTypography.semiBold,
    color: AppColors.textOnPrimary,
    letterSpacing: 0.2,
  );

  static const TextStyle secondaryButton = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: 16,
    fontWeight: AppTypography.semiBold,
    color: AppColors.textPrimary,
    letterSpacing: 0.2,
  );

  // ─────────────────────────────────────────────
  // Input
  // ─────────────────────────────────────────────

  static const TextStyle input = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: 15,
    fontWeight: AppTypography.regular,
    color: AppColors.textPrimary,
  );

  static const TextStyle inputHint = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: 15,
    fontWeight: AppTypography.regular,
    color: AppColors.textTertiary,
  );

  // ─────────────────────────────────────────────
  // Price / Earnings
  // ─────────────────────────────────────────────

  static const TextStyle priceLarge = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: 30,
    fontWeight: AppTypography.bold,
    color: AppColors.textPrimary,
    height: 1.1,
  );

  static const TextStyle priceMedium = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: 22,
    fontWeight: AppTypography.bold,
    color: AppColors.textPrimary,
  );

  // ─────────────────────────────────────────────
  // Status
  // ─────────────────────────────────────────────

  static const TextStyle status = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: 12,
    fontWeight: AppTypography.semiBold,
    color: AppColors.textPrimary,
    letterSpacing: 0.6,
  );

  // ─────────────────────────────────────────────
  // Error
  // ─────────────────────────────────────────────

  static const TextStyle error = TextStyle(
    fontFamily: AppTypography.fontFamily,
    fontSize: 12,
    fontWeight: AppTypography.medium,
    color: AppColors.error,
  );
}