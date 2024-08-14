import '../../../../core/domain/base_usecase.dart';
import '../../../../core/errors/app_failure.dart';
import '../entities/location.dart';

abstract interface class LocationRepository {
  AsyncResult<List<Location>, AppFailure> getAll(String companyId);
}
