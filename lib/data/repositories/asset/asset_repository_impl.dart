import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/asset/asset_model.dart';
import 'package:asset_management/data/source/asset/asset_remote_data_source.dart';
import 'package:asset_management/domain/entities/asset/asset_detail_response.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/entities/asset/asset_entity_pagination.dart';
import 'package:asset_management/domain/repositories/asset/asset_repository.dart';
import 'package:dartz/dartz.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetRemoteDataSource _source;

  AssetRepositoryImpl(this._source);

  @override
  Future<Either<Failure, List<AssetEntity>>> findAllAsset() async {
    try {
      final response = await _source.findAllAsset();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetDetailResponse>> findAssetDetailById(
    int params,
  ) async {
    try {
      final response = await _source.findAssetDetailById(params);
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetEntity>>> findAssetByQuery({
    required String params,
  }) async {
    try {
      final response = await _source.findAssetByQuery(params: params);
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetEntity>> migrationAsset(
    AssetEntity params,
  ) async {
    try {
      final response = await _source.migrationAsset(
        AssetsModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetEntity>> registrationAsset(
    AssetEntity params,
  ) async {
    try {
      final response = await _source.registrationAsset(
        AssetsModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetEntityPagination>> findAssetByPagination({
    required int page,
    required int limit,
    String? query,
  }) async {
    try {
      final response = await _source.findAssetByPagination(
        limit: limit,
        page: page,
        query: query,
      );
      return Right(response.toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
