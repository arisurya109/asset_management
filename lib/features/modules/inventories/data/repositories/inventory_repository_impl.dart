import '../source/inventory_remote_data_source.dart';
import '../../domain/entities/inventory.dart';
import '../../domain/repositories/inventory_repository.dart';
import '../../../../../core/core.dart';
import 'package:dartz/dartz.dart';

class InventoryRepositoryImpl implements InventoryRepository {
  final InventoryRemoteDataSource _source;

  InventoryRepositoryImpl(this._source);

  @override
  Future<Either<Failure, List<Inventory>>> findAllAssetInventory() async {
    try {
      final response = await _source.findAllAssetInventory();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
