import 'package:get_it/get_it.dart';

import '../data/repositories/permissions/permissions_repository_impl.dart';
import '../data/source/permissions/permissions_remote_data_source.dart';
import '../data/source/permissions/permissions_remote_data_source_impl.dart';
import '../domain/repositories/permissions/permissions_repository.dart';
import '../domain/usecases/permissions/find_all_permissions_use_case.dart';
import '../presentation/bloc/permissions/permissions_bloc.dart';

permissionsInjection(GetIt locator) {
  locator.registerFactory(() => PermissionsBloc(locator()));

  locator.registerLazySingleton(() => FindAllPermissionsUseCase(locator()));

  locator.registerLazySingleton<PermissionsRepository>(
    () => PermissionsRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<PermissionsRemoteDataSource>(
    () => PermissionsRemoteDataSourceImpl(locator(), locator()),
  );
}
