import 'package:asset_management/mobile/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/permissions/permissions_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/picking/picking_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/purchase_order/purchase_order_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/user/user_bloc.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

mobileBlocInjection() {
  locator.registerFactory(
    () => AssetBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => AuthenticationBloc(locator(), locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => MasterBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(() => PermissionsBloc(locator()));
  locator.registerFactory(
    () => PickingBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
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
    () => PreparationBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
  locator.registerFactory(() => PrinterBloc(locator(), locator(), locator()));
  locator.registerFactory(
    () => PurchaseOrderBloc(locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => UserBloc(locator(), locator(), locator(), locator(), locator()),
  );
}
