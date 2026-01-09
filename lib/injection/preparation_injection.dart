import 'package:asset_management/data/repositories/preparation/preparation_detail_repository_impl.dart';
import 'package:asset_management/data/repositories/preparation/preparation_repository_impl.dart';
import 'package:asset_management/data/source/preparation/preparation_detail_remote_data_source.dart';
import 'package:asset_management/data/source/preparation/preparation_detail_remote_data_source_impl.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_detail_repository.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:asset_management/domain/usecases/preparation/add_preparation_detail_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/create_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_preparation_by_pagination_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/get_preparation_details_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/get_preparation_types_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/update_preparation_status_use_case.dart';
import 'package:get_it/get_it.dart';

preparationInjection(GetIt locator) {
  locator.registerLazySingleton(() => AddPreparationDetailUseCase(locator()));
  locator.registerLazySingleton(() => GetPreparationDetailsUseCase(locator()));
  locator.registerLazySingleton(() => CreatePreparationUseCase(locator()));
  locator.registerLazySingleton(
    () => FindPreparationByPaginationUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => UpdatePreparationStatusUseCase(locator()),
  );
  locator.registerLazySingleton(() => GetPreparationTypesUseCase(locator()));

  locator.registerLazySingleton<PreparationRepository>(
    () => PreparationRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<PreparationDetailRepository>(
    () => PreparationDetailRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<PreparationRemoteDataSource>(
    () => PreparationRemoteDataSourceImpl(locator(), locator()),
  );
  locator.registerLazySingleton<PreparationDetailRemoteDataSource>(
    () => PreparationDetailRemoteDataSourceImpl(locator(), locator()),
  );
}
