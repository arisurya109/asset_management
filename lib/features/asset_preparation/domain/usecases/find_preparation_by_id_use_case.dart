import '../../../../core/core.dart';
import '../../asset_preparation.dart';

import 'package:dartz/dartz.dart';

class FindPreparationByIdUseCase {
  final AssetPreparationRepository _repository;

  FindPreparationByIdUseCase(this._repository);

  Future<Either<Failure, AssetPreparation>> call(int id) async {
    return _repository.findPreparationById(id);
  }
}
