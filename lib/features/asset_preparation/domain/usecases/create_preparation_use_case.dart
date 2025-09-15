import '../../../../core/error/failure.dart';
import '../entities/asset_preparation.dart';
import '../repositories/asset_preparation_repository.dart';

import 'package:dartz/dartz.dart';

class CreatePreparationUseCase {
  final AssetPreparationRepository _repository;

  CreatePreparationUseCase(this._repository);

  Future<Either<Failure, AssetPreparation>> call(
    AssetPreparation params,
  ) async {
    return _repository.createPreparation(params);
  }
}
