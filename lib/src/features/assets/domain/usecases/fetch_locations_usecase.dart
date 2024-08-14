import 'package:folder_tree/src/core/errors/app_failure.dart';
import 'package:folder_tree/src/core/extensions/extension_list.dart';
import 'package:folder_tree/src/features/assets/domain/entities/asset_base.dart';
import 'package:folder_tree/src/features/assets/domain/repositories/asset_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../entities/component.dart';
import '../entities/main_asset.dart';
import '../repositories/location_repository.dart';

import '../../../../core/domain/base_usecase.dart';
import '../entities/location.dart';

class FetchLocationsUsecase extends BaseUsecase<String, List<Location>> {
  final LocationRepository _locationRepository;
  final AssetRepository _assetRepository;

  FetchLocationsUsecase(
      {required LocationRepository locationRepository,
      required AssetRepository assetRepository})
      : _locationRepository = locationRepository,
        _assetRepository = assetRepository;
  @override
  AsyncResult<List<Location>, AppFailure> call(String param) async {
    final results = await Future.wait([
      _locationRepository.getAll(param),
      _assetRepository.getAll(param),
    ]);
    var error = results.firstWhereOrNull((result) => result.isRight());

    if (error != null) return Right((error as Right).value);
    final locations = (results[0] as Left<List<Location>, AppFailure>).value;

    final assets = (results[1] as Left<List<AssetBase>, AppFailure>).value;

    return Left(_buildTree(locations, assets));
  }

  List<Location> _buildTree(List<Location> locations, List<AssetBase> assets) {
    // Mapa de Locations e Assets por ID
    final Map<String, Location> locationMap = {};
    final Map<String, AssetBase> assetMap = {};
    // Criar mapa de Locations
    for (var loc in locations) {
      locationMap[loc.id] = loc;
    }

    // Organizar subLocations
    for (var loc in locations) {
      if (loc.parentId != null) {
        locationMap[loc.parentId]?.addSubLocation(loc);
      }
    }

    // Criar mapa de Assets e organizar a árvore
    for (var asset in assets) {
      if (asset is MainAsset) {
        assetMap[asset.id] = asset;
      }

      if (asset.locationId != null) {
        locationMap[asset.locationId]?.addAsset(asset);
      } else if (asset.parentId != null) {
        (assetMap[asset.parentId] as MainAsset?)?.addSubAsset(asset);
      } else if (asset is Component) {
        (assetMap[asset.parentId] as MainAsset?)?.addComponent(asset);
      }
    }

    // Retornar a lista de Locations raiz (que não têm parentId)
    return locationMap.values.where((loc) => loc.parentId == null).toList();
  }
}
