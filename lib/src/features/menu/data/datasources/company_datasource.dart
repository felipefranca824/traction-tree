import '../../domain/entities/company.dart';

abstract interface class CompanyDatasource {
  Future<List<Company>> getAll();
}
