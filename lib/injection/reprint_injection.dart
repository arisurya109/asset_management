import 'package:asset_management/data/repositories/reprint/reprint_repository_impl.dart';
import 'package:asset_management/data/source/reprint/reprint_remote_data_source.dart';
import 'package:asset_management/data/source/reprint/reprint_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/reprint/reprint_repository.dart';
import 'package:asset_management/domain/usecases/reprint/reprint_asset_or_location_use_case.dart';
import 'package:get_it/get_it.dart';

reprintInjection(GetIt locator) {
  locator.registerLazySingleton(() => ReprintAssetOrLocationUseCase(locator()));

  locator.registerLazySingleton<ReprintRepository>(
    () => ReprintRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<ReprintRemoteDataSource>(
    () => ReprintRemoteDataSourceImpl(locator(), locator()),
  );
}
