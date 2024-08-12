import 'package:flutter/material.dart';

extension ColorsExtension on BuildContext {
  ColorScheme get colors => Theme.of(this).colorScheme;
}
