import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePreparationUseCase {
  final PreparationRepository _repository;

  UpdatePreparationUseCase(this._repository);

  Future<Either<Failure, Preparation>> call(Preparation params) async {
    return _repository.updatePreparation(params);
  }
}
