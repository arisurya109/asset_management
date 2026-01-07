import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePreparationStatusUseCase {
  final PreparationRepository _repository;

  UpdatePreparationStatusUseCase(this._repository);

  Future<Either<Failure, Preparation>> call({
    required int id,
    required String params,
    int? totalBox,
    int? temporaryLocationId,
  }) async {
    return _repository.updatePreparationStatus(
      id: id,
      params: params,
      temporaryLocationId: temporaryLocationId,
      totalBox: totalBox,
    );
  }
}
