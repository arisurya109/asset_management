import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_registration/domain/entities/asset_registration.dart';
import 'package:asset_management/features/asset_registration/domain/repositories/asset_registration_repository.dart';
import 'package:dartz/dartz.dart';

class FindAllAssetRegistrationUseCase {
  final AssetRegistrationRepository _repository;

  FindAllAssetRegistrationUseCase(this._repository);

  Future<Either<Failure, List<AssetRegistration>>> call() async {
    return _repository.findAllAssetRegistration();
  }
}
