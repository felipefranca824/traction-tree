import '../entities/company.dart';

import '../../../../core/domain/base_usecase.dart';
import '../../../../core/errors/app_failure.dart';

abstract interface class CompanyRepository {
  AsyncResult<List<Company>, AppFailure> getAll();
}
