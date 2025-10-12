import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_category.dart';
import '../repositories/asset_master_new_repository.dart';

class CreateAssetCategoryUseCase {
  final AssetMasterNewRepository _repository;

  CreateAssetCategoryUseCase(this._repository);

  Future<Either<Failure, AssetCategory>> call(AssetCategory params) async {
    return _repository.createAssetCategory(params);
  }
}
