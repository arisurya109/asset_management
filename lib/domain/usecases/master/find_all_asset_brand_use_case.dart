import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetBrandUseCase {
  final MasterRepository _repository;

  FindAllAssetBrandUseCase(this._repository);

  Future<Either<Failure, List<AssetBrand>>> call() async {
    return _repository.findAllAssetBrand();
  }
}
