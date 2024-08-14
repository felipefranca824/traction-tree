import 'package:flutter/material.dart';
import 'package:folder_tree/src/ui/theme/extensions/colors_extension.dart';
import 'package:folder_tree/src/ui/theme/extensions/text_extension.dart';

import '../../../../ui/images/image_enum.dart';
import '../../../../ui/theme/app_color_scheme.dart';
import '../../domain/entities/component.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/main_asset.dart';
import '../../domain/entities/tree_element_base.dart';

class AssetCard extends StatelessWidget {
  final TreeElementBase element;
  const AssetCard({super.key, required this.element});

  String get imagePath {
    return switch (element) {
      Location() => ImageEnum.location.path,
      MainAsset() => ImageEnum.asset.path,
      Component() => ImageEnum.component.path,
      _ => ImageEnum.location.path
    };
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28,
      child: Row(
        children: [
          SizedBox(
            height: 22,
            width: 22,
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            width: 4,
          ),
          Text(
            element.name,
            style: context.texts.bodyMedium?.copyWith(
              color: context.colors.secondary,
            ),
          ),
          Visibility(
            visible: element is Component &&
                (element as Component).sensorType == SensorType.energy,
            child: const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Icon(
                Icons.electric_bolt,
                color: AppColorsTheme.green,
                size: 10,
              ),
            ),
          ),
          Visibility(
            visible: element is Component &&
                (element as Component).status == Status.alert,
            child: Container(
              height: 8,
              width: 8,
              margin: const EdgeInsets.only(left: 4),
              decoration: BoxDecoration(
                color: context.colors.error,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }
}
