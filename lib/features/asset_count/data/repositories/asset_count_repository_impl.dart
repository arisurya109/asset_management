import '../model/asset_count_detail_model.dart';
import '../model/asset_count_model.dart';
import '../source/asset_count_source.dart';
import '../../domain/entities/asset_count.dart';
import '../../domain/entities/asset_count_detail.dart';
import '../../domain/repositories/asset_count_repository.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/enum.dart';
import 'package:dartz/dartz.dart';

class AssetCountRepositoryImpl implements AssetCountRepository {
  final AssetCountSource _source;

  AssetCountRepositoryImpl(this._source);

  @override
  Future<Either<Failure, AssetCount>> createAssetCount(
    AssetCount params,
  ) async {
    try {
      final response = await _source.createAssetCount(
        AssetCountModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAssetCountDetail(
    int countId,
    String assetId,
  ) async {
    try {
      final response = await _source.deleteAssetCountDetail(countId, assetId);
      return Right(response);
    } on DeleteException catch (e) {
      return Left(DeleteFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> exportAssetCountId(int params) async {
    try {
      final response = await _source.exportAssetCountId(params);
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetCount>>> findAllAssetCount() async {
    try {
      final response = await _source.findAllAssetCount();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetCountDetail>>>
  findAllAssetCountDetailByIdCount(int params) async {
    try {
      final response = await _source.findAllAssetCountDetailByIdCount(params);
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetCountDetail>> insertAssetCountDetail(
    AssetCountDetail params,
  ) async {
    try {
      final response = await _source.insertAssetCountDetail(
        AssetCountDetailModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetCount>> updateStatusAssetCount(
    int countId,
    StatusCount params,
  ) async {
    try {
      final response = await _source.updateStatusAssetCount(countId, params);
      return Right(response.toEntity());
    } on UpdateException catch (e) {
      return Left(UpdateFailure(e.message));
    }
  }
}
