import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/asset/asset_detail.dart';
import 'package:asset_management/domain/repositories/asset/asset_repository.dart';
import 'package:dartz/dartz.dart';

class FindAssetDetailByIdUseCase {
  final AssetRepository _repository;

  FindAssetDetailByIdUseCase(this._repository);

  Future<Either<Failure, List<AssetDetail>>> call(int params) async {
    return _repository.findAssetDetailById(params);
  }
}
