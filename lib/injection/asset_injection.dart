import 'package:asset_management/data/repositories/asset/asset_repository_impl.dart';
import 'package:asset_management/data/source/asset/asset_remote_data_source.dart';
import 'package:asset_management/data/source/asset/asset_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/asset/asset_repository.dart';
import 'package:asset_management/domain/usecases/asset/create_asset_transfer_use_case.dart';
import 'package:asset_management/domain/usecases/asset/create_asset_use_case.dart';
import 'package:asset_management/domain/usecases/asset/find_all_asset_use_case.dart';
import 'package:asset_management/domain/usecases/asset/find_asset_detail_by_id_use_case.dart';
import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:get_it/get_it.dart';

assetInjection(GetIt locator) {
  locator.registerFactory(
    () => AssetBloc(locator(), locator(), locator(), locator()),
  );

  locator.registerLazySingleton(() => CreateAssetUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetUseCase(locator()));
  locator.registerLazySingleton(() => FindAssetDetailByIdUseCase(locator()));
  locator.registerLazySingleton(() => CreateAssetTransferUseCase(locator()));

  locator.registerLazySingleton<AssetRepository>(
    () => AssetRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<AssetRemoteDataSource>(
    () => AssetRemoteDataSourceImpl(locator(), locator()),
  );
}
