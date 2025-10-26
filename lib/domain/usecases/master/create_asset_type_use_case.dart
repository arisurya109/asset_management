import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_type.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssetTypeUseCase {
  final MasterRepository _repository;

  CreateAssetTypeUseCase(this._repository);

  Future<Either<Failure, AssetType>> call(AssetType params) async {
    return _repository.createAssetType(params);
  }
}
