import 'package:folder_tree/src/features/assets/domain/entities/asset_base.dart';

import '../../../../core/services/rest_client/dtos/client_request_dto.dart';
import '../../../../core/services/rest_client/rest_client_service.dart';
import '../adapters/asset_adapter.dart';
import './asset_datasource.dart';

class AssetDatasourceImpl implements AssetDatasource {
  final RestClientService _restClientService;

  AssetDatasourceImpl({required RestClientService restClientService})
      : _restClientService = restClientService;
  @override
  Future<List<AssetBase>> getAll(String companyId) async {
    final response = await _restClientService
        .get(ClientRequestDTO(path: '/companies/$companyId/assets'));

    return (response.body as List)
        .map((location) => AssetAdapter.fromMap(location))
        .toList();
  }
}
