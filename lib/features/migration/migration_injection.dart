import 'package:get_it/get_it.dart';

import 'migration_export.dart';

migrationInjection(GetIt locator) {
  locator.registerFactory(() => MigrationBloc(locator()));
  locator.registerLazySingleton(() => MigrationAssetOldUseCase(locator()));
  locator.registerLazySingleton<MigrationRepository>(
    () => MigrationRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<MigrationRemoteDataSource>(
    () => MigrationRemoteDataSourceImpl(locator(), locator()),
  );
}
