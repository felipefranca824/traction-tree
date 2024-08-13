import 'package:folder_tree/src/core/services/rest_client/dtos/client_request_dto.dart';
import 'package:folder_tree/src/core/services/rest_client/rest_client_service.dart';
import 'package:folder_tree/src/features/menu/data/models/company_model.dart';
import 'package:folder_tree/src/features/menu/domain/entities/company.dart';

import './company_datasource.dart';

class CompanyDatasourceImpl implements CompanyDatasource {
  final RestClientService restClientService;

  CompanyDatasourceImpl({required this.restClientService});
  @override
  Future<List<Company>> getAll() async {
    final response =
        await restClientService.get(const ClientRequestDTO(path: 'companies'));

    return (response.body as List)
        .map((company) => CompanyModel.fromMap(company))
        .toList();
  }
}
