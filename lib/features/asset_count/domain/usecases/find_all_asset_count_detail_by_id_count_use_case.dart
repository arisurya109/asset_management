import '../../../../core/error/failure.dart';
import '../entities/asset_count_detail.dart';
import '../repositories/asset_count_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetCountDetailByIdCountUseCase {
  final AssetCountRepository _repository;

  FindAllAssetCountDetailByIdCountUseCase(this._repository);

  Future<Either<Failure, List<AssetCountDetail>>> call(int params) async {
    return _repository.findAllAssetCountDetailByIdCount(params);
  }
}
