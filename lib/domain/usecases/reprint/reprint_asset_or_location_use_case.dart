import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/repositories/reprint/reprint_repository.dart';
import 'package:dartz/dartz.dart';

class ReprintAssetOrLocationUseCase {
  final ReprintRepository _repository;

  ReprintAssetOrLocationUseCase(this._repository);

  Future<Either<Failure, Map<String, dynamic>>> call({
    required String params,
    required String type,
  }) async {
    return _repository.reprintAssetOrLocation(params: params, type: type);
  }
}
