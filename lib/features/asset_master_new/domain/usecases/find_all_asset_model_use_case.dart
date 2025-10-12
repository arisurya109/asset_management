import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_model.dart';
import '../repositories/asset_master_new_repository.dart';

class FindAllAssetModelUseCase {
  final AssetMasterNewRepository _repository;

  FindAllAssetModelUseCase(this._repository);

  Future<Either<Failure, List<AssetModel>>> call() async {
    return _repository.findAllAssetModel();
  }
}
