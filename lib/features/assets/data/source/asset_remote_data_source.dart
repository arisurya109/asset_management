import 'package:asset_management/features/assets/data/model/asset_detail_model.dart';

import '../model/asset_model.dart';

abstract class AssetsRemoteDataSource {
  Future<List<AssetsModel>> findAllAsset();
  Future<List<AssetDetailModel>> findAssetDetailById(int params);
}
