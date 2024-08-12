import 'package:flutter/material.dart';
import 'ui/theme/app_theme.dart';

import 'app_router.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Traction tree',
      theme: AppTheme.get(),
      debugShowCheckedModeBanner: false,
      routes: AppRouter.instance.routes,
    );
  }
}
