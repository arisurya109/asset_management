import 'package:asset_management/features/asset_type/data/repositories/asset_type_repository_impl.dart';
import 'package:asset_management/features/asset_type/data/source/asset_type_remote_data_source.dart';
import 'package:asset_management/features/asset_type/data/source/asset_type_remote_data_source_impl.dart';
import 'package:asset_management/features/asset_type/domain/repositories/asset_type_repository.dart';
import 'package:asset_management/features/asset_type/domain/usecases/create_asset_type_use_case.dart';
import 'package:asset_management/features/asset_type/domain/usecases/find_all_asset_type_use_case.dart';
import 'package:asset_management/features/asset_type/presentation/bloc/asset_type/asset_type_bloc.dart';
import 'package:get_it/get_it.dart';

assetTypeInjection(GetIt locator) {
  locator.registerFactory(() => AssetTypeBloc(locator(), locator()));
  locator.registerLazySingleton(() => CreateAssetTypeUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetTypeUseCase(locator()));
  locator.registerLazySingleton<AssetTypeRepository>(
    () => AssetTypeRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AssetTypeRemoteDataSource>(
    () => AssetTypeRemoteDataSourceImpl(locator(), locator()),
  );
}
