import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/master/asset_model.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindAssetModelByQueryUseCase {
  final MasterRepository _repository;

  FindAssetModelByQueryUseCase(this._repository);

  Future<Either<Failure, List<AssetModel>>> call(String params) async {
    return _repository.findAssetModelByQuery(params);
  }
}
