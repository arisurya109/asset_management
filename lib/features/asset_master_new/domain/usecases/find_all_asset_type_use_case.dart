import '../../../../core/core.dart';
import '../entities/asset_type.dart';
import '../repositories/asset_master_new_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetTypeUseCase {
  final AssetMasterNewRepository _repository;

  FindAllAssetTypeUseCase(this._repository);

  Future<Either<Failure, List<AssetType>>> call() async {
    return _repository.findAllAssetType();
  }
}
