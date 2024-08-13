abstract interface class CompanyService {
  set companyIdSelected(String id);
  String get companyIdSelected;
}

class CompanyServiceImpl implements CompanyService {
  late String _companyIdSelected;

  @override
  String get companyIdSelected => _companyIdSelected;

  @override
  set companyIdSelected(String id) => _companyIdSelected = id;
}
