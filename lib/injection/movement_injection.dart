import 'package:asset_management/data/repositories/movement/movement_repository_impl.dart';
import 'package:asset_management/data/source/movement/movement_remote_data_source.dart';
import 'package:asset_management/data/source/movement/movement_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/movement/movement_repository.dart';
import 'package:asset_management/domain/usecases/movement/create_movement_use_case.dart';
import 'package:get_it/get_it.dart';

movementInjection(GetIt locator) {
  locator.registerLazySingleton(() => CreateMovementUseCase(locator()));

  locator.registerLazySingleton<MovementRepository>(
    () => MovementRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<MovementRemoteDataSource>(
    () => MovementRemoteDataSourceImpl(locator(), locator()),
  );
}
