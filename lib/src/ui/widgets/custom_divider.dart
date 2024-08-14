import 'package:flutter/material.dart';
import '../theme/extensions/colors_extension.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: context.colors.onPrimary,
    );
  }
}
