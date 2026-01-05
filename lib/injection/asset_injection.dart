import 'package:asset_management/data/repositories/asset/asset_repository_impl.dart';
import 'package:asset_management/data/source/asset/asset_remote_data_source.dart';
import 'package:asset_management/data/source/asset/asset_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/asset/asset_repository.dart';
import 'package:asset_management/domain/usecases/asset/find_all_asset_use_case.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_pagination_use_case.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_by_query_use_case.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_detail_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/asset/migration_asset_use_case.dart';
import 'package:asset_management/domain/usecases/asset/registration_asset_use_case.dart';
import 'package:get_it/get_it.dart';

assetInjection(GetIt locator) {
  locator.registerLazySingleton(() => RegistrationAssetUseCase(locator()));
  locator.registerLazySingleton(() => MigrationAssetUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetUseCase(locator()));
  locator.registerLazySingleton(() => FindAssetDetailByIdUseCase(locator()));
  locator.registerLazySingleton(() => FindAssetByQueryUseCase(locator()));
  locator.registerLazySingleton(() => FindAssetByPaginationUseCase(locator()));

  locator.registerLazySingleton<AssetRepository>(
    () => AssetRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<AssetRemoteDataSource>(
    () => AssetRemoteDataSourceImpl(locator(), locator()),
  );
}
