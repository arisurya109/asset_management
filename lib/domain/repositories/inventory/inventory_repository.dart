import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/inventory/inventory.dart';
import 'package:dartz/dartz.dart';

abstract class InventoryRepository {
  Future<Either<Failure, Inventory>> findInventory(String params);
}
