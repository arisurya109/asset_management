import 'package:asset_management/desktop/presentation/bloc/asset_desktop/asset_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/authentication_desktop/authentication_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/preparation_desktop/preparation_desktop_bloc.dart';
import 'package:asset_management/desktop/presentation/bloc/user_management/user_management_bloc.dart';
import 'package:asset_management/desktop/presentation/cubit/add_preparation_datas/add_preparation_datas_cubit.dart';
import 'package:asset_management/desktop/presentation/cubit/home/home_cubit.dart';
import 'package:asset_management/desktop/presentation/cubit/preparation_update/preparation_update_cubit.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

desktopBlocInjection() {
  locator.registerFactory(
    () => AuthenticationDesktopBloc(locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => UserManagementBloc(locator(), locator(), locator()),
  );
  locator.registerFactory(() => AssetDesktopBloc(locator(), locator()));
  locator.registerFactory(() => PreparationDesktopBloc(locator()));
  locator.registerFactory(() => HomeCubit());
  locator.registerFactory(
    () => PreparationUpdateCubit(locator(), locator(), locator()),
  );
  locator.registerFactory(
    () => AddPreparationDatasCubit(locator(), locator(), locator()),
  );
}
