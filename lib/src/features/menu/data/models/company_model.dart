import '../../domain/entities/company.dart';

class CompanyModel extends Company {
  CompanyModel({required super.id, required super.name});

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }
}
