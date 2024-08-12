import 'package:flutter/material.dart';

class AppThemeColors {
  static const primary = Color(0xff2188FF);
  static const white = Colors.white;
  static const blueDark = Color(0xff17192D);
}

class AppColorScheme extends ColorScheme {
  const AppColorScheme({
    super.brightness = Brightness.light,
    super.primary = AppThemeColors.primary,
    super.onPrimary = AppThemeColors.white,
    super.secondary = AppThemeColors.blueDark,
    super.onSecondary = AppThemeColors.white,
    super.error = Colors.red,
    super.onError = AppThemeColors.white,
    super.background = AppThemeColors.white,
    super.onBackground = AppThemeColors.primary,
    super.surface = AppThemeColors.white,
    super.onSurface = AppThemeColors.primary,
    super.surfaceVariant = AppThemeColors.primary,
  });
}
