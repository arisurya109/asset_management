import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/repositories/asset/asset_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssetTransferUseCase {
  final AssetRepository _repository;

  CreateAssetTransferUseCase(this._repository);

  Future<Either<Failure, AssetEntity>> call({
    required int assetId,
    required String movementType,
    required int fromLocationId,
    required int toLocationId,
    int quantity = 1,
    String? notes,
  }) async {
    return _repository.createAssetTransfer(
      assetId: assetId,
      movementType: movementType,
      fromLocationId: fromLocationId,
      toLocationId: toLocationId,
      quantity: quantity,
      notes: notes,
    );
  }
}
