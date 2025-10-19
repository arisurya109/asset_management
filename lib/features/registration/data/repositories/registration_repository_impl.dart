import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/registration/data/source/registration_remote_data_source.dart';
import 'package:dartz/dartz.dart';

import '../../domain/entities/registration.dart';
import '../../domain/repositories/registration_repository.dart';
import '../model/registration_model.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  final RegistrationRemoteDataSource _source;

  RegistrationRepositoryImpl(this._source);

  @override
  Future<Either<Failure, String>> registrationAssetNonConsumable(
    Registration params,
  ) async {
    try {
      final response = await _source.registrationAssetNonConsumable(
        RegistrationModel.fromEntity(params),
      );
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> registrationAssetConsumable(
    Registration params,
  ) async {
    try {
      final response = await _source.registrationAssetConsumable(
        RegistrationModel.fromEntity(params),
      );
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
