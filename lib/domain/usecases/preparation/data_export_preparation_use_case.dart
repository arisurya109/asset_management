import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/preparation/preparation_document.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class DataExportPreparationUseCase {
  final PreparationRepository _repository;

  DataExportPreparationUseCase(this._repository);

  Future<Either<Failure, PreparationDocument>> call({
    required int preparationId,
  }) async {
    return _repository.dataExportPreparation(preparationId: preparationId);
  }
}
