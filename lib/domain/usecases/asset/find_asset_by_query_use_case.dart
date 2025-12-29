import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/repositories/asset/asset_repository.dart';
import 'package:dartz/dartz.dart';

class FindAssetByQueryUseCase {
  final AssetRepository _repository;

  FindAssetByQueryUseCase(this._repository);

  Future<Either<Failure, List<AssetEntity>>> call({
    required String params,
  }) async {
    return _repository.findAssetByQuery(params: params);
  }
}
