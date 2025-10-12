import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../repositories/asset_master_new_repository.dart';
import '../entities/asset_brand.dart';

class FindAllAssetBrandUseCase {
  final AssetMasterNewRepository _repository;

  FindAllAssetBrandUseCase(this._repository);

  Future<Either<Failure, List<AssetBrand>>> call() async {
    return _repository.findAllAssetBrand();
  }
}
