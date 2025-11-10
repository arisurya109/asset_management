import 'package:asset_management/data/repositories/preparation/preparation_repository_impl.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source.dart';
import 'package:asset_management/data/source/preparation/preparation_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/preparation/preparation_repository.dart';
import 'package:asset_management/domain/usecases/preparation/create_preparation_detail_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/create_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_all_preparation_detail_by_preparation_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_all_preparation_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_preparation_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/find_preparation_detail_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/update_preparation_detail_use_case.dart';
import 'package:asset_management/domain/usecases/preparation/update_preparation_use_case.dart';
import 'package:asset_management/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/presentation/bloc/preparation_detail/preparation_detail_bloc.dart';
import 'package:get_it/get_it.dart';

preparationInjection(GetIt locator) {
  locator.registerFactory(
    () => PreparationBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => PreparationDetailBloc(locator(), locator(), locator(), locator()),
  );

  locator.registerLazySingleton(() => CreatePreparationUseCase(locator()));
  locator.registerLazySingleton(() => FindAllPreparationUseCase(locator()));
  locator.registerLazySingleton(() => UpdatePreparationUseCase(locator()));
  locator.registerLazySingleton(() => FindPreparationByIdUseCase(locator()));
  locator.registerLazySingleton(
    () => CreatePreparationDetailUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => FindAllPreparationDetailByPreparationIdUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => FindPreparationDetailByIdUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => UpdatePreparationDetailUseCase(locator()),
  );

  locator.registerLazySingleton<PreparationRepository>(
    () => PreparationRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<PreparationRemoteDataSource>(
    () => PreparationRemoteDataSourceImpl(locator(), locator()),
  );
}
