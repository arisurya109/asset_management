import '../../../../core/error/failure.dart';
import '../entities/asset_preparation_detail.dart';
import '../repositories/asset_preparation_repository.dart';

import 'package:dartz/dartz.dart';

class FindAllAssetPreparationDetailUseCase {
  final AssetPreparationRepository _repository;

  FindAllAssetPreparationDetailUseCase(this._repository);

  Future<Either<Failure, List<AssetPreparationDetail>>> call(
    int preparationId,
  ) async {
    return _repository.findAllAssetPreparationDetail(preparationId);
  }
}
