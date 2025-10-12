import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_category.dart';
import '../repositories/asset_master_new_repository.dart';

class FindByIdAssetCategoryUseCase {
  final AssetMasterNewRepository _repository;

  FindByIdAssetCategoryUseCase(this._repository);

  Future<Either<Failure, AssetCategory>> call(int params) async {
    return _repository.findByIdAssetCategory(params);
  }
}
