import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBackPressed;

  final List<Widget>? actions;

  final Widget? leading;

  final bool centerTitle;

  final Color backgroundColor;

  const AppAppBar({
    super.key,
    this.title,
    this.showBackButton = true,
    this.onBackPressed,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.backgroundColor = AppColors.background,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      surfaceTintColor: Colors.transparent,

      leading: leading ??
          (showBackButton
              ? IconButton(
                  onPressed: onBackPressed ??
                      () {
                        Navigator.of(context).maybePop();
                      },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: AppSpacing.iconSM,
                  ),
                )
              : null),

      title: title != null
          ? Text(
              title!,
              style: AppTextStyles.headingSmall,
            )
          : null,

      actions: actions,
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(AppSpacing.appBarHeight);
}