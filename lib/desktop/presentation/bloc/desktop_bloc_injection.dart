import 'package:asset_management/desktop/presentation/bloc/asset_desktop/asset_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/authentication_desktop/authentication_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_detail_desktop/preparation_detail_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/return/return_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/location_desktop/location_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_desktop/preparation_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_update/preparation_update_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/user_management/user_management_bloc.dart';
import 'package:asset_management/desktop/presentation/cubit/datas/datas_desktop_cubit.dart';
import 'package:asset_management/desktop/presentation/cubit/home/home_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

desktopBlocInjection() {
  locator.registerFactory(
    () => AuthenticationDesktopBloc(locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => UserManagementBloc(locator(), locator(), locator()),
  );
  locator.registerFactory(() => AssetDesktopBloc(locator()));
  locator.registerFactory(() => PreparationDesktopBloc(locator(), locator()));
  locator.registerFactory(() => HomeCubit());
  locator.registerFactory(
    () => DatasDesktopCubit(
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
  locator.registerFactory(() => LocationDesktopBloc(locator(), locator()));
  locator.registerFactory(() => PreparationUpdateBloc(locator()));
  locator.registerFactory(() => ReturnBloc(locator()));
  locator.registerFactory(
    () => PreparationDetailDesktopBloc(locator(), locator()),
  );
}
