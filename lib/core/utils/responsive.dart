import 'package:flutter/material.dart';

class Responsive {
  Responsive._();

  static Size size(BuildContext context) {
    return MediaQuery.sizeOf(context);
  }

  static double width(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double height(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  // Width categories

  static bool isSmallWidth(BuildContext context) {
    return width(context) < 360;
  }

  static bool isNormalWidth(BuildContext context) {
    final w = width(context);

    return w >= 360 && w < 430;
  }

  static bool isLargeWidth(BuildContext context) {
    return width(context) >= 430;
  }

  // Height categories

  static bool isShortHeight(BuildContext context) {
    return height(context) < 700;
  }

  static bool isMediumHeight(BuildContext context) {
    final h = height(context);

    return h >= 700 && h < 820;
  }

  static bool isTallHeight(BuildContext context) {
    return height(context) >= 820;
  }

  // Screen horizontal padding

  static double horizontalPadding(BuildContext context) {
    final w = width(context);

    if (w < 360) {
      return 16;
    }

    if (w >= 600) {
      return 32;
    }

    return 20;
  }

  // Max content width
  // Prevents UI becoming huge on tablets/foldables.

  static double maxContentWidth(BuildContext context) {
    final w = width(context);

    if (w >= 600) {
      return 520;
    }

    return double.infinity;
  }
}