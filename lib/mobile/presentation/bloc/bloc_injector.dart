import 'package:asset_management/mobile/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/picking/picking_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/picking_detail/picking_detail_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/transfer/transfer_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/brand/brand_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/category/category_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/inventory/inventory_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/location/location_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/migration/migration_cubit.dart';
import 'package:asset_management/mobile/presentation/bloc/model/model_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/registration/registration_cubit.dart';
import 'package:asset_management/mobile/presentation/bloc/user/user_bloc.dart';
import 'package:asset_management/mobile/presentation/cubit/datas_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

mobileBlocInjection() {
  locator.registerFactory(() => InventoryBloc(locator(), locator()));
  locator.registerFactory(() => AssetBloc(locator()));
  locator.registerFactory(
    () => AuthenticationBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(() => PrinterBloc(locator(), locator(), locator()));
  locator.registerFactory(
    () => UserBloc(locator(), locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(() => BrandBloc(locator(), locator()));
  locator.registerFactory(() => ModelBloc(locator(), locator()));
  locator.registerFactory(() => CategoryBloc(locator(), locator()));
  locator.registerFactory(() => LocationBloc(locator(), locator()));
  locator.registerFactory(
    () => DatasCubit(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(
    () => RegistrationCubit(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => MigrationCubit(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(() => TransferBloc(locator(), locator()));
  locator.registerFactory(() => PickingBloc(locator(), locator()));
  locator.registerFactory(() => PickingDetailBloc(locator(), locator()));
}
