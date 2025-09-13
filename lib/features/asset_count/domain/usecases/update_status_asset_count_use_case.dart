import '../../../../core/error/failure.dart';
import '../../../../core/utils/enum.dart';
import '../entities/asset_count.dart';
import '../repositories/asset_count_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStatusAssetCountUseCase {
  final AssetCountRepository _repository;

  UpdateStatusAssetCountUseCase(this._repository);

  Future<Either<Failure, AssetCount>> call(
    int countId,
    StatusCount params,
  ) async {
    return _repository.updateStatusAssetCount(countId, params);
  }
}
