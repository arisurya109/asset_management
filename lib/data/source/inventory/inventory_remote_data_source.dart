import 'package:asset_management/data/model/inventory/inventory_model.dart';

abstract class InventoryRemoteDataSource {
  Future<InventoryModel> findInventory(String params);
}
