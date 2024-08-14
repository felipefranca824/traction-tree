import '../../domain/entities/asset_base.dart';

abstract interface class AssetDatasource {
  Future<List<AssetBase>> getAll(String companyId);
}
