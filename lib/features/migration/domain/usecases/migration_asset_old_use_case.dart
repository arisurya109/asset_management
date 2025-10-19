import 'package:asset_management/core/error/failure.dart';
import 'package:asset_management/features/migration/domain/entities/migration.dart';
import 'package:asset_management/features/migration/domain/repositories/migration_repository.dart';
import 'package:dartz/dartz.dart';

class MigrationAssetOldUseCase {
  final MigrationRepository _repository;

  MigrationAssetOldUseCase(this._repository);

  Future<Either<Failure, String>> call(Migration params) async {
    return _repository.migrationAssetOld(params);
  }
}
