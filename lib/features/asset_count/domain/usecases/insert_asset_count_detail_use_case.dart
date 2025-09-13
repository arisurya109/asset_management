import '../../../../core/error/failure.dart';
import '../entities/asset_count_detail.dart';
import '../repositories/asset_count_repository.dart';
import 'package:dartz/dartz.dart';

class InsertAssetCountDetailUseCase {
  final AssetCountRepository _repository;

  InsertAssetCountDetailUseCase(this._repository);

  Future<Either<Failure, AssetCountDetail>> call(
    AssetCountDetail params,
  ) async {
    return _repository.insertAssetCountDetail(params);
  }
}
