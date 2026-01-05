import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/repositories/asset/asset_repository.dart';
import 'package:dartz/dartz.dart';

class MigrationAssetUseCase {
  final AssetRepository _repository;

  MigrationAssetUseCase(this._repository);

  Future<Either<Failure, AssetEntity>> call(AssetEntity params) async {
    return _repository.migrationAsset(params);
  }
}
