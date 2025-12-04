import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePreparationUseCase {
  final PreparationRepository _repository;

  CreatePreparationUseCase(this._repository);

  Future<Either<Failure, Preparation>> call({
    required Preparation params,
  }) async {
    return _repository.createPreparation(params: params);
  }
}
