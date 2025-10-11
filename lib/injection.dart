import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/asset_preparation/asset_preparation.dart';
import 'features/home/presentation/cubit/home/home_cubit.dart';
import 'bloc/printer/printer_bloc.dart';
import 'features/reprint/reprint.dart';
import 'services/printer_service.dart';
import 'core/config/database_helper.dart';
import 'features/asset_master/domain/usecases/usecases.dart';
import 'features/asset_master/presentation/bloc/asset_master/asset_master_bloc.dart';
import 'features/asset_count/data/repositories/asset_count_repository_impl.dart';
import 'features/asset_count/data/source/asset_count_source.dart';
import 'features/asset_count/data/source/asset_count_source_impl.dart';
import 'features/asset_count/domain/repositories/asset_count_repository.dart';
import 'features/asset_count/domain/usecases/usecases.dart';
import 'features/asset_count/presentation/bloc/asset_count/asset_count_bloc.dart';
import 'features/asset_count/presentation/bloc/asset_count_detail/asset_count_detail_bloc.dart';
import 'features/asset_master/data/repositories/asset_master_repository_impl.dart';
import 'features/asset_master/data/source/asset_master_source.dart';
import 'features/asset_master/data/source/asset_master_source_impl.dart';
import 'features/asset_master/domain/repositories/asset_master_repository.dart';
import 'repositories/printer_repository.dart';
import 'usecases/printer/get_ip_printer_use_case.dart';
import 'usecases/printer/set_default_printer_use_case.dart';

final locator = GetIt.instance;

Future<void> injection() async {
  final pref = await SharedPreferences.getInstance();

  // Bloc
  locator.registerFactory(() => HomeCubit());
  locator.registerFactory(() => ReprintBloc(locator(), locator(), locator()));
  locator.registerFactory(() => PrinterBloc(locator(), locator()));
  locator.registerFactory(
    () => AssetCountBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => AssetCountDetailBloc(locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => AssetMasterBloc(locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => AssetPreparationBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => AssetPreparationDetailBloc(locator(), locator(), locator()),
  );

  // Usecases
  locator.registerLazySingleton(() => ReprintAssetIdNormalUseCase(locator()));
  locator.registerLazySingleton(() => ReprintAssetIdLargeUseCase(locator()));
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
  locator.registerLazySingleton(() => InsertAssetMasterUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetMasterUseCase(locator()));
  locator.registerLazySingleton(() => UpdateAssetMasterUseCase(locator()));
  locator.registerLazySingleton(() => FindAllPreparationsUseCase(locator()));
  locator.registerLazySingleton(() => FindPreparationByIdUseCase(locator()));
  locator.registerLazySingleton(
    () => FindAllAssetPreparationDetailUseCase(locator()),
  );
  locator.registerLazySingleton(() => CreatePreparationUseCase(locator()));
  locator.registerLazySingleton(
    () => InsertAssetPreparationDetailUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => UpdateStatusPreparationUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => DeleteAssetPreparationDetailUseCase(locator()),
  );
  locator.registerLazySingleton(() => ExportPreparationUseCase(locator()));

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
  locator.registerLazySingleton<AssetMasterRepository>(
    () => AssetMasterRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AssetPreparationRepository>(
    () => AssetPreparationRepositoryImpl(locator()),
  );

  // Source
  locator.registerLazySingleton<AssetCountSource>(
    () => AssetCountSourceImpl(locator()),
  );
  locator.registerLazySingleton<AssetMasterSource>(
    () => AssetMasterSourceImpl(locator()),
  );
  locator.registerLazySingleton<AssetPreparationSource>(
    () => AssetPreparationSourceImpl(locator()),
  );
  locator.registerLazySingleton<ReprintSource>(
    () => ReprintSourceImpl(locator()),
  );

  // Services
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => DatabaseHelper.instance);
  locator.registerLazySingleton<PrinterServices>(
    () => PrinterServiceImpl(locator()),
  );
}
