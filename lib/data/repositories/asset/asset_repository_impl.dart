import 'package:asset_management/core/core.dart';
import 'package:asset_management/data/model/asset/asset_model.dart';
import 'package:asset_management/data/source/asset/asset_remote_data_source.dart';
import 'package:asset_management/domain/entities/asset/asset_detail.dart';
import 'package:asset_management/domain/entities/asset/asset_entity.dart';
import 'package:asset_management/domain/repositories/asset/asset_repository.dart';
import 'package:dartz/dartz.dart';

class AssetRepositoryImpl implements AssetRepository {
  final AssetRemoteDataSource _source;

  AssetRepositoryImpl(this._source);

  @override
  Future<Either<Failure, AssetEntity>> createAsset(AssetEntity params) async {
    try {
      final response = await _source.createAsset(
        AssetsModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

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
  Future<Either<Failure, List<AssetDetail>>> findAssetDetailById(
    int params,
  ) async {
    try {
      final response = await _source.findAssetDetailById(params);
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetEntity>> createAssetTransfer({
    required int assetId,
    required String movementType,
    required int fromLocationId,
    required int toLocationId,
    int quantity = 1,
    String? notes,
  }) async {
    try {
      final response = await _source.createAssetTransfer(
        assetId: assetId,
        fromLocationId: fromLocationId,
        movementType: movementType,
        toLocationId: toLocationId,
        notes: notes,
        quantity: quantity,
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetEntity>> findAssetByAssetCodeAndLocation({
    required String assetCode,
    required String location,
  }) async {
    try {
      final response = await _source.findAssetByAssetCodeAndLocation(
        assetCode: assetCode,
        location: location,
      );
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
}
