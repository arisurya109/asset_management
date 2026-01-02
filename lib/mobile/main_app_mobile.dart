import 'package:asset_management/mobile/my_custom_scroll.dart';
import 'package:asset_management/mobile/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/inventory/inventory_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/picking/picking_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/preparation/preparation_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/purchase_order/purchase_order_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/permissions/permissions_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/mobile/presentation/view/authentication/splash_view.dart';

import 'main_export.dart';
import 'presentation/bloc/user/user_bloc.dart';

class MainAppMobile extends StatelessWidget {
  const MainAppMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              locator<MasterBloc>()..add(OnInitializeMasterEvent()),
        ),
        BlocProvider(
          create: (context) => locator<AssetBloc>()..add(OnFindAllAssetEvent()),
        ),
        BlocProvider(
          create: (context) => locator<UserBloc>()..add(OnFindAllUserEvent()),
        ),
        BlocProvider(create: (context) => locator<AuthenticationBloc>()),
        BlocProvider(create: (context) => locator<PermissionsBloc>()),
        BlocProvider(create: (context) => locator<PrinterBloc>()),
        BlocProvider(
          create: (context) =>
              locator<PurchaseOrderBloc>()..add(OnFindAllPurchaseOrderEvent()),
        ),
        BlocProvider(create: (context) => locator<PreparationBloc>()),
        BlocProvider(create: (context) => locator<PickingBloc>()),
        BlocProvider(create: (context) => locator<InventoryBloc>()),
      ],
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        locale: Locale('id', 'ID'),
        title: 'Asset Management',
        debugShowCheckedModeBanner: false,
        home: SplashView(),
        theme: ThemeData(
          fontFamily: 'Poppins',
          drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            surfaceTintColor: AppColors.kWhite,
            backgroundColor: AppColors.kBackgroundMobile,
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
          scaffoldBackgroundColor: AppColors.kBackgroundMobile,
        ),
      ),
    );
  }
}
