import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_brand.dart';
import '../repositories/asset_master_new_repository.dart';

class FindByIdAssetBrandUseCase {
  final AssetMasterNewRepository _repository;

  FindByIdAssetBrandUseCase(this._repository);

  Future<Either<Failure, AssetBrand>> call(int params) async {
    return _repository.findByIdAssetBrand(params);
  }
}
