import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/data/source/inventory/inventory_remote_data_source.dart';
import 'package:asset_management/domain/entities/inventory/inventory.dart';
import 'package:asset_management/domain/repositories/inventory/inventory_repository.dart';
import 'package:dartz/dartz.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryRemoteDataSource _source;

  InventoryRepositoryImpl(this._source);

  @override
  Future<Either<Failure, Inventory>> findInventory(String params) async {
    try {
      final response = await _source.findInventory(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
