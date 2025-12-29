import 'package:asset_management/data/repositories/printer/printer_repository_impl.dart';
import 'package:asset_management/data/source/printer/printer_local_data_source.dart';
import 'package:asset_management/data/source/printer/printer_local_data_source_impl.dart';
import 'package:asset_management/domain/repositories/printer/printer_repository.dart';
import 'package:asset_management/domain/usecases/printer/get_connection_printer_use_case.dart';
import 'package:asset_management/domain/usecases/printer/get_ip_printer_use_case.dart';
import 'package:asset_management/domain/usecases/printer/set_default_printer_use_case.dart';
import 'package:get_it/get_it.dart';

printerInjection(GetIt locator) {
  locator.registerLazySingleton(() => SetDefaultPrinterUseCase(locator()));
  locator.registerLazySingleton(() => GetIpPrinterUseCase(locator()));
  locator.registerLazySingleton(() => GetConnectionPrinterUseCase(locator()));

  locator.registerLazySingleton<PrinterRepository>(
    () => PrinterRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<PrinterLocalDataSource>(
    () => PrinterLocalDataSourceImpl(locator()),
  );
}
