import 'package:asset_management/data/model/asset/asset_detail_model.dart';
import 'package:asset_management/data/model/asset/asset_model.dart';

abstract class AssetRemoteDataSource {
  Future<List<AssetsModel>> findAllAsset();
  Future<AssetsModel> createAsset(AssetsModel params);
  Future<List<AssetDetailModel>> findAssetDetailById(int params);
  Future<AssetsModel> createAssetTransfer({
    required int assetId,
    required String movementType,
    required int fromLocationId,
    required int toLocationId,
    int quantity = 1,
    String? notes,
  });
  Future<AssetsModel> findAssetByAssetCodeAndLocation({
    required String assetCode,
    required String location,
  });
}
