import 'package:asset_management/features/asset_brand/domain/repositories/asset_brand_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_brand.dart';

class CreateAssetBrandUseCase {
  final AssetBrandRepository _repository;

  CreateAssetBrandUseCase(this._repository);

  Future<Either<Failure, AssetBrand>> call(AssetBrand params) async {
    return _repository.createAssetBrand(params);
  }
}
