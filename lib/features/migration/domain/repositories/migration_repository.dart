import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/migration/domain/entities/migration.dart';
import 'package:dartz/dartz.dart';

abstract class MigrationRepository {
  Future<Either<Failure, String>> migrationAssetOld(Migration params);
}
