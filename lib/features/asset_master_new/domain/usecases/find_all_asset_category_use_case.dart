import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../repositories/asset_master_new_repository.dart';
import '../entities/asset_category.dart';

class FindAllAssetCategoryUseCase {
  final AssetMasterNewRepository _repository;

  FindAllAssetCategoryUseCase(this._repository);

  Future<Either<Failure, List<AssetCategory>>> call() async {
    return _repository.findAllAssetCategory();
  }
}
