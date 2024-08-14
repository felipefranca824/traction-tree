import 'package:flutter_modular/flutter_modular.dart';
import 'package:folder_tree/src/features/assets/presenter/pages/assets_page.dart';
import 'data/repositories/asset_repository_impl.dart';
import 'domain/repositories/location_repository.dart';
import 'domain/usecases/fetch_locations_usecase.dart';
import 'data/datasources/asset_datasource.dart';
import 'data/datasources/asset_datasource_impl.dart';
import 'data/datasources/location_datasource.dart';
import 'data/datasources/location_datasource_impl.dart';

import '../../core/routes/routes.dart';
import '../shared/shared_module.dart';
import 'data/repositories/location_repository_impl.dart';
import 'domain/repositories/asset_repository.dart';
import 'presenter/controllers/asset_controller.dart';

class AssetsModule extends Module {
  @override
  List<Module> get imports => [
        SharedModule(),
      ];

  @override
  void binds(i) {
    i.addLazySingleton<AssetDatasource>(AssetDatasourceImpl.new);
    i.addLazySingleton<LocationDatasource>(LocationDatasourceImpl.new);
    i.addLazySingleton<LocationRepository>(LocationRepositoryImpl.new);
    i.addLazySingleton<AssetRepository>(AssetRepositoryImpl.new);
    i.addLazySingleton<FetchLocationsUsecase>(FetchLocationsUsecase.new);
    i.addLazySingleton<AssetController>(AssetController.new);
  }

  @override
  void routes(r) {
    r.child(Routes.assets.path, child: (context) => const AssetsPage());
  }
}
