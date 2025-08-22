import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/reprint/domain/repositories/reprint_repository.dart';
import 'package:dartz/dartz.dart';

class ReprintAssetByAssetIdUseCase {
  final ReprintRepository _repository;

  ReprintAssetByAssetIdUseCase(this._repository);

  Future<Either<Failure, void>> call(String assetId) async {
    return _repository.reprintAssetByAssetId(assetId);
  }
}
