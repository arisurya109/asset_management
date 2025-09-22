import '../../../../core/error/failure.dart';
import '../entities/asset_preparation.dart';
import '../entities/asset_preparation_detail.dart';

import 'package:dartz/dartz.dart';

abstract class AssetPreparationRepository {
  // Preparation
  Future<Either<Failure, List<AssetPreparation>>> findAllPreparations();
  Future<Either<Failure, AssetPreparation>> findPreparationById(int id);
  Future<Either<Failure, AssetPreparation>> createPreparation(
    AssetPreparation params,
  );
  Future<Either<Failure, AssetPreparation>> updateStatusPreparation(
    AssetPreparation params,
  );
  Future<Either<Failure, String>> exportPreparation(int preparationId);

  // PreparationDetail
  Future<Either<Failure, List<AssetPreparationDetail>>>
  findAllAssetPreparationDetail(int preparationId);
  Future<Either<Failure, AssetPreparationDetail>> insertAssetPreparationDetail(
    AssetPreparationDetail params,
  );
  Future<Either<Failure, String>> deleteAssetPreparationDetail(
    int preparationId,
    String params,
  );
}
