import 'package:asset_management/data/repositories/master/master_repository_impl.dart';
import 'package:asset_management/data/source/master/master_remote_data_source.dart';
import 'package:asset_management/data/source/master/master_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/master/master_repository.dart';
import 'package:asset_management/domain/usecases/master/create_asset_brand_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_asset_category_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_asset_model_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_asset_type_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_location_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_preparation_template_item_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_preparation_template_use_case.dart';
import 'package:asset_management/domain/usecases/master/create_vendor_use_case.dart';
import 'package:asset_management/domain/usecases/master/delete_preparation_template_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_brand_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_category_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_model_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_asset_type_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_location_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_preparation_template_item_by_template_id_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_preparation_template_use_case.dart';
import 'package:asset_management/domain/usecases/master/find_all_vendor_use_case.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:get_it/get_it.dart';

masterInjection(GetIt locator) {
  locator.registerFactory(
    () => MasterBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerLazySingleton(() => FindAllAssetBrandUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetCategoryUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetModelUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetTypeUseCase(locator()));
  locator.registerLazySingleton(() => FindAllLocationUseCase(locator()));
  locator.registerLazySingleton(() => FindAllVendorUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetBrandUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetCategoryUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetModelUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetTypeUseCase(locator()));
  locator.registerLazySingleton(() => CreateLocationUseCase(locator()));
  locator.registerLazySingleton(() => CreateVendorUseCase(locator()));
  locator.registerLazySingleton(
    () => CreatePreparationTemplateUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => CreatePreparationTemplateItemUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => DeletePreparationTemplateUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => FindAllPreparationTemplateUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => FindAllPreparationTemplateItemByTemplateIdUseCase(locator()),
  );

  locator.registerLazySingleton<MasterRepository>(
    () => MasterRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<MasterRemoteDataSource>(
    () => MasterRemoteDataSourceImpl(locator(), locator()),
  );
}
