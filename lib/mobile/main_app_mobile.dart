import 'package:asset_management/mobile/my_custom_scroll.dart';
import 'package:asset_management/mobile/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/brand/brand_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/category/category_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/inventory/inventory_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/location/location_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/migration/migration_cubit.dart';
import 'package:asset_management/mobile/presentation/bloc/model/model_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/picking/picking_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/picking_detail/picking_detail_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/mobile/presentation/bloc/registration/registration_cubit.dart';
import 'package:asset_management/mobile/presentation/bloc/transfer/transfer_bloc.dart';
import 'package:asset_management/mobile/presentation/cubit/datas_cubit.dart';
import 'package:asset_management/mobile/presentation/view/authentication/splash_view.dart';

import 'main_export.dart';
import 'presentation/bloc/user/user_bloc.dart';

class MainAppMobile extends StatelessWidget {
  const MainAppMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<AssetBloc>()),
        BlocProvider(
          create: (context) => locator<UserBloc>()..add(OnFindAllUserEvent()),
        ),
        BlocProvider(create: (context) => locator<AuthenticationBloc>()),
        BlocProvider(create: (context) => locator<PrinterBloc>()),
        BlocProvider(create: (context) => locator<InventoryBloc>()),
        BlocProvider(create: (context) => locator<BrandBloc>()),
        BlocProvider(create: (context) => locator<CategoryBloc>()),
        BlocProvider(create: (context) => locator<ModelBloc>()),
        BlocProvider(create: (context) => locator<LocationBloc>()),
        BlocProvider(create: (context) => locator<DatasCubit>()),
        BlocProvider(create: (context) => locator<RegistrationCubit>()),
        BlocProvider(create: (context) => locator<MigrationCubit>()),
        BlocProvider(create: (context) => locator<TransferBloc>()),
        BlocProvider(create: (context) => locator<PickingBloc>()),
        BlocProvider(create: (context) => locator<PickingDetailBloc>()),
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
