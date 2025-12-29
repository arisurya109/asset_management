import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/asset/asset_detail.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AssetRepository {
  Future<Either<Failure, List<AssetEntity>>> findAllAsset();
  Future<Either<Failure, AssetEntity>> createAsset(AssetEntity params);
  Future<Either<Failure, List<AssetDetail>>> findAssetDetailById(int params);
  Future<Either<Failure, AssetEntity>> createAssetTransfer({
    required int assetId,
    required String movementType,
    required int fromLocationId,
    required int toLocationId,
    int quantity = 1,
    String? notes,
  });
  Future<Either<Failure, AssetEntity>> findAssetByAssetCodeAndLocation({
    required String assetCode,
    required String location,
  });
  Future<Either<Failure, List<AssetEntity>>> findAssetByQuery({
    required String params,
  });
}
