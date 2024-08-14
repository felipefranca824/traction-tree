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
import 'package:folder_tree/src/features/assets/presenter/dto/filter_type.dart';
import 'package:folder_tree/src/features/shared/services/company_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/app_failure.dart';
import '../../data/datasources/asset_datasource.dart';
import '../../data/datasources/asset_datasource_impl.dart';
import '../../data/repositories/asset_repository_impl.dart';
import '../../domain/entities/component.dart';
import '../../domain/entities/location.dart';
import '../../domain/repositories/asset_repository.dart';
import 'asset_state.dart';

class AssetController {
  final CompanyService _companyService;
  AssetController({
    required FetchLocationsUsecase fetchLocationsUsecase,
    required CompanyService companyService,
  }) : _companyService = companyService;

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
      state.value = newState.copyWith(locationsFilter: newState.locations);
      return;
    }

    final locations = _filterByName(name);

    state.value = newState.copyWith(locationsFilter: locations);
  }

  List<Location> _filterByName(String name) {
    List<Location> results = [];
    final locations = (state.value as AssetStateLoaded).locationsFilter;
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

  void filter(FilterType? type) {
    if (type == null) {
      state.value = (state.value as AssetStateLoaded).copyWith(
          locationsFilter: (state.value as AssetStateLoaded).locations,
          filterType: () => type);
      return;
    }

    final locations = switch (type) {
      FilterType.sensor => _filterBySensorType(SensorType.energy),
      FilterType.status => _filterByStatus(Status.alert),
    };

    state.value = (state.value as AssetStateLoaded)
        .copyWith(locationsFilter: locations, filterType: () => type);
  }

  List<Location> _filterBySensorType(SensorType sensorType) {
    final locations = (state.value as AssetStateLoaded).locationsFilter;
    List<Location> matchingLocations = [];
    for (var location in locations) {
      if (_containsSensorType(location, sensorType)) {
        matchingLocations.add(location);
      }
    }
    return matchingLocations;
  }

  bool _containsSensorType(Location location, SensorType sensorType) {
    for (var asset in location.assets) {
      if (asset is Component && asset.sensorType == sensorType) return true;

      if (asset is MainAsset) {
        for (var subAsset in asset.subAssets) {
          if (subAsset is Component && subAsset.sensorType == sensorType) {
            return true;
          }
        }
      }
    }

    for (var subLocation in location.subLocations) {
      if (_containsSensorType(subLocation, sensorType)) return true;
    }

    return false;
  }

  List<Location> _filterByStatus(Status status) {
    final locations = (state.value as AssetStateLoaded).locationsFilter;
    List<Location> matchingLocations = [];
    for (var location in locations) {
      if (_containsStatus(location, status)) {
        matchingLocations.add(location);
      }
    }
    return matchingLocations;
  }

  bool _containsStatus(Location location, Status status) {
    for (var asset in location.assets) {
      if (asset is Component && asset.status == status) return true;

      if (asset is MainAsset) {
        for (var subAsset in asset.subAssets) {
          if (subAsset is Component && subAsset.status == status) return true;
        }
      }
    }

    for (var subLocation in location.subLocations) {
      if (_containsStatus(subLocation, status)) return true;
    }

    return false;
  }
}
