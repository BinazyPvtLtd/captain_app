import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AppScreen extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet;

  final bool scrollable;
  final bool resizeToAvoidBottomInset;
  final bool useSafeArea;

  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;

  const AppScreen({
    super.key,
    required this.child,
    this.appBar,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.scrollable = false,
    this.resizeToAvoidBottomInset = true,
    this.useSafeArea = true,
    this.padding,
    this.backgroundColor = AppColors.background,
  });

  @override
  Widget build(BuildContext context) {
    Widget body = LayoutBuilder(
      builder: (context, constraints) {
        Widget content = Padding(
          padding: padding ??
              const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenHorizontal,
              ),
          child: child,
        );

        if (scrollable) {
          content = SingleChildScrollView(
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: content,
            ),
          );
        }

        return content;
      },
    );

    if (useSafeArea) {
      body = SafeArea(
        bottom: bottomNavigationBar == null,
        child: body,
      );
    }

    Widget? safeBottomNavigation;

    if (bottomNavigationBar != null) {
      safeBottomNavigation = SafeArea(
        top: false,
        child: bottomNavigationBar!,
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      body: body,
      bottomNavigationBar: safeBottomNavigation,
      bottomSheet: bottomSheet,
    );
  }
}