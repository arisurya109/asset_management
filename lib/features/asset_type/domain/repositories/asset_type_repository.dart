import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/asset_type/domain/entities/asset_type.dart';
import 'package:dartz/dartz.dart';

abstract class AssetTypeRepository {
  Future<Either<Failure, List<AssetType>>> findAllAssetType();
  Future<Either<Failure, AssetType>> createAssetType(AssetType params);
}
