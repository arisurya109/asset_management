import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/asset_registration/data/model/asset_registration_model.dart';
import 'package:asset_management/features/asset_registration/data/source/asset_registration_source.dart';
import 'package:asset_management/features/asset_registration/domain/entities/asset_registration.dart';
import 'package:asset_management/features/asset_registration/domain/repositories/asset_registration_repository.dart';
import 'package:dartz/dartz.dart';

class AssetRegistrationRepositoryImpl implements AssetRegistrationRepository {
  final AssetRegistrationSource _source;

  AssetRegistrationRepositoryImpl(this._source);

  @override
  Future<Either<Failure, AssetRegistration>> createAssetRegistration(
    AssetRegistration params,
  ) async {
    try {
      final response = await _source.createAssetRegistration(
        AssetRegistrationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetRegistration>> createAssetRegistrationConsumable(
    AssetRegistration params,
  ) async {
    try {
      final response = await _source.createAssetRegistrationConsumable(
        AssetRegistrationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AssetRegistration>>>
  findAllAssetRegistration() async {
    try {
      final response = await _source.findAllAssetRegistration();
      return Right(response.map((e) => e.toEntity()).toList());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, AssetRegistration>> migrationAsset(
    AssetRegistration params,
  ) async {
    try {
      final response = await _source.migrationAsset(
        AssetRegistrationModel.fromEntity(params),
      );
      return Right(response.toEntity());
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
