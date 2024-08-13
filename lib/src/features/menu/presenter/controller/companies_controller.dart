import 'package:flutter/material.dart';
import 'package:folder_tree/src/features/shared/services/company_service.dart';

import '../../domain/entities/company.dart';
import '../../domain/usecases/fetch_companies_usecase.dart';
import 'menu_state.dart';

class CompaniesController {
  final FetchCompaniesUsecase _fetchCompaniesUsecase;
  final CompanyService _companyService;

  ValueNotifier<MenuStateBase> state = ValueNotifier(MenuStateInitial());

  CompaniesController(
      {required FetchCompaniesUsecase fetchCompaniesUsecase,
      required CompanyService companyService})
      : _fetchCompaniesUsecase = fetchCompaniesUsecase,
        _companyService = companyService;

  Future<void> fetchCompanies() async {
    state.value = MenuStateLoading();

    final result = await _fetchCompaniesUsecase();

    result.fold((companies) {
      state.value = MenuStateLoadedCompanies(companies: companies);
    }, (failure) {
      state.value = MenuStateError(errorMessage: failure.messageError);
    });
  }

  void setCompanyId(Company company) =>
      _companyService.companyIdSelected = company.id;
}
