import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/master/asset_category.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetCategoryUseCase {
  final MasterRepository _repository;

  FindAllAssetCategoryUseCase(this._repository);

  Future<Either<Failure, List<AssetCategory>>> call() async {
    return _repository.findAllAssetCategory();
  }
}
