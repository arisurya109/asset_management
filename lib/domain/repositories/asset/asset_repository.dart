import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/domain/entities/asset/asset_detail.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/asset/asset_entity_pagination.dart';
import 'package:dartz/dartz.dart';

abstract class AssetRepository {
  Future<Either<Failure, List<AssetEntity>>> findAllAsset();
  Future<Either<Failure, AssetEntity>> registrationAsset(AssetEntity params);
  Future<Either<Failure, AssetEntity>> migrationAsset(AssetEntity params);
  Future<Either<Failure, List<AssetDetail>>> findAssetDetailById(int params);
  Future<Either<Failure, List<AssetEntity>>> findAssetByQuery({
    required String params,
  });
  Future<Either<Failure, AssetEntityPagination>> findAssetByPagination({
    required int page,
    required int limit,
    String? query,
  });
}
