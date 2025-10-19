import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_model/domain/entities/asset_model.dart';
import 'package:asset_management/features/asset_model/domain/repositories/asset_model_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssetModelUseCase {
  final AssetModelRepository _repository;

  CreateAssetModelUseCase(this._repository);

  Future<Either<Failure, AssetModel>> call(AssetModel params) async {
    return _repository.createAssetModel(params);
  }
}
