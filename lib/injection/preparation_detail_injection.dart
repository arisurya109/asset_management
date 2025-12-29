import 'package:asset_management/data/repositories/preparation_detail/preparation_detail_repository_impl.dart';
import 'package:asset_management/data/source/preparation_detail/preparation_detail_remote_data_source.dart';
import 'package:asset_management/data/source/preparation_detail/preparation_detail_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/preparation_detail/preparation_detail_repository.dart';
import 'package:asset_management/domain/usecases/preparation_detail/create_preparation_detail_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_detail/find_preparation_detail_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_detail/update_preparation_detail_use_case.dart';
import 'package:asset_management/domain/usecases/preparation_detail/update_status_preparation_detail_use_case.dart';
import 'package:get_it/get_it.dart';

preparationDetailInjection(GetIt locator) {
  locator.registerLazySingleton(
    () => CreatePreparationDetailUseCase(locator()),
  );

  locator.registerLazySingleton(
    () => FindPreparationDetailByIdUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => UpdatePreparationDetailUseCase(locator()),
  );
  locator.registerLazySingleton(
    () => UpdateStatusPreparationDetailUseCase(locator()),
  );

  locator.registerLazySingleton<PreparationDetailRepository>(
    () => PreparationDetailRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<PreparationDetailRemoteDataSource>(
    () => PreparationDetailRemoteDataSourceImpl(locator(), locator()),
  );
}
