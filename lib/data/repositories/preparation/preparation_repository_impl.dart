// ignore_for_file: implementation_imports

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/src/platform_file.dart';

import 'package:asset_management/core/error/exception.dart';
import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/data/model/preparation/preparation_detail_model.dart';
import 'package:asset_management/data/model/preparation/preparation_item_model.dart';
import 'package:asset_management/data/model/preparation/preparation_model.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source.dart';
import 'package:asset_management/domain/entities/preparation/preparation.dart';
import 'package:asset_management/domain/entities/preparation/preparation_detail.dart';
import 'package:asset_management/domain/entities/preparation/preparation_item.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';

class PreparationRepositoryImpl implements PreparationRepository {
  final PreparationRemoteDataSource _source;

  PreparationRepositoryImpl(this._source);

  @override
  Future<Either<Failure, Preparation>> createPreparation(
    Preparation params,
  ) async {
    try {
      final response = await _source.createPreparation(
        PreparationModel.fromEntity(params),
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
  Future<Either<Failure, Preparation>> findPreparationById(int params) async {
    try {
      final response = await _source.findPreparationById(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> updatePreparation(
    Preparation params,
  ) async {
    try {
      final response = await _source.updatePreparation(
        PreparationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>> createPreparationDetail(
    PreparationDetail params,
  ) async {
    try {
      final response = await _source.createPreparationDetail(
        PreparationDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationItem>> createPreparationItem(
    PreparationItem params,
  ) async {
    try {
      final response = await _source.createPreparationItem(
        PreparationItemModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationDetail>>>
  findAllPreparationDetailByPreparationId(int params) async {
    try {
      final response = await _source.findAllPreparationDetailByPreparationId(
        params,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationItem>>>
  findAllPreparationItemByPreparationDetailId(
    int params,
    int preparationId,
  ) async {
    try {
      final response = await _source
          .findAllPreparationItemByPreparationDetailId(params, preparationId);
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<PreparationItem>>>
  findAllPreparationItemByPreparationId(int params) async {
    try {
      final response = await _source.findAllPreparationItemByPreparationId(
        params,
      );
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>> findPreparationDetailById(
    int preparationId,
    int params,
  ) async {
    try {
      final response = await _source.findPreparationDetailById(
        params,
        preparationId,
      );
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PreparationDetail>> updatePreparationDetail(
    PreparationDetail params,
  ) async {
    try {
      final response = await _source.updatePreparationDetail(
        PreparationDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> dispatchPreparation(
    Preparation params,
  ) async {
    try {
      final response = await _source.dispatchPreparation(
        PreparationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Preparation>> completedPreparation(
    PlatformFile file,
    Preparation params,
  ) async {
    try {
      final response = await _source.completedPreparation(
        file,
        PreparationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, File>> getDocumentPreparationById(int params) {
    // TODO: implement getDocumentPreparationById
    throw UnimplementedError();
  }
}
