import 'package:flutter/material.dart';

class AppColorsTheme {
  static const primary = Color(0xff2188FF);
  static const white = Colors.white;
  static const secondary = Color(0xff17192D);
  static const green = Color(0xff52C41A);
  static const red = Color(0xFFED3833);
  static const neutral100 = Color(0xFFEAEFF3);
  static const neutral500 = Color(0xFF8E98A3);
}

class AppColorScheme extends ColorScheme {
  const AppColorScheme({
    super.brightness = Brightness.light,
    super.primary = AppColorsTheme.primary,
    super.onPrimary = AppColorsTheme.neutral100,
    super.secondary = AppColorsTheme.secondary,
    super.onSecondary = AppColorsTheme.neutral500,
    super.error = AppColorsTheme.red,
    super.onError = AppColorsTheme.white,
    super.background = AppColorsTheme.white,
    super.onBackground = AppColorsTheme.primary,
    super.surface = AppColorsTheme.white,
    super.onSurface = AppColorsTheme.primary,
    super.surfaceVariant = AppColorsTheme.primary,
  });
}
