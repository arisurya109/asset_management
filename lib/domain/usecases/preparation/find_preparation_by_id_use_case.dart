import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindPreparationByIdUseCase {
  final PreparationRepository _repository;

  FindPreparationByIdUseCase(this._repository);

  Future<Either<Failure, Preparation>> call(int params) async {
    return _repository.findPreparationById(params);
  }
}
