import 'package:asset_management/features/printer/data/repositories/printer_repository_impl.dart';
import 'package:asset_management/features/printer/domain/repositories/printer_repository.dart';
import 'package:asset_management/features/printer/domain/usecases/get_connection_printer_use_case.dart';
import 'package:asset_management/features/printer/domain/usecases/get_ip_printer_use_case.dart';
import 'package:asset_management/features/printer/domain/usecases/set_default_printer_use_case.dart';
import 'package:asset_management/features/printer/presentation/bloc/printer/printer_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/source/printer_local_data_source.dart';
import 'data/source/printer_local_data_source_impl.dart';

printerInjection(GetIt locator) {
  locator.registerFactory(() => PrinterBloc(locator(), locator(), locator()));
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
