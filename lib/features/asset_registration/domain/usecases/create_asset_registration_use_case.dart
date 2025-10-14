import '../../../../core/core.dart';
import '../entities/asset_registration.dart';
import '../repositories/asset_registration_repository.dart';
import 'package:dartz/dartz.dart';

class CreateAssetRegistrationUseCase {
  final AssetRegistrationRepository _repository;

  CreateAssetRegistrationUseCase(this._repository);

  Future<Either<Failure, AssetRegistration>> call(
    AssetRegistration params,
  ) async {
    return _repository.createAssetRegistration(params);
  }
}
