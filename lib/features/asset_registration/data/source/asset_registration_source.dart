import '../model/asset_registration_model.dart';

abstract class AssetRegistrationSource {
  Future<List<AssetRegistrationModel>> findAllAssetRegistration();
  Future<AssetRegistrationModel> createAssetRegistration(
    AssetRegistrationModel params,
  );
  Future<AssetRegistrationModel> createAssetRegistrationConsumable(
    AssetRegistrationModel params,
  );
  Future<AssetRegistrationModel> migrationAsset(AssetRegistrationModel params);
}
