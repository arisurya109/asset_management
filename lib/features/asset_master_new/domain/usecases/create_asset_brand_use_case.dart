import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_brand.dart';
import '../repositories/asset_master_new_repository.dart';

class CreateAssetBrandUseCase {
  final AssetMasterNewRepository _repository;

  CreateAssetBrandUseCase(this._repository);

  Future<Either<Failure, AssetBrand>> call(AssetBrand params) async {
    return _repository.createAssetBrand(params);
  }
}
