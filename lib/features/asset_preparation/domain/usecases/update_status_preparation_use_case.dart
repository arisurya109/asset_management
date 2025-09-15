import '../../../../core/error/failure.dart';
import '../entities/asset_preparation.dart';
import '../repositories/asset_preparation_repository.dart';

import 'package:dartz/dartz.dart';

class UpdateStatusPreparationUseCase {
  final AssetPreparationRepository _repository;

  UpdateStatusPreparationUseCase(this._repository);

  Future<Either<Failure, AssetPreparation>> call(
    AssetPreparation params,
  ) async {
    return _repository.updateStatusPreparation(params);
  }
}
