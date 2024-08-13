import 'package:flutter/material.dart';
import 'package:folder_tree/src/features/menu/domain/entities/company.dart';
import '../../../../ui/theme/extensions/text_extension.dart';
import '../../../../ui/theme/extensions/colors_extension.dart';

class CompanyCard extends StatelessWidget {
  final Company company;
  final ValueChanged<Company> onTap;

  const CompanyCard({super.key, required this.company, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(company);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: 24,
          horizontal: 32,
        ),
        decoration: BoxDecoration(
          color: context.colors.primary,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          company.name,
          style: context.texts.titleMedium,
        ),
      ),
    );
  }
}
