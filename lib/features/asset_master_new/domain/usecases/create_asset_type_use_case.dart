import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../repositories/asset_master_new_repository.dart';
import '../entities/asset_type.dart';

class CreateAssetTypeUseCase {
  final AssetMasterNewRepository _repository;

  CreateAssetTypeUseCase(this._repository);

  Future<Either<Failure, AssetType>> call(AssetType params) async {
    return _repository.createAssetType(params);
  }
}
