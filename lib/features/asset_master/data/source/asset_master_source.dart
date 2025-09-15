import '../model/asset_master_model.dart';

abstract class AssetMasterSource {
  Future<List<AssetMasterModel>> findAllAssetMaster();
  Future<AssetMasterModel> insertAssetMaster(AssetMasterModel params);
  Future<AssetMasterModel> updateAssetMaster(AssetMasterModel params);
}
