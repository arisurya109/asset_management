import '../../../../core/core.dart';
import '../../domain/repositories/reprint_repository.dart';
import '../source/reprint_source.dart';
import 'package:dartz/dartz.dart';

class ReprintRepositoryImpl implements ReprintRepository {
  final ReprintSource _source;

  ReprintRepositoryImpl(this._source);

  @override
  Future<Either<Failure, void>> reprintAssetIdLarge(String params) async {
    try {
      final response = await _source.reprintAssetIdLarge(params);
      return Right(response);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> reprintAssetIdLargeBySerialNumber(
    String params,
  ) {
    // TODO: implement reprintAssetIdLargeBySerialNumber
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> reprintAssetIdNormal(String params) async {
    try {
      final response = await _source.reprintAssetIdNormal(params);
      return Right(response);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> reprintAssetIdNormalBySerialNumber(
    String params,
  ) {
    // TODO: implement reprintAssetIdNormalBySerialNumber
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> reprintLocation(String params) async {
    try {
      final response = await _source.reprintLocation(params);
      return Right(response);
    } on FailedConnectedPrinterException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
