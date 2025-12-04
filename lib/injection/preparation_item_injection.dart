import 'package:asset_management/data/repositories/preparation_item/preparation_item_repository_impl.dart';
import 'package:asset_management/data/source/preparation_item/preparation_item_remote_data_source.dart';
import 'package:asset_management/data/source/preparation_item/preparation_item_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/preparation_item/preparation_item_repository.dart';
import 'package:asset_management/domain/usecases/preparation_item/create_preparation_item_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_item/delete_preparation_item_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_item/find_all_preparation_item_by_preparation_detail_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_item/find_all_preparation_item_by_preparation_id_use_case.dart';
// import 'package:asset_management/presentation/bloc/preparation_item/preparation_item_bloc.dart';
import 'package:get_it/get_it.dart';

preparationItemInjection(GetIt locator) {
  // locator.registerFactory(
  //   () => PreparationItemBloc(locator(), locator(), locator(), locator()),
  // );

  locator.registerLazySingleton(() => CreatePreparationItemUseCase(locator()));
  locator.registerLazySingleton(() => DeletePreparationItemUseCase(locator()));
  locator.registerLazySingleton(
    () => FindAllPreparationItemByPreparationIdUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => FindAllPreparationItemByPreparationDetailIdUseCase(locator()),
  );

  locator.registerLazySingleton<PreparationItemRepository>(
    () => PreparationItemRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<PreparationItemRemoteDataSource>(
    () => PreparationItemRemoteDataSourceImpl(locator(), locator()),
  );
}
