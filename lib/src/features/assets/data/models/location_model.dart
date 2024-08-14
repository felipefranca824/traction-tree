import '../../domain/entities/location.dart';

class LocationModel extends Location {
  LocationModel({required super.id, required super.name, super.parentId});

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] as String,
      name: map['name'] as String,
      parentId: map['parentId'] as String?,
    );
  }
}
