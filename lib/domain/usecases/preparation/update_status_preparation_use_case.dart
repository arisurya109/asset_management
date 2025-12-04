import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStatusPreparationUseCase {
  final PreparationRepository _repository;

  UpdateStatusPreparationUseCase(this._repository);

  Future<Either<Failure, Preparation>> call({
    required int id,
    required String params,
    int? locationId,
    int? totalBox,
  }) async {
    return _repository.updateStatusPreparation(
      id: id,
      params: params,
      locationId: locationId,
      totalBox: totalBox,
    );
  }
}
