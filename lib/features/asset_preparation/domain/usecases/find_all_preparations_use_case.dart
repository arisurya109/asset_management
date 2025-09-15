import '../../../../core/error/failure.dart';
import '../entities/asset_preparation.dart';
import '../repositories/asset_preparation_repository.dart';

import 'package:dartz/dartz.dart';

class FindAllPreparationsUseCase {
  final AssetPreparationRepository _repository;

  FindAllPreparationsUseCase(this._repository);

  Future<Either<Failure, List<AssetPreparation>>> call() async {
    return _repository.findAllPreparations();
  }
}
