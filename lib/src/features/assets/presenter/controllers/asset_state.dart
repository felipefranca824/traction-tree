import '../../domain/entities/location.dart';

sealed class AssetStateBase {}

class AssetStateInitial implements AssetStateBase {}

class AssetStateLoading implements AssetStateBase {}

class AssetStateLoaded implements AssetStateBase {
  final List<Location> locations;

  AssetStateLoaded({required this.locations});
}

class AssetStateError implements AssetStateBase {
  final String errorMessage;

  AssetStateError({required this.errorMessage});
}
