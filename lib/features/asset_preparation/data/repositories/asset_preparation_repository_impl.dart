import '../model/asset_preparation_detail_model.dart';
import '../model/asset_preparation_model.dart';
import '../source/asset_preparation_source.dart';
import '../../domain/entities/asset_preparation.dart';
import '../../domain/entities/asset_preparation_detail.dart';
import '../../domain/repositories/asset_preparation_repository.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';

import 'package:dartz/dartz.dart';

class AssetPreparationRepositoryImpl implements AssetPreparationRepository {
  final AssetPreparationSource _source;

  AssetPreparationRepositoryImpl(this._source);

  @override
  Future<Either<Failure, AssetPreparation>> createPreparation(
    AssetPreparation params,
  ) async {
    try {
      final response = await _source.createPreparation(
        AssetPreparationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAssetPreparationDetail(
    int preparationId,
    String params,
  ) async {
    try {
      final response = await _source.deleteAssetPreparation(
        preparationId,
        params,
      );
      return Right(response);
    } on DeleteException catch (e) {
      return Left(DeleteFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> exportPreparation(int preparationId) async {
    try {
      final response = await _source.exportPreparation(preparationId);
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetPreparationDetail>>>
  findAllAssetPreparationDetail(int preparationId) async {
    try {
      final response = await _source.findAllAssetPreparation(preparationId);
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetPreparation>>> findAllPreparations() async {
    try {
      final response = await _source.findAllPreparations();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetPreparationDetail>> insertAssetPreparationDetail(
    AssetPreparationDetail params,
  ) async {
    try {
      final response = await _source.insertAssetPreparation(
        AssetPreparationDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetPreparation>> updateStatusPreparation(
    AssetPreparation params,
  ) async {
    try {
      final response = await _source.updateStatusPreparation(
        AssetPreparationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetPreparation>> findPreparationById(int id) async {
    try {
      final response = await _source.findPreparationById(id);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
