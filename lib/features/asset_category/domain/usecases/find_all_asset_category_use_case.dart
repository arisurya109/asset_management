import '../repositories/asset_category_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_category.dart';

class FindAllAssetCategoryUseCase {
  final AssetCategoryRepository _repository;

  FindAllAssetCategoryUseCase(this._repository);

  Future<Either<Failure, List<AssetCategory>>> call() async {
    return _repository.findAllAssetCategory();
  }
}
