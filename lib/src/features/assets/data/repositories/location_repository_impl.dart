import 'package:folder_tree/src/core/domain/base_usecase.dart';

import 'package:folder_tree/src/core/errors/app_failure.dart';

import 'package:folder_tree/src/features/assets/domain/entities/location.dart';
import 'package:fpdart/fpdart.dart';

import '../../domain/repositories/location_repository.dart';
import '../datasources/location_datasource.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDatasource _locationDatasource;

  LocationRepositoryImpl({required LocationDatasource locationDatasource})
      : _locationDatasource = locationDatasource;
  @override
  AsyncResult<List<Location>, AppFailure> getAll(String companyId) async {
    try {
      final locations = await _locationDatasource.getAll(companyId);
      return left(locations);
    } catch (e) {
      return right(AppFailure(messageError: e.toString()));
    }
  }
}
