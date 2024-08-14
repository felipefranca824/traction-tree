import 'package:folder_tree/src/features/assets/domain/entities/asset_base.dart';
import 'package:folder_tree/src/features/assets/domain/entities/component.dart';
import 'package:folder_tree/src/features/assets/domain/entities/main_asset.dart';

abstract class AssetAdapter {
  static AssetBase fromMap(Map<String, dynamic> map) {
    final sensorType = map['sensorType'] != null
        ? SensorType.fromApiValue(map['sensorType'] as String)
        : null;

    if (sensorType != null) {
      final status = Status.fromApiValue(map['status'] as String);
      return Component(
        id: map['id'],
        name: map['name'],
        sensorType: sensorType,
        status: status,
        locationId: map['locationId'],
        parentId: map['parentId'],
      );
    }

    if (map['parentId'] != null) {
      return MainAsset(
        id: map['id'],
        name: map['name'],
        parentId: map['parentId'],
      );
    }

    if (map['locationId'] != null) {
      return MainAsset(
        id: map['id'],
        name: map['name'],
        locationId: map['locationId'],
      );
    }

    return MainAsset(
      id: map['id'],
      name: map['name'],
    );
  }
}
