import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_model/domain/entities/asset_model.dart';
import 'package:asset_management/features/asset_model/domain/repositories/asset_model_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetModelUseCase {
  final AssetModelRepository _repository;

  FindAllAssetModelUseCase(this._repository);

  Future<Either<Failure, List<AssetModel>>> call() async {
    return _repository.findAllAssetModel();
  }
}
