import 'package:flutter_modular/flutter_modular.dart';
import 'package:folder_tree/src/features/menu/domain/usecases/fetch_companies_usecase.dart';
import 'package:folder_tree/src/features/menu/presenter/controller/companies_controller.dart';
import '../shared/shared_module.dart';
import 'data/repositories/company_repository_impl.dart';
import 'domain/repositories/company_repository.dart';
import 'data/datasources/company_datasource.dart';
import 'presenter/pages/companies_page.dart';

import 'data/datasources/company_datasource_impl.dart';

class CompaniesModule extends Module {
  @override
  List<Module> get imports => [
        SharedModule(),
      ];

  @override
  void binds(i) {
    i.addLazySingleton<CompanyDatasource>(CompanyDatasourceImpl.new);
    i.addLazySingleton<CompanyRepository>(CompanyRepositoryImpl.new);
    i.addLazySingleton<FetchCompaniesUsecase>(FetchCompaniesUsecase.new);
    i.addLazySingleton<CompaniesController>(CompaniesController.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (context) => const CompaniesPage());
  }
}
