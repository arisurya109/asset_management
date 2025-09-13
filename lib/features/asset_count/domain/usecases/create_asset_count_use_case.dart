import '../../../../core/error/failure.dart';
import '../entities/asset_count.dart';
import '../repositories/asset_count_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssetCountUseCase {
  final AssetCountRepository _repository;

  CreateAssetCountUseCase(this._repository);

  Future<Either<Failure, AssetCount>> call(AssetCount params) async {
    return _repository.createAssetCount(params);
  }
}
