import 'package:asset_management/features/assets/assets_export.dart';
import 'package:get_it/get_it.dart';

assetsInjection(GetIt locator) {
  locator.registerFactory(() => AssetsBloc(locator()));
  locator.registerFactory(() => AssetDetailBloc(locator()));
  locator.registerLazySingleton(() => FindAllAssetUseCase(locator()));
  locator.registerLazySingleton(() => FindAssetDetailByIdUseCase(locator()));
  locator.registerLazySingleton<AssetsRepository>(
    () => AssetsRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AssetsRemoteDataSource>(
    () => AssetsRemoteDataSourceImpl(locator(), locator()),
  );
}
