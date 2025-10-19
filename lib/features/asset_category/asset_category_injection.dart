import 'package:asset_management/features/asset_category/data/repositories/asset_category_repository_impl.dart';
import 'package:asset_management/features/asset_category/data/source/asset_category_remote_data_source.dart';
import 'package:asset_management/features/asset_category/data/source/asset_category_remote_data_source_impl.dart';
import 'package:asset_management/features/asset_category/domain/repositories/asset_category_repository.dart';
import 'package:asset_management/features/asset_category/domain/usecases/create_asset_category_use_case.dart';
import 'package:asset_management/features/asset_category/domain/usecases/find_all_asset_category_use_case.dart';
import 'package:asset_management/features/asset_category/presentation/bloc/asset_category/asset_category_bloc.dart';
import 'package:get_it/get_it.dart';

assetCategoryInjection(GetIt locator) {
  locator.registerFactory(() => AssetCategoryBloc(locator(), locator()));
  locator.registerLazySingleton(() => FindAllAssetCategoryUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetCategoryUseCase(locator()));
  locator.registerLazySingleton<AssetCategoryRepository>(
    () => AssetCategoryRepositoryImpl(locator()),
  );
  locator.registerLazySingleton<AssetCategoryRemoteDataSource>(
    () => AssetCategoryRemoteDataSourceImpl(locator(), locator()),
  );
}
