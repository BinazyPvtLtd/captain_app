import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.light,

      scaffoldBackgroundColor: AppColors.background,

      fontFamily: AppTypography.fontFamily,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.textOnPrimary,
        onSecondary: AppColors.textOnPrimary,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),

      // ─────────────────────────────────────────────
      // App Bar
      // ─────────────────────────────────────────────

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTextStyles.headingSmall,
        iconTheme: IconThemeData(
          color: AppColors.iconPrimary,
          size: AppSpacing.iconMD,
        ),
      ),

      // ─────────────────────────────────────────────
      // Text Theme
      // ─────────────────────────────────────────────

      textTheme: const TextTheme(
        displayLarge: AppTextStyles.displayLarge,
        displayMedium: AppTextStyles.displayMedium,
        displaySmall: AppTextStyles.displaySmall,
        headlineLarge: AppTextStyles.headingLarge,
        headlineMedium: AppTextStyles.headingMedium,
        headlineSmall: AppTextStyles.headingSmall,
        titleLarge: AppTextStyles.titleLarge,
        titleMedium: AppTextStyles.titleMedium,
        titleSmall: AppTextStyles.titleSmall,
        bodyLarge: AppTextStyles.bodyLarge,
        bodyMedium: AppTextStyles.bodyMedium,
        bodySmall: AppTextStyles.bodySmall,
        labelLarge: AppTextStyles.labelLarge,
        labelMedium: AppTextStyles.labelMedium,
        labelSmall: AppTextStyles.labelSmall,
      ),

      // ─────────────────────────────────────────────
      // Elevated Button
      // ─────────────────────────────────────────────

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(
            double.infinity,
            AppSpacing.buttonHeight,
          ),
          backgroundColor: AppColors.buttonPrimary,
          foregroundColor: AppColors.buttonPrimaryText,
          disabledBackgroundColor: AppColors.buttonDisabled,
          disabledForegroundColor: AppColors.buttonDisabledText,
          elevation: 0,
          padding: AppSpacing.buttonPadding,
          textStyle: AppTextStyles.primaryButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusMD,
            ),
          ),
        ),
      ),

      // ─────────────────────────────────────────────
      // Outlined Button
      // ─────────────────────────────────────────────

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(
            double.infinity,
            AppSpacing.buttonHeight,
          ),
          foregroundColor: AppColors.buttonSecondaryText,
          backgroundColor: AppColors.buttonSecondary,
          side: const BorderSide(
            color: AppColors.primary,
            width: 1,
          ),
          padding: AppSpacing.buttonPadding,
          textStyle: AppTextStyles.secondaryButton,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusMD,
            ),
          ),
        ),
      ),

      // ─────────────────────────────────────────────
      // Text Button
      // ─────────────────────────────────────────────

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textPrimary,
          textStyle: AppTextStyles.labelLarge,
        ),
      ),

      // ─────────────────────────────────────────────
      // Input Fields
      // ─────────────────────────────────────────────

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,

        hintStyle: AppTextStyles.inputHint,

        labelStyle: AppTextStyles.bodyMediumSecondary,

        contentPadding: AppSpacing.inputPadding,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMD,
          ),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMD,
          ),
          borderSide: const BorderSide(
            color: AppColors.border,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMD,
          ),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMD,
          ),
          borderSide: const BorderSide(
            color: AppColors.error,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusMD,
          ),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ),
        ),
      ),

      // ─────────────────────────────────────────────
      // Cards
      // ─────────────────────────────────────────────

      cardTheme: CardThemeData(
        elevation: 0,
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusLG,
          ),
          side: const BorderSide(
            color: AppColors.border,
          ),
        ),
      ),

      // ─────────────────────────────────────────────
      // Divider
      // ─────────────────────────────────────────────

      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),

      // ─────────────────────────────────────────────
      // Bottom Navigation
      // ─────────────────────────────────────────────

      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.iconSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTextStyles.labelSmall,
        unselectedLabelStyle: AppTextStyles.labelSmall,
      ),

      // ─────────────────────────────────────────────
      // Navigation Bar - Material 3
      // ─────────────────────────────────────────────

     navigationBarTheme: NavigationBarThemeData(
  backgroundColor: AppColors.background,
  elevation: 0,
  height: AppSpacing.bottomNavigationHeight,

  indicatorColor: AppColors.primary,

  indicatorShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(
      AppSpacing.radiusSM,
    ),
  ),

  iconTheme: WidgetStateProperty.resolveWith<IconThemeData>(
    (states) {
      if (states.contains(WidgetState.selected)) {
        return const IconThemeData(
          color: AppColors.white,
          size: AppSpacing.iconMD,
        );
      }

      return const IconThemeData(
        color: AppColors.iconSecondary,
        size: AppSpacing.iconMD,
      );
    },
  ),

  labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
    (states) {
      if (states.contains(WidgetState.selected)) {
        return AppTextStyles.labelSmall.copyWith(
          color: AppColors.textPrimary,
          fontWeight: FontWeight.w600,
        );
      }

      return AppTextStyles.labelSmall.copyWith(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      );
    },
  ),
),

      // ─────────────────────────────────────────────
      // Checkbox
      // ─────────────────────────────────────────────

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }

            return Colors.transparent;
          },
        ),
        checkColor: const WidgetStatePropertyAll(
          AppColors.textOnPrimary,
        ),
        side: const BorderSide(
          color: AppColors.borderDark,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      // ─────────────────────────────────────────────
      // Radio
      // ─────────────────────────────────────────────

      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.primary;
            }

            return AppColors.borderDark;
          },
        ),
      ),

      // ─────────────────────────────────────────────
      // Progress Indicator
      // ─────────────────────────────────────────────

      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.border,
      ),

      // ─────────────────────────────────────────────
      // Bottom Sheet
      // ─────────────────────────────────────────────

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
      ),

      // ─────────────────────────────────────────────
      // Dialog
      // ─────────────────────────────────────────────

      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.background,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusXL,
          ),
        ),
      ),

      // ─────────────────────────────────────────────
      // Snackbar
      // ─────────────────────────────────────────────

      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        contentTextStyle: AppTextStyles.bodyMedium.copyWith(
          color: Colors.white,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            AppSpacing.radiusSM,
          ),
        ),
      ),
    );
  }
}