import '../model/asset_inventory_model.dart';

abstract class InventoryRemoteDataSource {
  Future<List<InventoryModel>> findAllAssetInventory();
}
