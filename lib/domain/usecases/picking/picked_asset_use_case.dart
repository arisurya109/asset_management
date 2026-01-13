import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/picking/picking_detail.dart';
import 'package:asset_management/domain/repositories/picking/picking_repository.dart';
import 'package:dartz/dartz.dart';

class PickedAssetUseCase {
  final PickingRepository _repository;

  PickedAssetUseCase(this._repository);

  Future<Either<Failure, String>> call({required PickingDetail params}) async {
    return _repository.pickedAsset(params: params);
  }
}
