import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class GetPreparationTypesUseCase {
  final PreparationRepository _repository;

  GetPreparationTypesUseCase(this._repository);

  Future<Either<Failure, List<String>>> call() async {
    return _repository.getPreparationTypes();
  }
}
