import 'package:asset_management/features/assets/data/source/asset_remote_data_source.dart';
import 'package:asset_management/features/assets/domain/entities/asset_detail.dart';
import 'package:asset_management/features/assets/domain/entities/asset_entity.dart';
import 'package:asset_management/features/assets/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/core.dart';

class AssetsRepositoryImpl implements AssetsRepository {
  final AssetsRemoteDataSource _source;

  AssetsRepositoryImpl(this._source);

  @override
  Future<Either<Failure, List<AssetsEntity>>> findAllAsset() async {
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
}
