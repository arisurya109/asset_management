import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/asset_type/domain/entities/asset_type.dart';
import 'package:asset_management/features/asset_type/domain/repositories/asset_type_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetTypeUseCase {
  final AssetTypeRepository _repository;

  FindAllAssetTypeUseCase(this._repository);

  Future<Either<Failure, List<AssetType>>> call() async {
    return _repository.findAllAssetType();
  }
}
