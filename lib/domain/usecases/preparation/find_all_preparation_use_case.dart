import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationUseCase {
  final PreparationRepository _repository;

  FindAllPreparationUseCase(this._repository);

  Future<Either<Failure, List<Preparation>>> call() async {
    return _repository.findAllPreparation();
  }
}
