import 'package:asset_management/core/service/printer_service.dart';
import 'package:asset_management/features/home/presentation/cubit/home_cubit.dart';
import 'package:asset_management/features/printer/data/repositories/printer_repository_impl.dart';
import 'package:asset_management/features/printer/data/source/printer_source.dart';
import 'package:asset_management/features/printer/domain/repositories/printer_repository.dart';
import 'package:asset_management/features/printer/domain/usecases/get_ip_printer_use_case.dart';
import 'package:asset_management/features/printer/domain/usecases/set_default_printer_use_case.dart';
import 'package:asset_management/features/printer/presentation/cubit/printer_cubit.dart';
import 'package:asset_management/features/reprint/data/repositories/reprint_repository_impl.dart';
import 'package:asset_management/features/reprint/data/source/reprint_source.dart';
import 'package:asset_management/features/reprint/domain/repositories/reprint_repository.dart';
import 'package:asset_management/features/reprint/domain/usecases/reprint_asset_by_asset_id_use_case.dart';
import 'package:asset_management/features/reprint/domain/usecases/reprint_asset_by_serial_number_use_case.dart';
import 'package:asset_management/features/reprint/domain/usecases/reprint_location_use_case.dart';
import 'package:asset_management/features/reprint/presentation/bloc/reprint_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

Future<void> injection() async {
  final pref = await SharedPreferences.getInstance();

  // BloC
  locator.registerFactory(() => ReprintBloc(locator(), locator(), locator()));
  locator.registerFactory(() => HomeCubit());
  locator.registerFactory(() => PrinterCubit(locator(), locator()));

  // Usecases
  locator.registerLazySingleton(
    () => ReprintAssetBySerialNumberUseCase(locator()),
  );
  locator.registerLazySingleton(() => ReprintAssetByAssetIdUseCase(locator()));
  locator.registerLazySingleton(() => ReprintLocationUseCase(locator()));
  locator.registerLazySingleton(() => SetDefaultPrinterUseCase(locator()));
  locator.registerLazySingleton(() => GetIpPrinterUseCase(locator()));

  // Repository
  locator.registerLazySingleton<ReprintRepository>(
    () => ReprintRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<PrinterRepository>(
    () => PrinterRepositoryImpl(locator()),
  );

  // Source
  locator.registerLazySingleton<ReprintSource>(
    () => ReprintSourceImpl(locator()),
  );
  locator.registerLazySingleton<PrinterSource>(
    () => PrinterSourceImpl(locator()),
  );

  // Services
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton<PrinterServices>(
    () => PrinterServiceImpl(locator()),
  );
}
