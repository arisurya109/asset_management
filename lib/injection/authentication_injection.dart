import 'package:asset_management/data/repositories/authentication/authentication_repository_impl.dart';
import 'package:asset_management/data/source/authentication/authentication_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/authentication/authentication_repository.dart';
import 'package:asset_management/domain/usecases/authentication/auto_login_use_case.dart';
import 'package:asset_management/domain/usecases/authentication/change_password_use_case.dart';
import 'package:asset_management/domain/usecases/authentication/login_use_case.dart';
import 'package:asset_management/domain/usecases/authentication/logout_use_case.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:get_it/get_it.dart';

import '../data/source/authentication/authentication_remote_data_source.dart';

authenticationInjection(GetIt locator) {
  locator.registerFactory(
    () => AuthenticationBloc(locator(), locator(), locator(), locator()),
  );

  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => LogoutUseCase(locator()));
  locator.registerLazySingleton(() => ChangePasswordUseCase(locator()));
  locator.registerLazySingleton(() => AutoLoginUseCase(locator()));

  locator.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(locator(), locator()),
  );
}
