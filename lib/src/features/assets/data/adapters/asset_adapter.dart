import 'package:folder_tree/src/core/exceptions/app_exceptions.dart';
import 'package:folder_tree/src/features/assets/domain/entities/asset_base.dart';
import 'package:folder_tree/src/features/assets/domain/entities/component.dart';
import 'package:folder_tree/src/features/assets/domain/entities/main_asset.dart';

abstract class AssetAdapter {
  static AssetBase fromMap(Map<String, dynamic> map) {
    if (map['sensorType'] != null) {
      return Component(
        id: map['id'],
        name: map['name'],
        sensorType: SensorType.fromApiValue(map['sensorType'] as String),
        status: Status.fromApiValue(map['status'] as String),
        parentId: map['parentId'],
        locationId: map['locationId'],
      );
    }

    if (map['locationId'] != null && map['sensorType'] == null) {
      return MainAsset(
        id: map['id'],
        name: map['name'],
        locationId: map['locationId'],
      );
    }

    if (map['parentId'] != null && map['sensorType'] == null) {
      return MainAsset(
        id: map['id'],
        name: map['name'],
        parentId: map['parentId'],
      );
    }

    throw const AppException(message: 'Asset não mapeado');
  }
}
