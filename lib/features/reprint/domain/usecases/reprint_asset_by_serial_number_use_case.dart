import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/reprint/domain/repositories/reprint_repository.dart';
import 'package:dartz/dartz.dart';

class ReprintAssetBySerialNumberUseCase {
  final ReprintRepository _repository;

  ReprintAssetBySerialNumberUseCase(this._repository);

  Future<Either<Failure, void>> call(String serialNumber) async {
    return _repository.reprintAssetBySerialNumber(serialNumber);
  }
}
