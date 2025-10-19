import 'package:asset_management/features/asset_category/data/model/asset_category_model.dart';

abstract class AssetCategoryRemoteDataSource {
  Future<AssetCategoryModel> createAssetCategory(AssetCategoryModel params);
  Future<List<AssetCategoryModel>> findAllAssetCategory();
}
