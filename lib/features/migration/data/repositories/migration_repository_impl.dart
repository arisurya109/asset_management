import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/migration/data/source/migration_remote_data_source.dart';
import 'package:asset_management/features/migration/domain/entities/migration.dart';
import 'package:asset_management/features/migration/domain/repositories/migration_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../model/migration_model.dart';

class MigrationRepositoryImpl implements MigrationRepository {
  final MigrationRemoteDataSource _source;

  MigrationRepositoryImpl(this._source);

  @override
  Future<Either<Failure, String>> migrationAssetOld(Migration params) async {
    try {
      final response = await _source.migrationAssetIdOld(
        MigrationModel.fromEntity(params),
      );
      return Right(response);
    } on CreateException catch (e) {
      return Left(CreateFailure(e.message));
    }
  }
}
