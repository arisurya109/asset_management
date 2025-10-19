import 'package:asset_management/features/migration/data/model/migration_model.dart';

abstract class MigrationRemoteDataSource {
  Future<String> migrationAssetIdOld(MigrationModel params);
}
