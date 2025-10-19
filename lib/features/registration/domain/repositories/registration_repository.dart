import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/registration/domain/entities/registration.dart';
import 'package:dartz/dartz.dart';

abstract class RegistrationRepository {
  Future<Either<Failure, String>> registrationAssetNonConsumable(
    Registration params,
  );
  Future<Either<Failure, String>> registrationAssetConsumable(
    Registration params,
  );
}
