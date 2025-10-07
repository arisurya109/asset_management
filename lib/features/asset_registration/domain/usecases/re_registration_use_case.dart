import '../../../../core/core.dart';
import '../entities/asset_registration.dart';
import '../repositories/asset_registration_repository.dart';

import 'package:dartz/dartz.dart';

class ReRegistrationUseCase {
  final AssetRegistrationRepository _repository;

  ReRegistrationUseCase(this._repository);

  Future<Either<Failure, String>> call(AssetRegistration params) async {
    return _repository.reRegistration(params);
  }
}
