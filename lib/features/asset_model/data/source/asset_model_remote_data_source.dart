import 'package:asset_management/features/asset_model/data/model/asset_model_model.dart';

abstract class AssetModelRemoteDataSource {
  Future<AssetModelModel> createAssetModel(AssetModelModel params);
  Future<List<AssetModelModel>> findAllAssetModel();
}
