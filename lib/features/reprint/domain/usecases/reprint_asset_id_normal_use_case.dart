import '../../../../core/error/failure.dart';
import '../repositories/reprint_repository.dart';

import 'package:dartz/dartz.dart';

class ReprintAssetIdNormalUseCase {
  final ReprintRepository _repository;

  ReprintAssetIdNormalUseCase(this._repository);

  Future<Either<Failure, void>> call(String params) async {
    return _repository.reprintAssetIdNormal(params);
  }
}
