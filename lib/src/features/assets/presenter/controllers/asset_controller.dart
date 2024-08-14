import 'package:flutter/foundation.dart';
import 'package:folder_tree/src/core/services/rest_client/dio/dio_client_service.dart';
import 'package:folder_tree/src/core/services/rest_client/dio/factories/dio_factory.dart';
import 'package:folder_tree/src/core/services/rest_client/rest_client_service.dart';
import 'package:folder_tree/src/features/assets/data/datasources/location_datasource.dart';
import 'package:folder_tree/src/features/assets/data/datasources/location_datasource_impl.dart';
import 'package:folder_tree/src/features/assets/data/repositories/location_repository_impl.dart';
import 'package:folder_tree/src/features/assets/domain/entities/asset_base.dart';
import 'package:folder_tree/src/features/assets/domain/entities/main_asset.dart';
import 'package:folder_tree/src/features/assets/domain/repositories/location_repository.dart';
import 'package:folder_tree/src/features/assets/domain/usecases/fetch_locations_usecase.dart';
import 'package:folder_tree/src/features/shared/services/company_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/app_failure.dart';
import '../../data/datasources/asset_datasource.dart';
import '../../data/datasources/asset_datasource_impl.dart';
import '../../data/repositories/asset_repository_impl.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/asset_repository.dart';
import 'asset_state.dart';

class AssetController {
  final FetchLocationsUsecase _fetchLocationsUsecase;
  final CompanyService _companyService;
  AssetController({
    required FetchLocationsUsecase fetchLocationsUsecase,
    required CompanyService companyService,
  })  : _fetchLocationsUsecase = fetchLocationsUsecase,
        _companyService = companyService;

  ValueNotifier<AssetStateBase> state = ValueNotifier(AssetStateInitial());

  Future<void> fetchLocations() async {
    state.value = AssetStateLoading();
    final companyId = _companyService.companyIdSelected;
    final result = await compute<String, Either<List<Location>, AppFailure>>(
        _fetchLocationsInBackground, companyId);

    result.fold((locations) {
      state.value =
          AssetStateLoaded(locations: locations, locationsFilter: locations);
    }, (failure) {
      state.value = AssetStateError(errorMessage: failure.messageError);
    });
  }

  static Future<Either<List<Location>, AppFailure>> _fetchLocationsInBackground(
      String companyId) async {
    final fetchLocationsUsecase = _createUsecase();
    return await fetchLocationsUsecase(companyId);
  }

  static FetchLocationsUsecase _createUsecase() {
    final RestClientService restService =
        DioClientService(dio: DioFactory.create());
    final LocationDatasource locationDatasource =
        LocationDatasourceImpl(restClientService: restService);
    final AssetDatasource assetDatasource =
        AssetDatasourceImpl(restClientService: restService);
    final LocationRepository locationRepository =
        LocationRepositoryImpl(locationDatasource: locationDatasource);
    final AssetRepository assetRepository =
        AssetRepositoryImpl(assetDatasource: assetDatasource);
    return FetchLocationsUsecase(
        locationRepository: locationRepository,
        assetRepository: assetRepository);
  }

  void filterByName(String name) {
    if (state.value is! AssetStateLoaded) return;
    var newState = state.value as AssetStateLoaded;
    if (name.isEmpty) {
      state.value = AssetStateLoaded(
          locationsFilter: newState.locations, locations: newState.locations);
      return;
    }

    final locations = _filterByName(name);

    state.value = AssetStateLoaded(
        locationsFilter: locations, locations: newState.locations);
  }

  List<Location> _filterByName(String name) {
    List<Location> results = [];
    final locations = (state.value as AssetStateLoaded).locations;
    name = name.toLowerCase();
    for (var location in locations) {
      if (_filterLocationByName(location, name)) {
        results.add(location);
      }
    }

    return results;
  }

  bool _filterLocationByName(Location location, String name) {
    if (location.name.toLowerCase().contains(name)) {
      return true;
    }

    for (var asset in location.assets) {
      if (_filterAssetByName(asset, name)) {
        return true;
      }
    }

    for (var subLocation in location.subLocations) {
      if (_filterLocationByName(subLocation, name)) {
        return true;
      }
    }

    return false;
  }

  bool _filterAssetByName(AssetBase asset, String name) {
    if (asset.name.toLowerCase().contains(name)) {
      return true;
    }
    if (asset is! MainAsset) return false;
    for (var subAsset in asset.subAssets) {
      if (_filterAssetByName(subAsset, name)) {
        return true;
      }
    }

    for (var component in asset.components) {
      if (component.name.toLowerCase().contains(name)) {
        return true;
      }
    }

    return false;
  }
}
