import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class FindPreparationDetailByIdUseCase {
  final PreparationRepository _repository;

  FindPreparationDetailByIdUseCase(this._repository);

  Future<Either<Failure, PreparationDetail>> call({
    required int preparationId,
    required int params,
  }) async {
    return _repository.findPreparationDetailById(preparationId, params);
  }
}
