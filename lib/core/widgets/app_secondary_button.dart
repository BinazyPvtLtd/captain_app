import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppSecondaryButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isEnabled;
  final double? width;
  final double? height;

  const AppSecondaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.icon,
    this.isEnabled = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? AppSpacing.buttonHeight,
      child: OutlinedButton(
        onPressed: isEnabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.primary,
          side: BorderSide(
            color: isEnabled
                ? AppColors.primary
                : AppColors.borderDark,
          ),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppSpacing.radiusMD,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: AppSpacing.iconSM,
              ),
              AppSpacing.horizontalXS,
            ],
            Text(
              title,
              style: isEnabled
                  ? AppTextStyles.secondaryButton
                  : AppTextStyles.secondaryButton.copyWith(
                      color: AppColors.textDisabled,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}