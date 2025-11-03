import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class CreatePreparationDetailUseCase {
  final PreparationRepository _repository;

  CreatePreparationDetailUseCase(this._repository);

  Future<Either<Failure, PreparationDetail>> call(
    PreparationDetail params,
  ) async {
    return _repository.createPreparationDetail(params);
  }
}
