import 'package:asset_management/features/vendor/vendor_export.dart';
import 'package:get_it/get_it.dart';

vendorInjection(GetIt locator) {
  locator.registerFactory(() => VendorBloc(locator(), locator(), locator()));
  locator.registerLazySingleton(() => CreateVendorUseCase(locator()));
  locator.registerLazySingleton(() => FindAllVendorUseCase(locator()));
  locator.registerLazySingleton(() => UpdateVendorUseCase(locator()));
  locator.registerLazySingleton<VendorRepository>(
    () => VendorRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<VendorRemoteDataSource>(
    () => VendorRemoteDataSourceImpl(locator(), locator()),
  );
}
