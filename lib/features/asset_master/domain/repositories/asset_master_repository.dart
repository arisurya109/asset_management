import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/asset_master/domain/entities/asset_master.dart';
import 'package:dartz/dartz.dart';

abstract class AssetMasterRepository {
  Future<Either<Failure, List<AssetMaster>>> findAllAssetMaster();
  Future<Either<Failure, AssetMaster>> insertAssetMaster(AssetMaster params);
  Future<Either<Failure, AssetMaster>> updateAssetMaster(AssetMaster params);
}
