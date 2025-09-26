import '../../../../core/error/failure.dart';
import '../repositories/reprint_repository.dart';

import 'package:dartz/dartz.dart';

class ReprintAssetIdNormalBySerialNumberUseCase {
  final ReprintRepository _repository;

  ReprintAssetIdNormalBySerialNumberUseCase(this._repository);

  Future<Either<Failure, void>> call(String params) async {
    return _repository.reprintAssetIdNormalBySerialNumber(params);
  }
}
