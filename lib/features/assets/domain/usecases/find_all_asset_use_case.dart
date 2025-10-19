import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/assets/domain/entities/asset_entity.dart';
import 'package:asset_management/features/assets/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetUseCase {
  final AssetsRepository _repository;

  FindAllAssetUseCase(this._repository);

  Future<Either<Failure, List<AssetsEntity>>> call() async {
    return _repository.findAllAsset();
  }
}
