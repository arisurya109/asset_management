import 'package:asset_management/data/repositories/inventory/inventory_repository_impl.dart';
import 'package:asset_management/data/source/inventory/inventory_remote_data_source.dart';
import 'package:asset_management/data/source/inventory/inventory_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/inventory/inventory_repository.dart';
import 'package:asset_management/domain/usecases/inventory/find_inventory_use_case.dart';
import 'package:get_it/get_it.dart';

inventoryInjection(GetIt locator) {
  locator.registerLazySingleton(() => FindInventoryUseCase(locator()));

  locator.registerLazySingleton<InventoryRepository>(
    () => InventoryRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<InventoryRemoteDataSource>(
    () => InventoryRemoteDataSourceImpl(locator(), locator()),
  );
}
