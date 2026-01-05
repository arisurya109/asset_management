import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindAssetCategoryByQueryUseCase {
  final MasterRepository _repository;

  FindAssetCategoryByQueryUseCase(this._repository);

  Future<Either<Failure, List<AssetCategory>>> call(String params) async {
    return _repository.findAssetCategoryByQuery(params);
  }
}
