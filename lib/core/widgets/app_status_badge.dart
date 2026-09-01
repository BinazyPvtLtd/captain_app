import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

enum AppStatusType {
  neutral,
  success,
  warning,
  error,
}

class AppStatusBadge extends StatelessWidget {
  final String text;
  final AppStatusType type;

  const AppStatusBadge({
    super.key,
    required this.text,
    this.type = AppStatusType.neutral,
  });

  Color get _foregroundColor {
    switch (type) {
      case AppStatusType.success:
        return AppColors.success;

      case AppStatusType.warning:
        return AppColors.warning;

      case AppStatusType.error:
        return AppColors.error;

      case AppStatusType.neutral:
        return AppColors.textPrimary;
    }
  }

  Color get _backgroundColor {
    switch (type) {
      case AppStatusType.success:
        return AppColors.success.withValues(
          alpha: 0.08,
        );

      case AppStatusType.warning:
        return AppColors.warning.withValues(
          alpha: 0.08,
        );

      case AppStatusType.error:
        return AppColors.error.withValues(
          alpha: 0.08,
        );

      case AppStatusType.neutral:
        return AppColors.surfaceSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(
          AppSpacing.radiusCircular,
        ),
      ),
      child: Text(
        text.toUpperCase(),
        style: AppTextStyles.status.copyWith(
          color: _foregroundColor,
        ),
      ),
    );
  }
}