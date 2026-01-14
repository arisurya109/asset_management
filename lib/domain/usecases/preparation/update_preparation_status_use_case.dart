import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_request.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePreparationStatusUseCase {
  final PreparationRepository _repository;

  UpdatePreparationStatusUseCase(this._repository);

  Future<Either<Failure, Preparation>> call({
    required PreparationRequest params,
  }) async {
    return _repository.updatePreparationStatus(params: params);
  }
}
