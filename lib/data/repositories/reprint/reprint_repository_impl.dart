import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/data/source/reprint/reprint_remote_data_source.dart';
import 'package:asset_management/domain/repositories/reprint/reprint_repository.dart';
import 'package:dartz/dartz.dart';

class ReprintRepositoryImpl implements ReprintRepository {
  final ReprintRemoteDataSource _source;

  ReprintRepositoryImpl(this._source);

  @override
  Future<Either<Failure, Map<String, dynamic>>> reprintAssetOrLocation({
    required String params,
    required String type,
  }) async {
    try {
      final response = await _source.reprintAssetOrLocation(
        type: type,
        params: params,
      );
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
