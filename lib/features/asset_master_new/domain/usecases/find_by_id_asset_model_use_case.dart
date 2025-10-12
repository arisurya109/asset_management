import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_model.dart';
import '../repositories/asset_master_new_repository.dart';

class FindByIdAssetModelUseCase {
  final AssetMasterNewRepository _repository;

  FindByIdAssetModelUseCase(this._repository);

  Future<Either<Failure, AssetModel>> call(int params) async {
    return _repository.findByIdAssetModel(params);
  }
}
