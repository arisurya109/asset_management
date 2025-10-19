import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/assets/assets_export.dart';
import 'package:asset_management/features/assets/domain/entities/asset_detail.dart';
import 'package:dartz/dartz.dart';

class FindAssetDetailByIdUseCase {
  final AssetsRepository _repository;

  FindAssetDetailByIdUseCase(this._repository);

  Future<Either<Failure, List<AssetDetail>>> call(int params) async {
    return _repository.findAssetDetailById(params);
  }
}
