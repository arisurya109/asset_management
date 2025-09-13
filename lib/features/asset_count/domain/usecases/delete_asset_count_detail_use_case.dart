import '../../../../core/error/failure.dart';
import '../repositories/asset_count_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteAssetCountDetailUseCase {
  final AssetCountRepository _repository;

  DeleteAssetCountDetailUseCase(this._repository);

  Future<Either<Failure, void>> call(int countId, String assetId) async {
    return _repository.deleteAssetCountDetail(countId, assetId);
  }
}
