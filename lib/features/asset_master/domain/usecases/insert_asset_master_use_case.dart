import '../../../../core/error/failure.dart';
import '../entities/asset_master.dart';
import '../repositories/asset_master_repository.dart';

import 'package:dartz/dartz.dart';

class InsertAssetMasterUseCase {
  final AssetMasterRepository _repository;

  InsertAssetMasterUseCase(this._repository);

  Future<Either<Failure, AssetMaster>> call(AssetMaster params) async {
    return _repository.insertAssetMaster(params);
  }
}
