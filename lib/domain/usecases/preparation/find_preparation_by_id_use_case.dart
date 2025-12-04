import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindPreparationByIdUseCase {
  final PreparationRepository _repository;

  FindPreparationByIdUseCase(this._repository);

  Future<Either<Failure, Preparation>> call({required int id}) async {
    return _repository.findPreparationById(id: id);
  }
}
