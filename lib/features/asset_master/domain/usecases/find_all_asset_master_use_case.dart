import '../../../../core/error/failure.dart';
import '../entities/asset_master.dart';
import '../repositories/asset_master_repository.dart';

import 'package:dartz/dartz.dart';

class FindAllAssetMasterUseCase {
  final AssetMasterRepository _repository;

  FindAllAssetMasterUseCase(this._repository);

  Future<Either<Failure, List<AssetMaster>>> call() async {
    return _repository.findAllAssetMaster();
  }
}
