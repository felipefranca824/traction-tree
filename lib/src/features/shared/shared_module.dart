import 'package:flutter_modular/flutter_modular.dart';
import 'package:folder_tree/src/features/shared/services/company_service.dart';

import '../../core/services/rest_client/dio/dio_client_service.dart';
import '../../core/services/rest_client/dio/factories/dio_factory.dart';
import '../../core/services/rest_client/rest_client_service.dart';

class SharedModule extends Module {
  @override
  List<Module> get imports => [];

  @override
  void exportedBinds(Injector i) {
    i.addInstance(DioFactory.create());
    i.addSingleton<RestClientService>(DioClientService.new);
    i.addSingleton<CompanyService>(CompanyServiceImpl.new);
    super.binds(i);
  }

  @override
  void routes(r) {}
}
