import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/data/model/picking/picking_detail_model.dart';
import 'package:asset_management/data/source/picking/picking_remote_data_source.dart';
import 'package:asset_management/domain/entities/picking/picking.dart';
import 'package:asset_management/domain/entities/picking/picking_detail.dart';
import 'package:asset_management/domain/entities/picking/picking_detail_response.dart';
import 'package:asset_management/domain/repositories/picking/picking_repository.dart';
import 'package:dartz/dartz.dart';

class PickingRepositoryImpl implements PickingRepository {
  final PickingRemoteDataSource _source;

  PickingRepositoryImpl(this._source);

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
  Future<Either<Failure, PickingDetailResponse>> findPickingDetail({
    required int id,
  }) async {
    try {
      final response = await _source.findPickingDetail(id: id);
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> pickedAsset({
    required PickingDetail params,
  }) async {
    try {
      final response = await _source.pickedAsset(
        params: PickingDetailModel.fromEntity(params),
      );
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> updateStatusPicking({
    required int id,
    required String params,
    int? temporaryLocationId,
    int? totalBox,
  }) async {
    try {
      final response = await _source.updateStatusPicking(
        id: id,
        params: params,
        temporaryLocationId: temporaryLocationId,
        totalBox: totalBox,
      );
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
