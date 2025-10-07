import '../../../../core/core.dart';
import '../entities/asset_registration.dart';

import 'package:dartz/dartz.dart';

abstract class AssetRegistrationRepository {
  Future<Either<Failure, String>> create(AssetRegistration params);
  Future<Either<Failure, String>> reRegistration(AssetRegistration params);
  Future<Either<Failure, List<AssetRegistration>>> findAllAsset();
}
