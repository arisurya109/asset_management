import '../../../../core/error/failure.dart';
import '../repositories/reprint_repository.dart';

import 'package:dartz/dartz.dart';

class ReprintAssetIdLargeUseCase {
  final ReprintRepository _repository;

  ReprintAssetIdLargeUseCase(this._repository);

  Future<Either<Failure, void>> call(String params) async {
    return _repository.reprintAssetIdLarge(params);
  }
}
