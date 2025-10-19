import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/asset_brand/domain/entities/asset_brand.dart';
import 'package:dartz/dartz.dart';

abstract class AssetBrandRepository {
  Future<Either<Failure, AssetBrand>> createAssetBrand(AssetBrand params);
  Future<Either<Failure, List<AssetBrand>>> findAllAssetBrand();
}
