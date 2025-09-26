import '../../../../core/error/failure.dart';
import '../repositories/reprint_repository.dart';

import 'package:dartz/dartz.dart';

class ReprintLocationUseCase {
  final ReprintRepository _repository;

  ReprintLocationUseCase(this._repository);

  Future<Either<Failure, void>> call(String params) async {
    return _repository.reprintLocation(params);
  }
}
