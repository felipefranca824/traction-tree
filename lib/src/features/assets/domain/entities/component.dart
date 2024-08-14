import 'asset_base.dart';

enum SensorType {
  vibration(apiValue: 'vibration'),
  energy(apiValue: 'energy');

  final String apiValue;

  const SensorType({required this.apiValue});

  factory SensorType.fromApiValue(String value) =>
      SensorType.values.firstWhere((type) => type.apiValue == value);
}

enum Status {
  operating(apiValue: 'operating'),
  alert(apiValue: 'alert');

  final String apiValue;

  const Status({required this.apiValue});

  factory Status.fromApiValue(String value) =>
      Status.values.firstWhere((type) => type.apiValue == value);
}

class Component extends AssetBase {
  final SensorType sensorType;
  final Status status;

  Component({
    required super.id,
    required super.name,
    required this.sensorType,
    required this.status,
    super.parentId,
    super.locationId,
  });
}
