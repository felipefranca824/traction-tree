import 'core/services/injector/injector.dart';

import 'core/services/rest_client/dio/dio_client_service.dart';
import 'core/services/rest_client/dio/factories/dio_factory.dart';
import 'core/services/rest_client/rest_client_service.dart';
import 'features/menu/presenter/controller/menu_controller.dart';

class AppInjections {
  static void registerBinds() {
    Injector.registerLazySingleton<RestClientService>(
      DioClientService(
        dio: DioFactory.create(),
      ),
    );
    Injector.registerFactory<MenuController>(
      MenuController(),
    );
  }
}
