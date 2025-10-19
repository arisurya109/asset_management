import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/assets/domain/entities/asset_detail.dart';
import 'package:asset_management/features/assets/domain/entities/asset_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AssetsRepository {
  Future<Either<Failure, List<AssetsEntity>>> findAllAsset();
  Future<Either<Failure, List<AssetDetail>>> findAssetDetailById(int params);
}
