import '../../../../../core/core.dart';
import '../entities/inventory.dart';
import 'package:dartz/dartz.dart';

abstract class InventoryRepository {
  Future<Either<Failure, List<Inventory>>> findAllAssetInventory();
}
