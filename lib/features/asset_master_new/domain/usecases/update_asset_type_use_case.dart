import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../repositories/asset_master_new_repository.dart';
import '../entities/asset_type.dart';

class UpdateAssetTypeUseCase {
  final AssetMasterNewRepository _repository;

  UpdateAssetTypeUseCase(this._repository);

  Future<Either<Failure, AssetType>> call(AssetType params) async {
    return _repository.updateAssetType(params);
  }
}
