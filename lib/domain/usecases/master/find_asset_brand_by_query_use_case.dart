import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindAssetBrandByQueryUseCase {
  final MasterRepository _repository;

  FindAssetBrandByQueryUseCase(this._repository);

  Future<Either<Failure, List<AssetBrand>>> call(String params) async {
    return _repository.findAssetBrandByQuery(params);
  }
}
