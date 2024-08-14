import 'package:flutter/material.dart';

import 'app_color_scheme.dart';
import 'app_text_theme.dart';

class AppTheme {
  static final _defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      gapPadding: 8,
      borderSide: const BorderSide(color: AppColorsTheme.neutral100));
  static ThemeData get() {
    return ThemeData(
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        color: AppColorsTheme.secondary,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: AppColorsTheme.white,
        ),
      ),
      colorScheme: const AppColorScheme(),
      textTheme: AppTextTheme.textThemeLight,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        fillColor: AppColorsTheme.neutral100,
        contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        labelStyle: AppTextTheme.bodyLarge.copyWith(
          color: AppColorsTheme.neutral500,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: AppTextTheme.bodyLarge.copyWith(
          color: AppColorsTheme.neutral500,
          fontWeight: FontWeight.w500,
        ),
        hintStyle: AppTextTheme.labelMedium.copyWith(
          color: AppColorsTheme.neutral500,
        ),
        errorStyle: AppTextTheme.bodyLarge.copyWith(
          color: AppColorsTheme.red,
        ),
        iconColor: AppColorsTheme.neutral500,
        border: _defaultInputBorder,
        enabledBorder: _defaultInputBorder,
        focusedBorder: _defaultInputBorder,
        errorBorder: _defaultInputBorder.copyWith(
          borderSide: const BorderSide(
            color: AppColorsTheme.red,
          ),
        ),
      ),
    );
  }
}
