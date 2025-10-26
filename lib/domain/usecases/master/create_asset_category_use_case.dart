import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssetCategoryUseCase {
  final MasterRepository _repository;

  CreateAssetCategoryUseCase(this._repository);

  Future<Either<Failure, AssetCategory>> call(AssetCategory params) async {
    return _repository.createAssetCategory(params);
  }
}
