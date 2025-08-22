import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/reprint/domain/repositories/reprint_repository.dart';
import 'package:dartz/dartz.dart';

class ReprintLocationUseCase {
  final ReprintRepository _repository;

  ReprintLocationUseCase(this._repository);

  Future<Either<Failure, void>> call(String location) async {
    return _repository.reprintLocation(location);
  }
}
