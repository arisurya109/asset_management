import 'package:asset_management/features/asset_master_new/data/models/asset_brand_model.dart';
import 'package:asset_management/features/asset_master_new/data/models/asset_category_model.dart';
import 'package:asset_management/features/asset_master_new/data/models/asset_model_model.dart';
import 'package:asset_management/features/asset_master_new/data/models/asset_type_model.dart';

abstract class AssetMasterRemoteDataSource {
  // Find All
  Future<List<AssetTypeModel>> findAllAssetType();
  Future<List<AssetBrandModel>> findAllAssetBrand();
  Future<List<AssetCategoryModel>> findAllAssetCategory();
  Future<List<AssetModelModel>> findAllAssetModel();

  // Create
  Future<AssetTypeModel> createAssetType(AssetTypeModel params);
  Future<AssetCategoryModel> createAssetCategory(AssetCategoryModel params);
  Future<AssetBrandModel> createAssetBrand(AssetBrandModel params);
  Future<AssetModelModel> createAssetModel(AssetModelModel params);

  // Update
  Future<AssetTypeModel> updateAssetType(AssetTypeModel params);
  Future<AssetCategoryModel> updateAssetCategory(AssetCategoryModel params);
  Future<AssetBrandModel> updateAssetBrand(AssetBrandModel params);
  Future<AssetModelModel> updateAssetModel(AssetModelModel params);

  // Find By Id
  Future<AssetTypeModel> findByIdAssetType(int params);
  Future<AssetCategoryModel> findByIdAssetCategory(int params);
  Future<AssetBrandModel> findByIdAssetBrand(int params);
  Future<AssetModelModel> findByIdAssetModel(int params);
}
