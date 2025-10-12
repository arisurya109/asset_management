import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';
import '../entities/asset_brand.dart';
import '../entities/asset_type.dart';
import '../entities/asset_category.dart';
import '../entities/asset_model.dart';

abstract class AssetMasterNewRepository {
  // Find All
  Future<Either<Failure, List<AssetType>>> findAllAssetType();
  Future<Either<Failure, List<AssetBrand>>> findAllAssetBrand();
  Future<Either<Failure, List<AssetCategory>>> findAllAssetCategory();
  Future<Either<Failure, List<AssetModel>>> findAllAssetModel();

  // Create
  Future<Either<Failure, AssetType>> createAssetType(AssetType params);
  Future<Either<Failure, AssetCategory>> createAssetCategory(
    AssetCategory params,
  );
  Future<Either<Failure, AssetBrand>> createAssetBrand(AssetBrand params);
  Future<Either<Failure, AssetModel>> createAssetModel(AssetModel params);

  // Update
  Future<Either<Failure, AssetType>> updateAssetType(AssetType params);
  Future<Either<Failure, AssetCategory>> updateAssetCategory(
    AssetCategory params,
  );
  Future<Either<Failure, AssetBrand>> updateAssetBrand(AssetBrand params);
  Future<Either<Failure, AssetModel>> updateAssetModel(AssetModel params);

  // Find By Id
  Future<Either<Failure, AssetType>> findByIdAssetType(int params);
  Future<Either<Failure, AssetCategory>> findByIdAssetCategory(int params);
  Future<Either<Failure, AssetBrand>> findByIdAssetBrand(int params);
  Future<Either<Failure, AssetModel>> findByIdAssetModel(int params);
}
