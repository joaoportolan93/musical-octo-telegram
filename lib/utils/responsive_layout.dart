import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout {
  // Breakpoints solicitados
  static const double mobileMaxWidth = 768;
  static const double tabletMaxWidth = 1024;
  static const double desktopMaxWidth = 1440;

  static bool get isWeb => kIsWeb;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileMaxWidth;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileMaxWidth && width < tabletMaxWidth;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletMaxWidth;
  }

  // Header heights
  static double headerHeight(BuildContext context) {
    return isDesktop(context) ? 60 : 100;
  }

  // Grid columns based on width
  static int gridColumns(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 1440) return 4; // ultra-wide
    if (width >= 1024) return 3; // desktop padrão
    if (width >= 768) return 2; // tablet
    return 2; // mobile mantém 2 por padrão
  }

  // Card sizing
  static const double desktopCardWidth = 280;
  static const double desktopCardHeight = 320;

  static double getMaxWidth(BuildContext context) {
    if (!isWeb) return double.infinity;
    final width = MediaQuery.of(context).size.width;
    if (width > desktopMaxWidth) return desktopMaxWidth;
    if (width > tabletMaxWidth) return tabletMaxWidth;
    return width;
  }

  static double getHorizontalPadding(BuildContext context) {
    if (isWeb && isDesktop(context)) return 24.0;
    if (isTablet(context)) return 16.0;
    return 12.0;
  }

  static double getVerticalPadding(BuildContext context) {
    if (isWeb && isDesktop(context)) return 16.0;
    if (isTablet(context)) return 12.0;
    return 8.0;
  }

  static double getFontSize(BuildContext context, double baseSize) {
    if (isWeb && isDesktop(context)) return baseSize * 0.95;
    return baseSize;
  }

  static double getIconSize(BuildContext context, double baseSize) {
    if (isWeb && isDesktop(context)) return baseSize * 0.9;
    return baseSize;
  }

  static double getSpacing(BuildContext context, double baseSpacing) {
    if (isWeb && isDesktop(context)) return baseSpacing * 0.85;
    return baseSpacing;
  }
}
