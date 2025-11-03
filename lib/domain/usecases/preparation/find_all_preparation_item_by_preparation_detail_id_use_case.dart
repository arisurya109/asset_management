import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation_item.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllPreparationItemByPreparationDetailIdUseCase {
  final PreparationRepository _repository;

  FindAllPreparationItemByPreparationDetailIdUseCase(this._repository);

  Future<Either<Failure, List<PreparationItem>>> call(
    int params,
    int preparationId,
  ) async {
    return _repository.findAllPreparationItemByPreparationDetailId(
      params,
      preparationId,
    );
  }
}
