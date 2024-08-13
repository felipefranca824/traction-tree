import '../../../../core/services/rest_client/exceptions/rest_client_exception.dart';
import '../../domain/entities/company.dart';

import '../../../../core/domain/base_usecase.dart';

import '../../../../core/errors/app_failure.dart';

import '../../domain/repositories/company_repository.dart';
import 'package:fpdart/fpdart.dart';

import '../datasources/company_datasource.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyDatasource companyDatasource;

  CompanyRepositoryImpl({required this.companyDatasource});
  @override
  AsyncResult<List<Company>, AppFailure> getAll() async {
    try {
      final companys = await companyDatasource.getAll();
      return left(companys);
    } on ClientException catch (e) {
      return right(AppFailure(messageError: e.message));
    } catch (e) {
      return right(AppFailure(messageError: e.toString()));
    }
  }
}
