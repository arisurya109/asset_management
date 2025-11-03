import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePreparationDetailUseCase {
  final PreparationRepository _repository;

  UpdatePreparationDetailUseCase(this._repository);

  Future<Either<Failure, PreparationDetail>> call(
    PreparationDetail params,
  ) async {
    return _repository.updatePreparationDetail(params);
  }
}
