import '../../../../../core/error/failure.dart';
import '../entities/inventory.dart';
import '../repositories/inventory_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllInventoryUseCase {
  final InventoryRepository _repository;

  FindAllInventoryUseCase(this._repository);

  Future<Either<Failure, List<Inventory>>> call() async {
    return _repository.findAllAssetInventory();
  }
}
