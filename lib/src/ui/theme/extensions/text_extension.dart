import 'package:flutter/material.dart';

extension TextExtension on BuildContext {
  TextTheme get texts => Theme.of(this).textTheme;
}
