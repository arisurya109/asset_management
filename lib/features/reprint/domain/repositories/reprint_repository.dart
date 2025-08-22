import 'package:asset_management/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class ReprintRepository {
  Future<Either<Failure, void>> reprintAssetBySerialNumber(String serialNumber);
  Future<Either<Failure, void>> reprintAssetByAssetId(String assetId);
  Future<Either<Failure, void>> reprintLocation(String location);
}
