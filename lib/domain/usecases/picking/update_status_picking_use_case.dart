import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/repositories/picking/picking_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateStatusPickingUseCase {
  final PickingRepository _repository;

  UpdateStatusPickingUseCase(this._repository);

  Future<Either<Failure, String>> call({
    required int id,
    required String params,
    int? temporaryLocationId,
  }) async {
    return _repository.updateStatusPicking(
      id: id,
      params: params,
      temporaryLocationId: temporaryLocationId,
    );
  }
}
