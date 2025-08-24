import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/printer/printer_bloc.dart';
import 'bloc/reprint/reprint_bloc.dart';
import 'repositories/printer_repository.dart';
import 'repositories/reprint_repository.dart';
import 'services/printer_service.dart';
import 'usecases/printer/get_ip_printer_use_case.dart';
import 'usecases/printer/set_default_printer_use_case.dart';
import 'usecases/reprint/reprint_asset_id_by_asset_id_use_case.dart';
import 'usecases/reprint/reprint_location_use_case.dart';

final locator = GetIt.instance;

Future<void> injection() async {
  final pref = await SharedPreferences.getInstance();

  // BloC
  locator.registerFactory(() => ReprintBloc(locator(), locator()));
  locator.registerFactory(() => PrinterBloc(locator(), locator()));

  // Usecases
  locator.registerLazySingleton(
    () => ReprintAssetIdByAssetIdUseCase(locator()),
  );
  locator.registerLazySingleton(() => ReprintLocationUseCase(locator()));
  locator.registerLazySingleton(() => SetDefaultPrinterUseCase(locator()));
  locator.registerLazySingleton(() => GetIpPrinterUseCase(locator()));

  // Repositories
  locator.registerLazySingleton<ReprintRepository>(
    () => ReprintRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<PrinterRepository>(
    () => PrinterRepositoryImpl(locator()),
  );

  // Services
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton<PrinterServices>(
    () => PrinterServiceImpl(locator()),
  );
}
