import 'package:get_it/get_it.dart';

import 'registration_export.dart';

registrationInjection(GetIt locator) {
  locator.registerFactory(() => RegistrationBloc(locator(), locator()));
  locator.registerLazySingleton(
    () => RegistrationAssetConsumableUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => RegistrationAssetNonConsumableUseCase(locator()),
  );
  locator.registerLazySingleton<RegistrationRepository>(
    () => RegistrationRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<RegistrationRemoteDataSource>(
    () => RegistrationRemoteDataSourceImpl(locator(), locator()),
  );
}
