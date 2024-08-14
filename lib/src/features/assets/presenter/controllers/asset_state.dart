// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../domain/entities/location.dart';
import '../dto/filter_type.dart';

sealed class AssetStateBase {}

class AssetStateInitial implements AssetStateBase {}

class AssetStateLoading implements AssetStateBase {}

class AssetStateLoaded implements AssetStateBase {
  final List<Location> locations;
  final List<Location> locationsFilter;
  final FilterType? filterType;
  AssetStateLoaded({
    required this.locations,
    this.locationsFilter = const [],
    this.filterType,
  });

  AssetStateLoaded copyWith({
    List<Location>? locations,
    List<Location>? locationsFilter,
    ValueGetter<FilterType?>? filterType,
  }) {
    return AssetStateLoaded(
      locations: locations ?? this.locations,
      locationsFilter: locationsFilter ?? this.locationsFilter,
      filterType: filterType != null ? filterType() : this.filterType,
    );
  }
}

class AssetStateError implements AssetStateBase {
  final String errorMessage;

  AssetStateError({required this.errorMessage});
}
