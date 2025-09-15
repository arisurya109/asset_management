import '../model/asset_preparation_detail_model.dart';
import '../model/asset_preparation_model.dart';

abstract class AssetPreparationSource {
  Future<List<AssetPreparationModel>> findAllPreparations();
  Future<AssetPreparationModel> createPreparation(AssetPreparationModel params);
  Future<AssetPreparationModel> updateStatusPreparation(
    AssetPreparationModel params,
  );
  Future<String> exportPreparation(int preparationId);

  Future<List<AssetPreparationDetailModel>> findAllAssetPreparation(
    int preparationId,
  );
  Future<AssetPreparationDetailModel> insertAssetPreparation(
    AssetPreparationDetailModel params,
  );
  Future<String> deleteAssetPreparation(AssetPreparationDetailModel params);
}
