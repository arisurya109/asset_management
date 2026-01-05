import 'package:asset_management/data/model/asset/asset_detail_model.dart';
import 'package:asset_management/data/model/asset/asset_model.dart';
import 'package:asset_management/data/model/asset/asset_model_pagination.dart';

abstract class AssetRemoteDataSource {
  Future<List<AssetsModel>> findAllAsset();
  Future<AssetsModel> registrationAsset(AssetsModel params);
  Future<AssetsModel> migrationAsset(AssetsModel params);
  Future<List<AssetDetailModel>> findAssetDetailById(int params);
  Future<List<AssetsModel>> findAssetByQuery({required String params});
  Future<AssetModelPagination> findAssetByPagination({
    required int page,
    required int limit,
    String? query,
  });
}
