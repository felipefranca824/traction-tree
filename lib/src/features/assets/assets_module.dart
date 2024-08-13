import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/routes/routes.dart';
import '../shared/shared_module.dart';

class AssetsModule extends Module {
  @override
  List<Module> get imports => [
        SharedModule(),
      ];

  @override
  void binds(i) {}

  @override
  void routes(r) {
    r.child(Routes.assets.path, child: (context) => Container());
  }
}
