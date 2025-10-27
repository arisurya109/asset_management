import 'package:asset_management/data/repositories/purchase_order/purchase_order_repository_impl.dart';
import 'package:asset_management/data/source/purchase_order/purchase_order_remote_data_source.dart';
import 'package:asset_management/data/source/purchase_order/purchase_order_remote_data_source_impl.dart';
import 'package:asset_management/domain/repositories/purchase_order/purchase_order_repository.dart';
import 'package:asset_management/domain/usecases/purchase_order/create_purchase_order_use_case.dart';
import 'package:asset_management/domain/usecases/purchase_order/find_all_asset_purchase_order_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/purchase_order/find_all_purchase_order_use_case.dart';
import 'package:asset_management/presentation/bloc/purchase_order/purchase_order_bloc.dart';
import 'package:get_it/get_it.dart';

purchaseOrderInjection(GetIt locator) {
  locator.registerFactory(
    () => PurchaseOrderBloc(locator(), locator(), locator()),
  );

  locator.registerLazySingleton(() => CreatePurchaseOrderUseCase(locator()));
  locator.registerLazySingleton(() => FindAllPurchaseOrderUseCase(locator()));
  locator.registerLazySingleton(() => FindAllAssetPurchaseOrderById(locator()));

  locator.registerLazySingleton<PurchaseOrderRepository>(
    () => PurchaseOrderRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<PurchaseOrderRemoteDataSource>(
    () => PurchaseOrderRemoteDataSourceImpl(locator(), locator()),
  );
}
