import '../../../../core/utils/enum.dart';
import '../model/asset_count_detail_model.dart';
import '../model/asset_count_model.dart';

abstract class AssetCountSource {
  Future<List<AssetCountModel>> findAllAssetCount();
  Future<AssetCountModel> createAssetCount(AssetCountModel params);
  Future<AssetCountModel> updateStatusAssetCount(int id, StatusCount params);
  Future<String> exportAssetCountId(int params);

  Future<List<AssetCountDetailModel>> findAllAssetCountDetailByIdCount(
    int params,
  );
  Future<AssetCountDetailModel> insertAssetCountDetail(
    AssetCountDetailModel params,
  );
  Future<void> deleteAssetCountDetail(int countId, String assetId);
}
