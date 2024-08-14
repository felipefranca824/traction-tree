import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:folder_tree/src/core/errors/app_failure.dart';
import 'package:folder_tree/src/features/assets/domain/entities/component.dart';
import 'package:folder_tree/src/features/assets/domain/entities/location.dart';
import 'package:folder_tree/src/features/assets/domain/entities/main_asset.dart';
import 'package:folder_tree/src/features/assets/domain/repositories/asset_repository.dart';
import 'package:folder_tree/src/features/assets/domain/repositories/location_repository.dart';
import 'package:folder_tree/src/features/assets/domain/usecases/fetch_locations_usecase.dart';
import 'package:mocktail/mocktail.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockAssetRepository extends Mock implements AssetRepository {}

void main() {
  late MockLocationRepository mockLocationRepository;
  late MockAssetRepository mockAssetRepository;
  late FetchLocationsUsecase usecase;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    mockAssetRepository = MockAssetRepository();
    usecase = FetchLocationsUsecase(
      locationRepository: mockLocationRepository,
      assetRepository: mockAssetRepository,
    );
  });

  test(
      'Deve retornar uma lista de locations com assets corretamente estruturados',
      () async {
    final locations = [
      Location(id: 'loc1', name: 'Location 1'),
      Location(id: 'loc2', name: 'Location 2', parentId: 'loc1'),
    ];

    final assets = [
      MainAsset(id: 'asset1', name: 'Asset 1', locationId: 'loc1'),
      MainAsset(id: 'asset2', name: 'Asset 2', parentId: 'asset1'),
      Component(
          id: 'component1',
          name: 'Component 1',
          sensorType: SensorType.energy,
          status: Status.operating,
          parentId: 'asset2'),
    ];

    when(() => mockLocationRepository.getAll(any()))
        .thenAnswer((_) async => Left(locations));
    when(() => mockAssetRepository.getAll(any()))
        .thenAnswer((_) async => Left(assets));

    final result = await usecase('companyId');

    expect(result.isLeft(), isTrue);

    final resultLocations = result.getLeft().getOrElse(() => []);
    expect(resultLocations.length, equals(1));
    expect(resultLocations.first.id, equals('loc1'));
    expect(resultLocations.first.subLocations.length, equals(1));
    expect(resultLocations.first.assets.length, equals(1));

    final subLocation = resultLocations.first.subLocations.first;
    expect(subLocation.id, equals('loc2'));

    final mainAsset = resultLocations.first.assets.first as MainAsset;
    expect(mainAsset.id, equals('asset1'));
    expect(mainAsset.subAssets.length, equals(1));

    final subAsset = mainAsset.subAssets.first as MainAsset;
    expect(subAsset.id, equals('asset2'));
    expect(subAsset.components.length, equals(1));

    final component = subAsset.components.first;
    expect(component.id, equals('component1'));
    expect(component.sensorType, equals(SensorType.energy));
  });

  test('Deve retornar erro quando falha em obter locations', () async {
    when(() => mockAssetRepository.getAll(any())).thenAnswer(
        (_) async => Right(AppFailure(messageError: 'Failed to load assets')));
    when(() => mockLocationRepository.getAll(any())).thenAnswer((_) async =>
        Right(AppFailure(messageError: 'Failed to load locations')));

    final result = await usecase('companyId');

    expect(result.isRight(), isTrue);
    expect(
        result
            .getRight()
            .getOrElse(() => AppFailure(messageError: ''))
            .messageError,
        equals('Failed to load locations'));
  });

  test('Deve retornar erro quando falha em obter assets', () async {
    when(() => mockLocationRepository.getAll(any())).thenAnswer(
        (_) async => Left([Location(id: 'loc1', name: 'Location 1')]));
    when(() => mockAssetRepository.getAll(any())).thenAnswer(
        (_) async => Right(AppFailure(messageError: 'Failed to load assets')));

    final result = await usecase('companyId');

    expect(result.isRight(), isTrue);
    expect(
        result
            .getRight()
            .getOrElse(() => AppFailure(messageError: ''))
            .messageError,
        equals('Failed to load assets'));
  });
}
