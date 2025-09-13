import '../../../../core/error/failure.dart';
import '../entities/asset_count.dart';
import '../repositories/asset_count_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetCountUseCase {
  final AssetCountRepository _repository;

  FindAllAssetCountUseCase(this._repository);

  Future<Either<Failure, List<AssetCount>>> call() async {
    return _repository.findAllAssetCount();
  }
}
