import 'package:asset_management/core/config/database_helper.dart';
import 'package:asset_management/features/asset_count/data/repositories/asset_count_repository_impl.dart';
import 'package:asset_management/features/asset_count/data/source/asset_count_source.dart';
import 'package:asset_management/features/asset_count/data/source/asset_count_source_impl.dart';
import 'package:asset_management/features/asset_count/domain/repositories/asset_count_repository.dart';
import 'package:asset_management/features/asset_count/domain/usecases/usecases.dart';
import 'package:asset_management/features/asset_count/presentation/bloc/asset_count/asset_count_bloc.dart';
import 'package:asset_management/features/asset_count/presentation/bloc/asset_count_detail/asset_count_detail_bloc.dart';
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
  locator.registerFactory(
    () => AssetCountBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => AssetCountDetailBloc(locator(), locator(), locator()),
  );

  // Usecases
  locator.registerLazySingleton(
    () => ReprintAssetIdByAssetIdUseCase(locator()),
  );
  locator.registerLazySingleton(() => ReprintLocationUseCase(locator()));
  locator.registerLazySingleton(() => SetDefaultPrinterUseCase(locator()));
  locator.registerLazySingleton(() => GetIpPrinterUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetCountUseCase(locator()));
  locator.registerLazySingleton(() => DeleteAssetCountDetailUseCase(locator()));
  locator.registerLazySingleton(() => ExportAssetCountIdUseCase(locator()));
  locator.registerLazySingleton(
    () => FindAllAssetCountDetailByIdCountUseCase(locator()),
  );
  locator.registerLazySingleton(() => FindAllAssetCountUseCase(locator()));
  locator.registerLazySingleton(() => InsertAssetCountDetailUseCase(locator()));
  locator.registerLazySingleton(() => UpdateStatusAssetCountUseCase(locator()));

  // Repositories
  locator.registerLazySingleton<ReprintRepository>(
    () => ReprintRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<PrinterRepository>(
    () => PrinterRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AssetCountRepository>(
    () => AssetCountRepositoryImpl(locator()),
  );

  // Source
  locator.registerLazySingleton<AssetCountSource>(
    () => AssetCountSourceImpl(locator()),
  );

  // Services
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => DatabaseHelper.instance);
  locator.registerLazySingleton<PrinterServices>(
    () => PrinterServiceImpl(locator()),
  );
}
