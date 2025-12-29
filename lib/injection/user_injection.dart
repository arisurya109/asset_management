import 'package:asset_management/domain/usecases/user/create_user_use_case.dart';
import 'package:get_it/get_it.dart';

import 'package:asset_management/domain/usecases/user/delete_user_use_case.dart';
import 'package:asset_management/domain/usecases/user/find_all_user_use_case.dart';
import 'package:asset_management/domain/usecases/user/find_user_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/user/update_user_use_case.dart';

import '../data/repositories/user/user_repository_impl.dart';
import '../data/source/user/user_remote_data_source.dart';
import '../data/source/user/user_remote_data_source_impl.dart';
import '../domain/repositories/user/user_repository.dart';

userInjection(GetIt locator) {
  locator.registerLazySingleton(() => CreateUserUseCase(locator()));
  locator.registerLazySingleton(() => FindAllUserUseCase(locator()));
  locator.registerLazySingleton(() => FindUserByIdUseCase(locator()));
  locator.registerLazySingleton(() => DeleteUserUseCase(locator()));
  locator.registerLazySingleton(() => UpdateUserUseCase(locator()));

  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(locator(), locator()),
  );
}
