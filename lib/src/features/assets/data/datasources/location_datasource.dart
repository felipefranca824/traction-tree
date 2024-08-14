import '../models/location_model.dart';

abstract interface class LocationDatasource {
  Future<List<LocationModel>> getAll(String companyId);
}
