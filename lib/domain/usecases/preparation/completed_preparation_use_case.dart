import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

class CompletedPreparationUseCase {
  final PreparationRepository _repository;

  CompletedPreparationUseCase(this._repository);

  Future<Either<Failure, Preparation>> call(
    PlatformFile file,
    Preparation params,
  ) async {
    return _repository.completedPreparation(file, params);
  }
}
