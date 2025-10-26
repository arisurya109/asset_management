import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetTypeUseCase {
  final MasterRepository _repository;

  FindAllAssetTypeUseCase(this._repository);

  Future<Either<Failure, List<AssetType>>> call() async {
    return _repository.findAllAssetType();
  }
}
