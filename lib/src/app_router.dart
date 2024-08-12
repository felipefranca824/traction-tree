import 'package:flutter/material.dart';
import 'package:folder_tree/src/features/menu/presenter/pages/menu_page.dart';

import 'core/routes/routes.dart';

typedef RouteBuilder = Widget Function(BuildContext);

class AppRouter {
  static final AppRouter instance = AppRouter._internal();

  factory AppRouter() => instance;

  AppRouter._internal();

  final navigatorKey = GlobalKey<NavigatorState>();

  final Map<Routes, RouteBuilder> _routes = {
    Routes.menu: (_) => const MenuPage(),
  };

  Map<String, RouteBuilder> get routes =>
      _routes.map((route, builder) => MapEntry(route.path, builder));
}
