import 'package:folder_tree/src/core/domain/base_usecase.dart';

import 'package:folder_tree/src/core/errors/app_failure.dart';
import 'package:folder_tree/src/features/assets/data/datasources/asset_datasource.dart';
import 'package:folder_tree/src/features/assets/domain/entities/asset_base.dart';

import 'package:fpdart/fpdart.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../../../../core/services/rest_client/exceptions/rest_client_exception.dart';
import '../../domain/repositories/asset_repository.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetDatasource _assetDatasource;

  AssetRepositoryImpl({required AssetDatasource assetDatasource})
      : _assetDatasource = assetDatasource;
  @override
  AsyncResult<List<AssetBase>, AppFailure> getAll(String companyId) async {
    try {
      final assets = await _assetDatasource.getAll(companyId);
      return left(assets);
    } on ClientException catch (e) {
      return right(AppFailure(messageError: e.message));
    } on AppException catch (e) {
      return right(AppFailure(messageError: e.message));
    } catch (e) {
      return right(AppFailure(messageError: e.toString()));
    }
  }
}
