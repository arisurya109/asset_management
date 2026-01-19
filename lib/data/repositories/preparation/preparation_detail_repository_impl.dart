import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/data/source/preparation/preparation_detail_remote_data_source.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail_request.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail_response.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_detail_repository.dart';
import 'package:dartz/dartz.dart';

class PreparationDetailRepositoryImpl implements PreparationDetailRepository {
  final PreparationDetailRemoteDataSource _source;

  PreparationDetailRepositoryImpl(this._source);

  @override
  Future<Either<Failure, String>> addPreparationDetail({
    required PreparationDetailRequest params,
  }) async {
    try {
      final response = await _source.addPreparationDetail(params: params);
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetailResponse>> getPreparationDetails({
    required int preparationId,
  }) async {
    try {
      final response = await _source.getPreparationDetails(
        preparationId: preparationId,
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deletePreparationDetail({
    required int id,
    required int preparationId,
  }) async {
    try {
      final response = await _source.deletePreparationDetail(
        id: id,
        preparationId: preparationId,
      );
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
