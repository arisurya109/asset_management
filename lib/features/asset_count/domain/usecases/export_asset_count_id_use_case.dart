import '../../../../core/error/failure.dart';
import '../repositories/asset_count_repository.dart';
import 'package:dartz/dartz.dart';

class ExportAssetCountIdUseCase {
  final AssetCountRepository _repository;

  ExportAssetCountIdUseCase(this._repository);

  Future<Either<Failure, String>> call(int params) async {
    return _repository.exportAssetCountId(params);
  }
}
