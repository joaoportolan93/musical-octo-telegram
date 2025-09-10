import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ResponsiveLayout {
  // Breakpoints para diferentes tamanhos de tela
  static const double mobileBreakpoint = 768;
  static const double tabletBreakpoint = 1024;
  static const double desktopBreakpoint = 1440;
  
  // Detectar se é web
  static bool get isWeb => kIsWeb;
  
  // Detectar se é mobile
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }
  
  // Detectar se é tablet
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }
  
  // Detectar se é desktop/web
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }
  
  // Obter largura máxima para web
  static double getMaxWidth(BuildContext context) {
    if (isWeb) {
      final screenWidth = MediaQuery.of(context).size.width;
      if (screenWidth > desktopBreakpoint) {
        return desktopBreakpoint;
      } else if (screenWidth > tabletBreakpoint) {
        return tabletBreakpoint;
      }
    }
    return double.infinity;
  }
  
  // Obter padding horizontal para web
  static double getHorizontalPadding(BuildContext context) {
    if (isWeb && isDesktop(context)) {
      return 22.0;
    }
    return 12.0;
  }
  
  // Obter padding vertical para web
  static double getVerticalPadding(BuildContext context) {
    if (isWeb && isDesktop(context)) {
      return 16.0;
    }
    return 8.0;
  }
  
  // Obter tamanho de fonte baseado na plataforma
  static double getFontSize(BuildContext context, double baseSize) {
    if (isWeb && isDesktop(context)) {
      return baseSize * 0.9; // Reduzir um pouco no web
    }
    return baseSize;
  }
  
  // Obter tamanho de ícone baseado na plataforma
  static double getIconSize(BuildContext context, double baseSize) {
    if (isWeb && isDesktop(context)) {
      return baseSize * 0.8; // Reduzir ícones no web
    }
    return baseSize;
  }
  
  // Obter espaçamento baseado na plataforma
  static double getSpacing(BuildContext context, double baseSpacing) {
    if (isWeb && isDesktop(context)) {
      return baseSpacing * 0.8; // Reduzir espaçamentos no web
    }
    return baseSpacing;
  }
}
