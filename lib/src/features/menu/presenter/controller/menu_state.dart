import '../../domain/entities/company.dart';

sealed class MenuStateBase {}

class MenuStateInitial implements MenuStateBase {}

class MenuStateLoading implements MenuStateBase {}

class MenuStateLoadedCompanies implements MenuStateBase {
  final List<Company> companies;

  MenuStateLoadedCompanies({required this.companies});
}

class MenuStateError implements MenuStateBase {
  final String errorMessage;

  MenuStateError({required this.errorMessage});
}
