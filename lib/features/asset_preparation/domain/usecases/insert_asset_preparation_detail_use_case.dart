import '../../../../core/error/failure.dart';
import '../entities/asset_preparation_detail.dart';
import '../repositories/asset_preparation_repository.dart';

import 'package:dartz/dartz.dart';

class InsertAssetPreparationDetailUseCase {
  final AssetPreparationRepository _repository;

  InsertAssetPreparationDetailUseCase(this._repository);

  Future<Either<Failure, AssetPreparationDetail>> call(
    AssetPreparationDetail params,
  ) async {
    return _repository.insertAssetPreparationDetail(params);
  }
}
