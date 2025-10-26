import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetModelUseCase {
  final MasterRepository _repository;

  FindAllAssetModelUseCase(this._repository);

  Future<Either<Failure, List<AssetModel>>> call() async {
    return _repository.findAllAssetModel();
  }
}
