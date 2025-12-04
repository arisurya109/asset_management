import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/repositories/asset/asset_repository.dart';
import 'package:dartz/dartz.dart';

class FindAssetByAssetCodeAndLocationUseCase {
  final AssetRepository _repository;

  FindAssetByAssetCodeAndLocationUseCase(this._repository);

  Future<Either<Failure, AssetEntity>> call({
    required String assetCode,
    required String location,
  }) async {
    return _repository.findAssetByAssetCodeAndLocation(
      assetCode: assetCode,
      location: location,
    );
  }
}
