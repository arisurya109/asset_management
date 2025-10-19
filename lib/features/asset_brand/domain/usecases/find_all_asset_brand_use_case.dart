import 'package:asset_management/features/asset_brand/domain/repositories/asset_brand_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_brand.dart';

class FindAllAssetBrandUseCase {
  final AssetBrandRepository _repository;

  FindAllAssetBrandUseCase(this._repository);

  Future<Either<Failure, List<AssetBrand>>> call() async {
    return _repository.findAllAssetBrand();
  }
}
