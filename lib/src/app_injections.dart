import 'core/services/injector/injector.dart';

import 'features/menu/presenter/controller/menu_controller.dart';

class AppInjections {
  static void registerBinds() {
    Injector.registerFactory<MenuController>(
      MenuController(),
    );
  }
}
