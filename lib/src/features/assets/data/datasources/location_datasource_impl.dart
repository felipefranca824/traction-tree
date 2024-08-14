import '../../../../core/services/rest_client/dtos/client_request_dto.dart';
import '../../../../core/services/rest_client/rest_client_service.dart';

import '../models/location_model.dart';
import './location_datasource.dart';

class LocationDatasourceImpl implements LocationDatasource {
  final RestClientService _restClientService;

  LocationDatasourceImpl({required RestClientService restClientService})
      : _restClientService = restClientService;
  @override
  Future<List<LocationModel>> getAll(String companyId) async {
    final response = await _restClientService
        .get(ClientRequestDTO(path: '/companies/$companyId/locations'));

    return (response.body as List).map((location) => LocationModel.fromMap(location)).toList();
  }
}
