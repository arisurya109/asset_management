import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/registration/domain/entities/registration.dart';
import 'package:asset_management/features/registration/domain/repositories/registration_repository.dart';
import 'package:dartz/dartz.dart';

class RegistrationAssetNonConsumableUseCase {
  final RegistrationRepository _repository;

  RegistrationAssetNonConsumableUseCase(this._repository);

  Future<Either<Failure, String>> call(Registration params) async {
    return _repository.registrationAssetNonConsumable(params);
  }
}
