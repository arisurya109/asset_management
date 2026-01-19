import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/picking/picking_request.dart';
import 'package:asset_management/domain/repositories/picking/picking_repository.dart';
import 'package:dartz/dartz.dart';

class AddPickAssetPickingUseCase {
  final PickingRepository _repository;

  AddPickAssetPickingUseCase(this._repository);

  Future<Either<Failure, String>> call({required PickingRequest params}) async {
    return _repository.addPickAssetPicking(params: params);
  }
}
