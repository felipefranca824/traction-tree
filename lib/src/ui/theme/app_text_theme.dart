import 'package:flutter/material.dart';

import 'app_color_scheme.dart';

class AppTextTheme extends TextTheme {
  const AppTextTheme({
    super.titleMedium = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppThemeColors.white,
    ),
    super.headlineSmall = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppThemeColors.white,
    ),
  });
}
