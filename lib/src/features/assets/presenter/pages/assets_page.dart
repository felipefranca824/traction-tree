import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:folder_tree/src/core/utils/custom_navigation.dart';
import 'package:folder_tree/src/features/assets/domain/entities/location.dart';
import 'package:folder_tree/src/features/assets/presenter/controllers/asset_controller.dart';
import 'package:folder_tree/src/ui/theme/extensions/text_extension.dart';

import '../../../../ui/widgets/tree_node_custom.dart';
import '../../domain/entities/component.dart';
import '../../domain/entities/main_asset.dart';
import '../../domain/entities/tree_element_base.dart';
import '../controllers/asset_state.dart';
import '../widgets/asset_card.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  late final AssetController controller;

  @override
  void initState() {
    controller = Modular.get<AssetController>();
    controller.fetchLocations();
    super.initState();
  }

  List<TreeNodeCustom> _buildTreeNodes(List<TreeElementBase> elements) {
    return elements.map((element) {
      if (element is Location) {
        return TreeNodeCustom(
          content: AssetCard(element: element),
          children: [
            ..._buildTreeNodes(List<TreeElementBase>.from(element.assets)),
            ..._buildTreeNodes(
                List<TreeElementBase>.from(element.subLocations)),
          ],
        );
      } else if (element is MainAsset) {
        return TreeNodeCustom(
          content: AssetCard(element: element),
          children: [
            ..._buildTreeNodes(List<TreeElementBase>.from(element.subAssets)),
            ..._buildTreeNodes(List<TreeElementBase>.from(element.components)),
          ],
        );
      } else if (element is Component) {
        return TreeNodeCustom(
          content: AssetCard(element: element),
        );
      } else {
        throw Exception('Tipo desconhecido de TreeElementBase');
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            CustomNavigator.pop();
          },
        ),
        title: Text('Assets', style: context.texts.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: ValueListenableBuilder(
            valueListenable: controller.state,
            builder: (context, state, _) {
              return switch (state) {
                AssetStateInitial() => const SizedBox.shrink(),
                AssetStateLoading() => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                AssetStateError(errorMessage: final errorMessage) => Center(
                    child: Text(
                      errorMessage,
                    ),
                  ),
                AssetStateLoaded(locations: final locations) => TreeViewCustom(
                    nodes: _buildTreeNodes(locations),
                  ),
              };
            }),
      ),
    );
  }
}
