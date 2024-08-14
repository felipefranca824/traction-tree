import 'package:flutter_test/flutter_test.dart';
import 'package:folder_tree/src/features/assets/data/adapters/asset_adapter.dart';
import 'package:folder_tree/src/features/assets/domain/entities/component.dart';
import 'package:folder_tree/src/features/assets/domain/entities/main_asset.dart';

void main() {
  group('AssetAdapter.fromMap', () {
    test('Deve criar um Component quando sensorType e status estão presentes',
        () {
      final map = {
        'id': '123',
        'name': 'Fan - External',
        'sensorType': 'energy',
        'status': 'operating',
        'locationId': null,
        'parentId': null,
      };

      final asset = AssetAdapter.fromMap(map);

      expect(asset, isA<Component>());
      expect((asset as Component).sensorType, equals(SensorType.energy));
      expect(asset.status, equals(Status.operating));
      expect(asset.id, equals('123'));
      expect(asset.name, equals('Fan - External'));
      expect(asset.locationId, isNull);
      expect(asset.parentId, isNull);
    });

    test('Deve criar um MainAsset quando parentId está presente', () {
      final map = {
        'id': '456',
        'name': 'MOTOR TC01 COAL UNLOADING AF02',
        'parentId': '789',
      };

      final asset = AssetAdapter.fromMap(map);

      expect(asset, isA<MainAsset>());
      expect(asset.id, equals('456'));
      expect(asset.name, equals('MOTOR TC01 COAL UNLOADING AF02'));
      expect(asset.parentId, equals('789'));
      expect(asset.locationId, isNull);
    });

    test('Deve criar um MainAsset quando locationId está presente', () {
      final map = {
        'id': '789',
        'name': 'CONVEYOR BELT ASSEMBLY',
        'locationId': '456',
      };

      final asset = AssetAdapter.fromMap(map);

      expect(asset, isA<MainAsset>());
      expect(asset.id, equals('789'));
      expect(asset.name, equals('CONVEYOR BELT ASSEMBLY'));
      expect(asset.locationId, equals('456'));
      expect(asset.parentId, isNull);
    });

    test(
        'Deve criar um MainAsset desconectado quando locationId e parentId são nulos',
        () {
      final map = {
        'id': '101112',
        'name': 'Disconnected Asset',
        'locationId': null,
        'parentId': null,
      };

      final asset = AssetAdapter.fromMap(map);

      expect(asset, isA<MainAsset>());
      expect(asset.id, equals('101112'));
      expect(asset.name, equals('Disconnected Asset'));
      expect(asset.locationId, isNull);
      expect(asset.parentId, isNull);
    });
  });
}
