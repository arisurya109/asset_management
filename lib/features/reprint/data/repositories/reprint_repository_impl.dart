import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/reprint/data/source/reprint_source.dart';
import 'package:asset_management/features/reprint/domain/repositories/reprint_repository.dart';
import 'package:dartz/dartz.dart';

class ReprintRepositoryImpl implements ReprintRepository {
  final ReprintSource _source;

  ReprintRepositoryImpl(this._source);

  @override
  Future<Either<Failure, void>> reprintAssetByAssetId(String assetId) async {
    try {
      final result = await _source.reprintByAssetId(assetId);
      return Right(result);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> reprintAssetBySerialNumber(
    String serialNumber,
  ) {
    // TODO: implement reprintAssetBySerialNumber
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> reprintLocation(String location) async {
    try {
      final result = await _source.reprintLocation(location);
      return Right(result);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
