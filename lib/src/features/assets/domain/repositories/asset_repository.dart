import '../../../../core/domain/base_usecase.dart';
import '../../../../core/errors/app_failure.dart';
import '../entities/asset_base.dart';

abstract interface class AssetRepository {
  AsyncResult<List<AssetBase>, AppFailure> getAll(String companyId);
}
