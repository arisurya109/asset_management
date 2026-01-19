import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_response.dart';
import 'package:asset_management/domain/repositories/picking/picking_repository.dart';
import 'package:dartz/dartz.dart';

class PickingDetailByIdUseCase {
  final PickingRepository _repository;

  PickingDetailByIdUseCase(this._repository);

  Future<Either<Failure, PickingDetailResponse>> call({
    required int params,
  }) async {
    return _repository.pickingDetailById(params: params);
  }
}
