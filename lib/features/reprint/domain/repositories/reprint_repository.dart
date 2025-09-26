import 'package:asset_management/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ReprintRepository {
  Future<Either<Failure, void>> reprintAssetIdNormal(String params);
  Future<Either<Failure, void>> reprintAssetIdLarge(String params);
  Future<Either<Failure, void>> reprintAssetIdNormalBySerialNumber(
    String params,
  );
  Future<Either<Failure, void>> reprintAssetIdLargeBySerialNumber(
    String params,
  );
  Future<Either<Failure, void>> reprintLocation(String params);
}
