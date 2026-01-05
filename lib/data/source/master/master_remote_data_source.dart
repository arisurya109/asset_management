import 'package:asset_management/data/model/master/asset_brand_model.dart';
import 'package:asset_management/data/model/master/asset_category_model.dart';
import 'package:asset_management/data/model/master/asset_model_model.dart';
import 'package:asset_management/data/model/master/asset_type_model.dart';
import 'package:asset_management/data/model/master/location_model.dart';
import 'package:asset_management/data/model/master/preparation_template_item_model.dart';
import 'package:asset_management/data/model/master/preparation_template_model.dart';
import 'package:asset_management/data/model/master/vendor_model.dart';

abstract class MasterRemoteDataSource {
  Future<List<AssetTypeModel>> findAllAssetType();
  Future<List<AssetBrandModel>> findAllAssetBrand();
  Future<List<AssetCategoryModel>> findAllAssetCategory();
  Future<List<AssetModelModel>> findAllAssetModel();
  Future<List<LocationModel>> findAllLocation();
  Future<List<VendorModel>> findAllVendor();

  Future<List<AssetBrandModel>> findAssetBrandByQuery(String params);
  Future<List<AssetCategoryModel>> findAssetCategoryByQuery(String params);
  Future<List<AssetModelModel>> findAssetModelByQuery(String params);

  Future<AssetTypeModel> createAssetType(AssetTypeModel params);
  Future<AssetBrandModel> createAssetBrand(AssetBrandModel params);
  Future<AssetCategoryModel> createAssetCategory(AssetCategoryModel params);
  Future<AssetModelModel> createAssetModel(AssetModelModel params);
  Future<LocationModel> createLocation(LocationModel params);
  Future<VendorModel> createVendor(VendorModel params);

  // Preparation Template
  Future<PreparationTemplateModel> createPreparationTemplate(
    PreparationTemplateModel params,
  );
  Future<List<PreparationTemplateModel>> findAllPreparationTemplate();
  Future<String> deletePreparationTemplate(int params);

  // Preparation Template Item
  Future<List<PreparationTemplateItemModel>> createPreparationTemplateItem(
    List<PreparationTemplateItemModel> params,
    int templateId,
  );
  Future<List<PreparationTemplateItemModel>>
  findAllPreparationTemplateItemByTemplateId(int params);

  // Location
  Future<List<LocationModel>> findLocationByQuery(String query);
  Future<List<LocationModel>> findLocationByStorage(String params);
  Future<List<String>> findLocationType();
}
