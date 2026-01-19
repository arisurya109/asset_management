// ignore_for_file: implementation_imports

import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_document.dart';
import 'package:asset_management/domain/entities/preparation/preparation_pagination.dart';
import 'package:asset_management/domain/entities/preparation/preparation_request.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';

class PreparationRepositoryImpl implements PreparationRepository {
  final PreparationRemoteDataSource _source;

  PreparationRepositoryImpl(this._source);

  @override
  Future<Either<Failure, Preparation>> createPreparation({
    required PreparationRequest params,
  }) async {
    try {
      final response = await _source.createPreparation(params: params);
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationPagination>> findPreparationByPagination({
    required int page,
    required int limit,
    String? query,
  }) async {
    try {
      final response = await _source.findPreparationByPagination(
        limit: limit,
        page: page,
        query: query,
      );
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getPreparationTypes() async {
    try {
      final response = await _source.getPreparationTypes();
      return Right(response);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updatePreparationStatus({
    required PreparationRequest params,
  }) async {
    try {
      final response = await _source.updatePreparationStatus(params: params);
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDocument>> dataExportPreparation({
    required int preparationId,
  }) async {
    try {
      final response = await _source.dataExportPreparation(
        preparationId: preparationId,
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
