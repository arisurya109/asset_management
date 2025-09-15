import '../../../../core/error/failure.dart';
import '../entities/asset_preparation_detail.dart';
import '../repositories/asset_preparation_repository.dart';

import 'package:dartz/dartz.dart';

class DeleteAssetPreparationDetailUseCase {
  final AssetPreparationRepository _repository;

  DeleteAssetPreparationDetailUseCase(this._repository);

  Future<Either<Failure, String>> call(AssetPreparationDetail params) async {
    return _repository.deleteAssetPreparationDetail(params);
  }
}
