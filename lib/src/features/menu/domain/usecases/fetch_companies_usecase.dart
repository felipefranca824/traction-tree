import 'package:folder_tree/src/core/errors/app_failure.dart';
import 'package:folder_tree/src/features/menu/domain/entities/company.dart';
import '../repositories/company_repository.dart';

import '../../../../core/domain/base_usecase.dart';

class FetchCompaniesUsecase extends BaseUsecaseNoParam<List<Company>> {
  final CompanyRepository companyRepository;

  FetchCompaniesUsecase({required this.companyRepository});
  @override
  AsyncResult<List<Company>, AppFailure> call() {
    return companyRepository.getAll();
  }
}
