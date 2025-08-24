import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/repositories/reprint_repository.dart';
import 'package:dartz/dartz.dart';

class ReprintAssetIdByAssetIdUseCase {
  final ReprintRepository _repository;

  ReprintAssetIdByAssetIdUseCase(this._repository);

  Future<Either<Failure, void>> call(String assetId) async {
    return _repository.reprintAssetIdByAssetId(assetId);
  }
}
