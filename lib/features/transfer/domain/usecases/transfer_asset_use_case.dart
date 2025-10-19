import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/transfer/domain/entities/transfer.dart';
import 'package:asset_management/features/transfer/domain/repositories/transfer_repository.dart';
import 'package:dartz/dartz.dart';

class TransferAssetUseCase {
  final TransferRepository _repository;

  TransferAssetUseCase(this._repository);

  Future<Either<Failure, String>> call(Transfer params) async {
    return _repository.transferAsset(params);
  }
}
