import '../../../../core/error/failure.dart';
import '../repositories/asset_preparation_repository.dart';

import 'package:dartz/dartz.dart';

class ExportPreparationUseCase {
  final AssetPreparationRepository _repository;

  ExportPreparationUseCase(this._repository);

  Future<Either<Failure, String>> call(int preparationId) async {
    return _repository.exportPreparation(preparationId);
  }
}
