import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_model.dart';
import '../repositories/asset_master_new_repository.dart';

class UpdateAssetModelUseCase {
  final AssetMasterNewRepository _repository;

  UpdateAssetModelUseCase(this._repository);

  Future<Either<Failure, AssetModel>> call(AssetModel params) async {
    return _repository.updateAssetModel(params);
  }
}
