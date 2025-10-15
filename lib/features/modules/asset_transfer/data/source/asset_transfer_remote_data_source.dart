import 'package:asset_management/features/modules/asset_transfer/data/model/asset_transfer_model.dart';

abstract class AssetTransferRemoteDataSource {
  Future<String> createAssetTransfer(AssetTransferModel params);
}
