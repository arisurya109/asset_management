import 'package:asset_management/features/transfer/transfer_export.dart';
import 'package:get_it/get_it.dart';

transferInjection(GetIt locator) {
  locator.registerFactory(() => TransferBloc(locator()));
  locator.registerLazySingleton(() => TransferAssetUseCase(locator()));
  locator.registerLazySingleton<TransferRepository>(
    () => TransferRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<TransferRemoteDataSource>(
    () => TransferRemoteDataSourceImpl(locator(), locator()),
  );
}
