import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/inventory/inventory.dart';
import 'package:asset_management/domain/repositories/inventory/inventory_repository.dart';
import 'package:dartz/dartz.dart';

class FindInventoryUseCase {
  final InventoryRepository _repository;

  FindInventoryUseCase(this._repository);

  Future<Either<Failure, Inventory>> call(String params) async {
    return _repository.findInventory(params);
  }
}
