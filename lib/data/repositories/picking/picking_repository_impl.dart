import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/data/source/picking/picking_remote_data_source.dart';
import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_response.dart';
import 'package:asset_management/domain/entities/picking/picking_request.dart';
import 'package:asset_management/domain/repositories/picking/picking_repository.dart';
import 'package:dartz/dartz.dart';

class PickingRepositoryImpl implements PickingRepository {
  final PickingRemoteDataSource _source;

  PickingRepositoryImpl(this._source);

  @override
  Future<Either<Failure, String>> addPickAssetPicking({
    required PickingRequest params,
  }) async {
    try {
      final response = await _source.addPickAssetPicking(params: params);
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Picking>>> findAllPickingTask() async {
    try {
      final response = await _source.findAllPickingTask();
      return Right(response.map((e) => e.toEntity()).toList());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PickingDetailResponse>> pickingDetailById({
    required int params,
  }) async {
    try {
      final response = await _source.pickingDetailById(params: params);
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateStatusPicking({
    required PickingRequest params,
  }) async {
    try {
      final response = await _source.updateStatusPicking(params: params);
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
