import 'package:flutter/material.dart';
import 'package:folder_tree/src/ui/theme/extensions/colors_extension.dart';
import 'package:folder_tree/src/ui/theme/extensions/text_extension.dart';

import '../dto/filter_type.dart';

class FilterArgs {
  final FilterType type;
  final String name;
  final Widget icon;
  final ValueChanged<FilterType?> onTap;
  final bool isSelected;
  FilterArgs({
    required this.type,
    required this.name,
    required this.icon,
    required this.onTap,
    required this.isSelected,
  });
}

class FiltersWidget extends StatelessWidget {
  final ValueChanged<FilterType?> onSelect;
  final FilterType? selected;
  const FiltersWidget({
    super.key,
    required this.onSelect,
    this.selected,
  });

  @override
  Widget build(BuildContext context) {
    const color = Color(0xFF77818C);
    return Row(
      children: [
        FilterCard(
          args: FilterArgs(
            icon: const Icon(
              Icons.bolt_rounded,
              color: color,
              size: 16,
            ),
            type: FilterType.sensor,
            name: 'Sensor de energia',
            isSelected: selected == FilterType.sensor,
            onTap: onSelect,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        FilterCard(
          args: FilterArgs(
            icon: const Icon(
              Icons.crisis_alert,
              color: color,
              size: 16,
            ),
            type: FilterType.status,
            name: 'Crítico',
            isSelected: selected == FilterType.status,
            onTap: onSelect,
          ),
        ),
      ],
    );
  }
}

class FilterCard extends StatelessWidget {
  final FilterArgs args;
  const FilterCard({
    super.key,
    required this.args,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        args.onTap(args.isSelected ? null : args.type);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        decoration: BoxDecoration(
          color: context.colors.surface,
          border: Border.all(
              color: args.isSelected
                  ? context.colors.secondary
                  : context.colors.onSurface),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Row(
          children: [
            args.icon,
            const SizedBox(
              width: 8,
            ),
            Text(
              args.name,
              style: context.texts.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF77818C),
              ),
            )
          ],
        ),
      ),
    );
  }
}
