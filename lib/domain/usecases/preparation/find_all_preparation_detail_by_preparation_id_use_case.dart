import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationDetailByPreparationIdUseCase {
  final PreparationRepository _repository;

  FindAllPreparationDetailByPreparationIdUseCase(this._repository);

  Future<Either<Failure, List<PreparationDetail>>> call(int params) async {
    return _repository.findAllPreparationDetailByPreparationId(params);
  }
}
