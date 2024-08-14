import 'asset_base.dart';
import 'component.dart';

class MainAsset extends AssetBase {
  final List<AssetBase> _subAssets = [];
  final List<Component> _components = [];

  MainAsset({
    required super.id,
    required super.name,
    super.locationId,
    super.parentId,
  });

  void addSubAsset(AssetBase asset) {
    _subAssets.add(asset);
  }

  void addComponent(Component component) {
    _components.add(component);
  }

  List<AssetBase> get subAssets => _subAssets;

  List<Component> get components => _components;

  @override
  String toString() =>
      'MainAsset(name: $name, subAssets: $subAssets, components: $components)';
}
