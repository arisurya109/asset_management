import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:dartz/dartz.dart';

class FindLocationTypeUseCase {
  final MasterRepository _repository;

  FindLocationTypeUseCase(this._repository);

  Future<Either<Failure, List<String>>> call() async {
    return _repository.findLocationType();
  }
}
