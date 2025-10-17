import 'inventory_export.dart';
import 'package:get_it/get_it.dart';

injectionInventory(GetIt locator) {
  locator.registerFactory(() => InventoryBloc(locator(), locator()));
  locator.registerLazySingleton(() => FindAllInventoryUseCase(locator()));
  locator.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<InventoryRemoteDataSource>(
    () => InventoryRemoteDataSourceImpl(locator(), locator()),
  );
}
