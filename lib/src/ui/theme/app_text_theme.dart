import 'package:flutter/material.dart';

import 'app_color_scheme.dart';

final class AppTextTheme {
  static const TextStyle headlineLarge =
      TextStyle(color: AppColorsTheme.secondary, fontWeight: FontWeight.bold, fontSize: 18);
  static const TextStyle headlineMedium =
      TextStyle(color: AppColorsTheme.secondary, fontWeight: FontWeight.bold, fontSize: 14);
  static const headlineSmall =
      TextStyle(color: AppColorsTheme.secondary, fontWeight: FontWeight.bold, fontSize: 12);
  static const bodyLarge =
      TextStyle(color: AppColorsTheme.secondary, fontWeight: FontWeight.w400, fontSize: 16);
  static const bodyMedium =
      TextStyle(color: AppColorsTheme.secondary, fontWeight: FontWeight.w400, fontSize: 14);
  static const bodySmall =
      TextStyle(color: AppColorsTheme.secondary, fontWeight: FontWeight.w300, fontSize: 12);
  static const labelLarge =
      TextStyle(color: AppColorsTheme.secondary, fontWeight: FontWeight.w400, fontSize: 18);
  static const labelMedium =
      TextStyle(color: AppColorsTheme.secondary, fontWeight: FontWeight.w400, fontSize: 14);
  static const labelSmall =
      TextStyle(color: AppColorsTheme.secondary, fontWeight: FontWeight.w400, fontSize: 12);
  static const titleMedium =
      TextStyle(color: AppColorsTheme.secondary, fontWeight: FontWeight.w400, fontSize: 16);
  static const titleLarge =
      TextStyle(color: AppColorsTheme.secondary, fontWeight: FontWeight.w400, fontSize: 18);

  static const TextTheme textThemeLight = TextTheme(
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
    titleMedium: titleMedium,
    titleLarge: titleLarge,
  );
}
