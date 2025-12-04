import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/data/model/preparation_detail/preparation_detail_model.dart';
import 'package:asset_management/data/source/preparation_detail/preparation_detail_remote_data_source.dart';
import 'package:asset_management/domain/entities/preparation_detail/preparation_detail.dart';
import 'package:asset_management/domain/repositories/preparation_detail/preparation_detail_repository.dart';
import 'package:dartz/dartz.dart';

class PreparationDetailRepositoryImpl implements PreparationDetailRepository {
  final PreparationDetailRemoteDataSource _source;

  PreparationDetailRepositoryImpl(this._source);

  @override
  Future<Either<Failure, PreparationDetail>> createPreparationDetail({
    required PreparationDetail params,
  }) async {
    try {
      final response = await _source.createPreparationDetail(
        params: PreparationDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationDetail>>>
  findAllPreparationDetailByPreparationId({required int id}) async {
    try {
      final response = await _source.findAllPreparationDetailByPreparationId(
        id: id,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>> findPreparationDetailById({
    required int id,
  }) async {
    try {
      final response = await _source.findPreparationDetailById(id: id);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>> updatePreparationDetail({
    required PreparationDetail params,
  }) async {
    try {
      final response = await _source.updatePreparationDetail(
        params: PreparationDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>> updateStatusPreparationDetail({
    required int id,
    required String params,
  }) async {
    try {
      final response = await _source.updateStatusPreparationDetail(
        id: id,
        params: params,
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
