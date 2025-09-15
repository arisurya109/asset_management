import '../../../../core/error/failure.dart';
import '../entities/asset_master.dart';
import '../repositories/asset_master_repository.dart';

import 'package:dartz/dartz.dart';

class UpdateAssetMasterUseCase {
  final AssetMasterRepository _repository;

  UpdateAssetMasterUseCase(this._repository);

  Future<Either<Failure, AssetMaster>> call(AssetMaster params) async {
    return _repository.updateAssetMaster(params);
  }
}
