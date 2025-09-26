import '../../../../core/error/failure.dart';
import '../repositories/reprint_repository.dart';

import 'package:dartz/dartz.dart';

class ReprintAssetIdLargeBySerialNumberUseCase {
  final ReprintRepository _repository;

  ReprintAssetIdLargeBySerialNumberUseCase(this._repository);

  Future<Either<Failure, void>> call(String params) async {
    return _repository.reprintAssetIdLargeBySerialNumber(params);
  }
}
