import 'package:asset_management/features/user/data/repositories/user_repository_impl.dart';
import 'package:asset_management/features/user/domain/repositories/user_repository.dart';
import 'package:asset_management/features/user/domain/usecases/auto_login_use_case.dart';
import 'package:asset_management/features/user/domain/usecases/login_use_case.dart';
import 'package:asset_management/features/user/domain/usecases/logout_use_case.dart';
import 'package:asset_management/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/source/user_remote_data_source.dart';
import 'data/source/user_remote_data_source_impl.dart';

userInjector(GetIt locator) {
  locator.registerFactory(() => UserBloc(locator(), locator(), locator()));

  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => AutoLoginUseCase(locator()));
  locator.registerLazySingleton(() => LogoutUseCase(locator()));

  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(locator(), locator()),
  );
}
