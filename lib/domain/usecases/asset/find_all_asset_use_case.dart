import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/repositories/asset/asset_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetUseCase {
  final AssetRepository _repository;

  FindAllAssetUseCase(this._repository);

  Future<Either<Failure, List<AssetEntity>>> call() async {
    return _repository.findAllAsset();
  }
}
