import 'package:asset_management/features/location/data/repositories/location_repository_impl.dart';
import 'package:asset_management/features/location/domain/repositories/location_repository.dart';
import 'package:asset_management/features/location/domain/usecases/create_location_use_case.dart';
import 'package:asset_management/features/location/domain/usecases/find_all_location_use_case.dart';
import 'package:asset_management/features/location/presentation/bloc/location/location_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/source/location_remote_data_source.dart';
import 'data/source/location_remote_data_source_impl.dart';

locationInjection(GetIt locator) {
  locator.registerFactory(() => LocationBloc(locator(), locator()));
  locator.registerLazySingleton(() => FindAllLocationUseCase(locator()));
  locator.registerLazySingleton(() => CreateLocationUseCase(locator()));
  locator.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<LocationRemoteDataSource>(
    () => LocationRemoteDataSourceImpl(locator(), locator()),
  );
}
