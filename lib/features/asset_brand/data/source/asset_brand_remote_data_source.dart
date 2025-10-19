import '../model/asset_brand_model.dart';

abstract class AssetBrandRemoteDataSource {
  Future<List<AssetBrandModel>> findAllAssetBrand();
  Future<AssetBrandModel> createAssetBrand(AssetBrandModel params);
}
