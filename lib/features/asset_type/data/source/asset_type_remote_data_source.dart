import 'package:asset_management/features/asset_type/data/model/asset_type_model.dart';

abstract class AssetTypeRemoteDataSource {
  Future<AssetTypeModel> createAssetType(AssetTypeModel params);
  Future<List<AssetTypeModel>> findAllAssetType();
}
