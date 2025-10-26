import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssetModelUseCase {
  final MasterRepository _repository;

  CreateAssetModelUseCase(this._repository);

  Future<Either<Failure, AssetModel>> call(AssetModel params) async {
    return _repository.createAssetModel(params);
  }
}
