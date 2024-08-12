import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'app_text_theme.dart';

class AppTheme {
  static ThemeData get() {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        color: AppThemeColors.blueDark,
        centerTitle: true,
      ),
      colorScheme: const AppColorScheme(),
      textTheme: const AppTextTheme(),
    );
  }
}
