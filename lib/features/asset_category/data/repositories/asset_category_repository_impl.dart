import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/asset_category/data/model/asset_category_model.dart';
import 'package:asset_management/features/asset_category/data/source/asset_category_remote_data_source.dart';
import 'package:asset_management/features/asset_category/domain/entities/asset_category.dart';
import 'package:asset_management/features/asset_category/domain/repositories/asset_category_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';

class AssetCategoryRepositoryImpl implements AssetCategoryRepository {
  final AssetCategoryRemoteDataSource _source;

  AssetCategoryRepositoryImpl(this._source);

  @override
  Future<Either<Failure, AssetCategory>> createAssetCategory(
    AssetCategory params,
  ) async {
    try {
      final response = await _source.createAssetCategory(
        AssetCategoryModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetCategory>>> findAllAssetCategory() async {
    try {
      final response = await _source.findAllAssetCategory();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
