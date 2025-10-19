import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_category/domain/entities/asset_category.dart';
import 'package:dartz/dartz.dart';

abstract class AssetCategoryRepository {
  Future<Either<Failure, AssetCategory>> createAssetCategory(
    AssetCategory params,
  );
  Future<Either<Failure, List<AssetCategory>>> findAllAssetCategory();
}
