import 'package:asset_management/data/model/master/asset_brand_model.dart';
import 'package:asset_management/data/model/master/asset_category_model.dart';
import 'package:asset_management/data/model/master/asset_model_model.dart';
import 'package:asset_management/data/model/master/asset_type_model.dart';
import 'package:asset_management/data/model/master/location_model.dart';
import 'package:asset_management/data/model/master/vendor_model.dart';

abstract class MasterRemoteDataSource {
  Future<List<AssetTypeModel>> findAllAssetType();
  Future<List<AssetBrandModel>> findAllAssetBrand();
  Future<List<AssetCategoryModel>> findAllAssetCategory();
  Future<List<AssetModelModel>> findAllAssetModel();
  Future<List<LocationModel>> findAllLocation();
  Future<List<VendorModel>> findAllVendor();

  Future<AssetTypeModel> createAssetType(AssetTypeModel params);
  Future<AssetBrandModel> createAssetBrand(AssetBrandModel params);
  Future<AssetCategoryModel> createAssetCategory(AssetCategoryModel params);
  Future<AssetModelModel> createAssetModel(AssetModelModel params);
  Future<LocationModel> createLocation(LocationModel params);
  Future<VendorModel> createVendor(VendorModel params);
}
