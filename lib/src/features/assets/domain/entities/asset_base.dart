import 'tree_element_base.dart';

abstract class AssetBase extends TreeElementBase {
  final String? locationId;
  final String? parentId;

  AssetBase({
    required super.id,
    required super.name,
    this.locationId,
    this.parentId,
  });

  @override
  String toString() => 'Asset(name: $name)';
}
