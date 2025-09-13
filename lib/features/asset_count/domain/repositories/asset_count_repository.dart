import '../../../../core/error/failure.dart';
import '../../../../core/utils/enum.dart';
import '../entities/asset_count.dart';
import '../entities/asset_count_detail.dart';
import 'package:dartz/dartz.dart';

abstract class AssetCountRepository {
  // Asset Count
  Future<Either<Failure, List<AssetCount>>> findAllAssetCount();
  Future<Either<Failure, AssetCount>> createAssetCount(AssetCount params);
  Future<Either<Failure, AssetCount>> updateStatusAssetCount(
    int countId,
    StatusCount params,
  );
  Future<Either<Failure, String>> exportAssetCountId(int params);

  // Asset Count Detail
  Future<Either<Failure, List<AssetCountDetail>>>
  findAllAssetCountDetailByIdCount(int params);
  Future<Either<Failure, AssetCountDetail>> insertAssetCountDetail(
    AssetCountDetail params,
  );
  Future<Either<Failure, void>> deleteAssetCountDetail(
    int countId,
    String assetId,
  );
}
