// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:folder_tree/src/features/menu/presenter/controller/menu_state.dart';
import 'package:folder_tree/src/ui/theme/extensions/colors_extension.dart';
import 'package:folder_tree/src/ui/theme/extensions/text_extension.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/utils/custom_navigation.dart';
import '../../domain/entities/company.dart';
import '../controller/companies_controller.dart';
import '../widgets/company_card.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({
    super.key,
  });

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  late final CompaniesController controller;

  @override
  void initState() {
    controller = Modular.get<CompaniesController>();
    controller.fetchCompanies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TRACTIAN',
          style: context.texts.headlineLarge
              ?.copyWith(color: context.colors.surface),
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: controller.state,
          builder: (context, state, _) {
            return switch (state) {
              MenuStateInitial() => const SizedBox.shrink(),
              MenuStateLoading() => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              MenuStateError(errorMessage: final errorMessage) => Center(
                  child: Text(
                    errorMessage,
                  ),
                ),
              MenuStateLoadedCompanies(companies: final companies) =>
                MenuPageLoaded(
                  companies: companies,
                  onTap: (company) {
                    controller.setCompanyId(company);
                    CustomNavigator.pushNamed(Routes.assets.path);
                  },
                ),
            };
          }),
    );
  }
}

class MenuPageLoaded extends StatelessWidget {
  final List<Company> companies;
  final ValueChanged<Company> onTap;
  const MenuPageLoaded({
    super.key,
    required this.companies,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(20),
      itemCount: companies.length,
      separatorBuilder: (context, index) => const SizedBox(
        height: 40,
      ),
      itemBuilder: (context, index) {
        return CompanyCard(company: companies[index], onTap: onTap);
      },
    );
  }
}
