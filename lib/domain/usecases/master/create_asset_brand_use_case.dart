import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_brand.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssetBrandUseCase {
  final MasterRepository _repository;

  CreateAssetBrandUseCase(this._repository);

  Future<Either<Failure, AssetBrand>> call(AssetBrand params) async {
    return _repository.createAssetBrand(params);
  }
}
