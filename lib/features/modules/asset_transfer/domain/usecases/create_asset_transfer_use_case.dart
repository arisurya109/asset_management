import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/modules/asset_transfer/domain/entities/asset_transfer.dart';
import 'package:asset_management/features/modules/asset_transfer/domain/repositories/asset_transfer_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssetTransferUseCase {
  final AssetTransferRepository _repository;

  CreateAssetTransferUseCase(this._repository);

  Future<Either<Failure, String>> call(AssetTransfer params) async {
    return _repository.createAssetTransfer(params);
  }
}
