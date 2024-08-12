import 'package:flutter/material.dart';
import 'package:folder_tree/src/ui/theme/extensions/colors_extension.dart';
import 'package:folder_tree/src/ui/theme/extensions/text_extension.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TRACTIAN',
          style: context.texts.headlineSmall,
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              BaseCard(
                title: 'Jaguar Unit',
              ),
              SizedBox(
                height: 40,
              ),
              BaseCard(
                title: 'Tobias Unit',
              ),
              SizedBox(
                height: 40,
              ),
              BaseCard(
                title: 'Apex Unit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BaseCard extends StatelessWidget {
  final String title;
  const BaseCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
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
        title,
        style: context.texts.titleMedium,
      ),
    );
  }
}
