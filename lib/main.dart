import 'package:flutter/material.dart';

import 'src/app_injections.dart';
import 'src/app_widget.dart';

void main() {
  AppInjections.registerBinds();
  runApp(const AppWidget());
}
