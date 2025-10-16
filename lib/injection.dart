import 'package:asset_management/core/config/token_helper.dart';
import 'package:asset_management/features/asset_master_new/asset_master_export.dart';
import 'package:asset_management/features/asset_master_new/presentation/cubit/asset_master_new_cubit.dart';
import 'package:asset_management/features/asset_registration/data/source/asset_registration_source.dart';
import 'package:asset_management/features/asset_registration/domain/usecases/create_asset_registration_consumable_use_case.dart';
import 'package:asset_management/features/asset_registration/domain/usecases/create_asset_registration_use_case.dart';
import 'package:asset_management/features/asset_registration/domain/usecases/find_all_asset_registration_use_case.dart';
import 'package:asset_management/features/asset_registration/domain/usecases/migration_asset_use_case.dart';
import 'package:asset_management/features/asset_registration/presentation/bloc/asset_registration/asset_registration_bloc.dart';
import 'package:asset_management/features/locations/data/source/location_remote_data_source.dart';
import 'package:asset_management/features/locations/data/source/location_remote_data_source_impl.dart';
import 'package:asset_management/features/locations/domain/repositories/location_repository.dart';
import 'package:asset_management/features/locations/domain/usecases/create_location_use_case.dart';
import 'package:asset_management/features/locations/domain/usecases/find_all_location_use_case.dart';
import 'package:asset_management/features/locations/presentation/bloc/bloc/location_bloc.dart';
import 'package:asset_management/features/modules/asset_transfer/data/repositories/asset_transfer_repository_impl.dart';
import 'package:asset_management/features/modules/asset_transfer/data/source/asset_transfer_remote_data_source.dart';
import 'package:asset_management/features/modules/asset_transfer/domain/usecases/create_asset_transfer_use_case.dart';
import 'package:asset_management/features/modules/asset_transfer/presentation/bloc/asset_transfer/asset_transfer_bloc.dart';
import 'package:asset_management/features/modules/assets/cubit/modul_asset_cubit.dart';
import 'package:asset_management/features/user/data/source/user_remote_data_source.dart';
import 'package:asset_management/features/user/data/source/user_remote_data_source_impl.dart';
import 'package:asset_management/features/user/domain/repositories/user_repository.dart';
import 'package:asset_management/features/user/domain/usecases/auto_login_use_case.dart';
import 'package:asset_management/features/user/domain/usecases/change_password_use_case.dart';
import 'package:asset_management/features/user/domain/usecases/login_use_case.dart';
import 'package:asset_management/features/user/domain/usecases/logout_use_case.dart';
import 'package:asset_management/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/asset_preparation/asset_preparation.dart';
import 'features/asset_registration/data/repositories/asset_registration_repository_impl.dart';
import 'features/asset_registration/data/source/asset_registration_source_impl.dart';
import 'features/asset_registration/domain/repositories/asset_registration_repository.dart';
import 'features/home/presentation/cubit/home/home_cubit.dart';
import 'bloc/printer/printer_bloc.dart';
import 'features/locations/data/repositories/location_repository_impl.dart';
import 'features/modules/asset_transfer/data/source/asset_transfer_remote_data_source_impl.dart';
import 'features/modules/asset_transfer/domain/repositories/asset_transfer_repository.dart';
import 'features/modules/inventories/inventory_export.dart';
import 'features/reprint/reprint.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
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
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future<void> injection() async {
  final pref = await SharedPreferences.getInstance();

  // Bloc
  injectionInventory(locator);
  locator.registerFactory(() => HomeCubit());
  locator.registerFactory(() => ModulAssetCubit());
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
  locator.registerFactory(
    () => UserBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => AssetTypeBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => AssetBrandBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => AssetCategoryBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => AssetModelBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(() => AssetMasterNewCubit());
  locator.registerFactory(
    () => AssetRegistrationBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(() => LocationBloc(locator(), locator()));
  locator.registerFactory(() => AssetTransferBloc(locator()));

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
  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => LogoutUseCase(locator()));
  locator.registerLazySingleton(() => ChangePasswordUseCase(locator()));
  locator.registerLazySingleton(() => AutoLoginUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetBrandUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetTypeUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetCategoryUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetModelUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetBrandUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetTypeUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetCategoryUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetModelUseCase(locator()));
  locator.registerLazySingleton(() => UpdateAssetBrandUseCase(locator()));
  locator.registerLazySingleton(() => UpdateAssetTypeUseCase(locator()));
  locator.registerLazySingleton(() => UpdateAssetCategoryUseCase(locator()));
  locator.registerLazySingleton(() => UpdateAssetModelUseCase(locator()));
  locator.registerLazySingleton(() => FindByIdAssetBrandUseCase(locator()));
  locator.registerLazySingleton(() => FindByIdAssetTypeUseCase(locator()));
  locator.registerLazySingleton(() => FindByIdAssetCategoryUseCase(locator()));
  locator.registerLazySingleton(() => FindByIdAssetModelUseCase(locator()));
  locator.registerLazySingleton(
    () => FindAllAssetRegistrationUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => CreateAssetRegistrationUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => CreateAssetRegistrationConsumable(locator()),
  );
  locator.registerLazySingleton(() => MigrationAssetUseCase(locator()));
  locator.registerLazySingleton(() => FindAllLocationUseCase(locator()));
  locator.registerLazySingleton(() => CreateLocationUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetTransferUseCase(locator()));

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
  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AssetMasterNewRepository>(
    () => AssetMasterNewRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AssetRegistrationRepository>(
    () => AssetRegistrationRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AssetTransferRepository>(
    () => AssetTransferRepositoryImpl(locator()),
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
  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(locator(), locator()),
  );
  locator.registerLazySingleton<AssetMasterRemoteDataSource>(
    () => AssetMasterRemoteDataSourceImpl(locator(), locator()),
  );
  locator.registerLazySingleton<AssetRegistrationSource>(
    () => AssetRegistrationSourceImpl(locator(), locator(), locator()),
  );
  locator.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(locator(), locator()),
  );
  locator.registerLazySingleton<AssetTransferRemoteDataSource>(
    () => AssetTransferRemoteDataSourceImpl(locator(), locator()),
  );

  // Services
  locator.registerLazySingleton(() => pref);
  locator.registerLazySingleton(() => DatabaseHelper.instance);
  locator.registerLazySingleton<PrinterServices>(
    () => PrinterServiceImpl(locator()),
  );
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton<TokenHelper>(() => TokenHelperImpl(locator()));
}
