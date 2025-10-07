import '../model/asset_registration_model.dart';

abstract class AssetRegistrationSource {
  Future<String> create(AssetRegistrationModel params);
  Future<String> reRegistration(AssetRegistrationModel params);
  Future<List<AssetRegistrationModel>> findAllAsset();
}
