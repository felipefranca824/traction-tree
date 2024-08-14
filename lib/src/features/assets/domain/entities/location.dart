import 'asset_base.dart';
import 'tree_element_base.dart';

class Location extends TreeElementBase {
  final String? parentId;
  final List<Location> _subLocations = [];
  final List<AssetBase> _assets = [];

  Location({
    required super.id,
    required super.name,
    this.parentId,
  });

  void addSubLocation(Location location) {
    _subLocations.add(location);
  }

  void addAsset(AssetBase asset) {
    _assets.add(asset);
  }

  List<Location> get subLocations => _subLocations;

  List<AssetBase> get assets => _assets;
}
