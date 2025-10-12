import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_brand.dart';
import '../repositories/asset_master_new_repository.dart';

class UpdateAssetBrandUseCase {
  final AssetMasterNewRepository _repository;

  UpdateAssetBrandUseCase(this._repository);

  Future<Either<Failure, AssetBrand>> call(AssetBrand params) async {
    return _repository.updateAssetBrand(params);
  }
}
