// ignore_for_file: implementation_imports

import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/data/model/preparation/preparation_model.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/src/platform_file.dart';

class PreparationRepositoryImpl implements PreparationRepository {
  final PreparationRemoteDataSource _source;

  PreparationRepositoryImpl(this._source);

  @override
  Future<Either<Failure, Preparation>> completedPreparation({
    required int id,
    required PlatformFile file,
  }) async {
    try {
      final response = await _source.completedPreparation(id: id, file: file);
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> createPreparation({
    required Preparation params,
  }) async {
    try {
      final response = await _source.createPreparation(
        params: PreparationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Preparation>>> findAllPreparation() async {
    try {
      final response = await _source.findAllPreparation();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> findPreparationById({
    required int id,
  }) async {
    try {
      final response = await _source.findPreparationById(id: id);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updateStatusPreparation({
    required int id,
    required String params,
    int? locationId,
    int? totalBox,
  }) async {
    try {
      final response = await _source.updateStatusPreparation(
        id: id,
        params: params,
        locationId: locationId,
        totalBox: totalBox,
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
