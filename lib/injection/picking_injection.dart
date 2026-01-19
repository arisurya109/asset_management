import 'package:asset_management/data/repositories/picking/picking_repository_impl.dart';
import 'package:asset_management/data/source/picking/picking_remote_data_source.dart';
import 'package:asset_management/data/source/picking/picking_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/picking/picking_repository.dart';
import 'package:asset_management/domain/usecases/picking/add_pick_asset_picking_use_case.dart';
import 'package:asset_management/domain/usecases/picking/find_all_picking_task_use_case.dart';
import 'package:asset_management/domain/usecases/picking/picking_detail_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/picking/update_status_picking_use_case.dart';
import 'package:get_it/get_it.dart';

pickingInjection(GetIt locator) {
  locator.registerLazySingleton(() => FindAllPickingTaskUseCase(locator()));
  locator.registerLazySingleton(() => PickingDetailByIdUseCase(locator()));
  locator.registerLazySingleton(() => AddPickAssetPickingUseCase(locator()));
  locator.registerLazySingleton(() => UpdateStatusPickingUseCase(locator()));

  locator.registerLazySingleton<PickingRepository>(
    () => PickingRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<PickingRemoteDataSource>(
    () => PickingRemoteDataSourceImpl(locator(), locator()),
  );
}
