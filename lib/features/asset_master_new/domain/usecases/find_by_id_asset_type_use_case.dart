import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_type.dart';
import '../repositories/asset_master_new_repository.dart';

class FindByIdAssetTypeUseCase {
  final AssetMasterNewRepository _repository;

  FindByIdAssetTypeUseCase(this._repository);

  Future<Either<Failure, AssetType>> call(int params) async {
    return _repository.findByIdAssetType(params);
  }
}
