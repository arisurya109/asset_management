import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_model.dart';
import '../repositories/asset_master_new_repository.dart';

class CreateAssetModelUseCase {
  final AssetMasterNewRepository _repository;

  CreateAssetModelUseCase(this._repository);

  Future<Either<Failure, AssetModel>> call(AssetModel params) async {
    return _repository.createAssetModel(params);
  }
}
