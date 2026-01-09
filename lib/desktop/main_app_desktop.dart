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
import 'package:asset_management/desktop/routes.dart';
import 'package:asset_management/mobile/my_custom_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toastification/toastification.dart';

import '../core/core.dart';
import 'presentation/bloc/desktop_bloc_injection.dart';

class MainAppDesktop extends StatelessWidget {
  const MainAppDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => locator<AuthenticationDesktopBloc>(),
          ),
          BlocProvider(create: (context) => locator<AssetDesktopBloc>()),
          BlocProvider(create: (context) => locator<UserManagementBloc>()),
          BlocProvider(create: (context) => locator<PreparationDesktopBloc>()),
          BlocProvider(create: (context) => locator<HomeCubit>()),
          BlocProvider(create: (context) => locator<DatasDesktopCubit>()),
          BlocProvider(create: (context) => locator<LocationDesktopBloc>()),
          BlocProvider(create: (context) => locator<PreparationUpdateBloc>()),
          BlocProvider(create: (context) => locator<ReturnBloc>()),
          BlocProvider(
            create: (context) => locator<PreparationDetailDesktopBloc>(),
          ),
        ],
        child: MaterialApp.router(
          scrollBehavior: MyCustomScrollBehavior(),
          locale: Locale('id', 'ID'),
          title: 'Asset Management',
          debugShowCheckedModeBanner: false,
          routerConfig: Routes.config,
          theme: ThemeData(
            scrollbarTheme: ScrollbarThemeData(minThumbLength: 40),
            fontFamily: 'Poppins',
            drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
            appBarTheme: AppBarTheme(
              centerTitle: true,
              surfaceTintColor: AppColors.kWhite,
              backgroundColor: AppColors.kBackground,
              titleTextStyle: TextStyle(
                color: Colors.teal,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.5,
              ),
              iconTheme: IconThemeData(color: Colors.teal),
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.kBackground,
          ),
        ),
      ),
    );
  }
}
