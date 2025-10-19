import 'package:asset_management/features/asset_brand/data/repositories/asset_brand_repository_impl.dart';
import 'package:asset_management/features/asset_brand/domain/repositories/asset_brand_repository.dart';
import 'package:asset_management/features/asset_brand/domain/usecases/create_asset_brand_use_case.dart';
import 'package:asset_management/features/asset_brand/domain/usecases/find_all_asset_brand_use_case.dart';
import 'package:asset_management/features/asset_brand/presentation/bloc/asset_brand/asset_brand_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/source/asset_brand_remote_data_source.dart';
import 'data/source/asset_brand_remote_data_source_impl.dart';

assetBrandInjection(GetIt locator) {
  locator.registerFactory(() => AssetBrandBloc(locator(), locator()));
  locator.registerLazySingleton(() => CreateAssetBrandUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetBrandUseCase(locator()));
  locator.registerLazySingleton<AssetBrandRepository>(
    () => AssetBrandRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AssetBrandRemoteDataSource>(
    () => AssetBrandRemoteDataSourceImpl(locator(), locator()),
  );
}
