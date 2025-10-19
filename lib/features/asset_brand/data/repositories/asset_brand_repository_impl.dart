import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/asset_brand/data/model/asset_brand_model.dart';
import 'package:asset_management/features/asset_brand/data/source/asset_brand_remote_data_source.dart';
import 'package:asset_management/features/asset_brand/domain/entities/asset_brand.dart';
import 'package:asset_management/features/asset_brand/domain/repositories/asset_brand_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';

class AssetBrandRepositoryImpl implements AssetBrandRepository {
  final AssetBrandRemoteDataSource _source;

  AssetBrandRepositoryImpl(this._source);

  @override
  Future<Either<Failure, AssetBrand>> createAssetBrand(
    AssetBrand params,
  ) async {
    try {
      final response = await _source.createAssetBrand(
        AssetBrandModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetBrand>>> findAllAssetBrand() async {
    try {
      final response = await _source.findAllAssetBrand();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }
}
