import 'package:asset_management/features/asset_model/data/repositories/asset_model_repository_impl.dart';
import 'package:asset_management/features/asset_model/domain/repositories/asset_model_repository.dart';
import 'package:asset_management/features/asset_model/domain/usecases/create_asset_model_use_case.dart';
import 'package:asset_management/features/asset_model/domain/usecases/find_all_asset_model_use_case.dart';
import 'package:asset_management/features/asset_model/presentation/bloc/asset_model/asset_model_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/source/asset_model_remote_data_source.dart';
import 'data/source/asset_model_remote_data_source_impl.dart';

assetModelInjection(GetIt locator) {
  locator.registerFactory(() => AssetModelBloc(locator(), locator()));
  locator.registerLazySingleton(() => FindAllAssetModelUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetModelUseCase(locator()));
  locator.registerLazySingleton<AssetModelRepository>(
    () => AssetModelRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AssetModelRemoteDataSource>(
    () => AssetModelRemoteDataSourceImpl(locator(), locator()),
  );
}
