import '../../../../core/core.dart';
import '../entities/asset_registration.dart';

import 'package:dartz/dartz.dart';

abstract class AssetRegistrationRepository {
  Future<Either<Failure, List<AssetRegistration>>> findAllAssetRegistration();
  Future<Either<Failure, AssetRegistration>> createAssetRegistration(
    AssetRegistration params,
  );
  Future<Either<Failure, AssetRegistration>> createAssetRegistrationConsumable(
    AssetRegistration params,
  );
  Future<Either<Failure, AssetRegistration>> migrationAsset(
    AssetRegistration params,
  );
}
