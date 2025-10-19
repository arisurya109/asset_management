import '../repositories/asset_category_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_category.dart';

class CreateAssetCategoryUseCase {
  final AssetCategoryRepository _repository;

  CreateAssetCategoryUseCase(this._repository);

  Future<Either<Failure, AssetCategory>> call(AssetCategory params) async {
    return _repository.createAssetCategory(params);
  }
}
