import 'package:flutter/foundation.dart';
import 'package:folder_tree/src/features/assets/domain/usecases/fetch_locations_usecase.dart';
import 'package:folder_tree/src/features/shared/services/company_service.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/location.dart';
import 'asset_state.dart';

class AssetController {
  final FetchLocationsUsecase _fetchLocationsUsecase;
  final CompanyService _companyService;
  AssetController({
    required FetchLocationsUsecase fetchLocationsUsecase,
    required CompanyService companyService,
  })  : _fetchLocationsUsecase = fetchLocationsUsecase,
        _companyService = companyService;

  ValueNotifier<AssetStateBase> state = ValueNotifier(AssetStateInitial());

  Future<void> fetchLocations() async {
    state.value = AssetStateLoading();
    final companyId = _companyService.companyIdSelected;
    final result = await compute<String, Either<List<Location>, AppFailure>>(
        _fetchLocationsInBackground, companyId);

    result.fold((locations) {
      state.value = AssetStateLoaded(locations: locations);
    }, (failure) {
      state.value = AssetStateError(errorMessage: failure.messageError);
    });
  }

  Future<Either<List<Location>, AppFailure>> _fetchLocationsInBackground(
      String companyId) async {
    return await _fetchLocationsUsecase(companyId);
  }
}
