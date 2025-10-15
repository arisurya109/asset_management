import 'package:asset_management/features/asset_master_new/asset_master_export.dart';
import 'package:asset_management/features/asset_master_new/presentation/cubit/asset_master_new_cubit.dart';
import 'package:asset_management/features/asset_registration/presentation/bloc/asset_registration/asset_registration_bloc.dart';
import 'package:asset_management/features/locations/presentation/bloc/bloc/location_bloc.dart';
import 'package:asset_management/features/modules/asset_transfer/presentation/bloc/asset_transfer/asset_transfer_bloc.dart';
import 'package:asset_management/features/modules/assets/cubit/modul_asset_cubit.dart';
import 'package:asset_management/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:asset_management/features/user/presentation/view/splash_view.dart';

import 'main_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting('id_ID').then((_) => runApp(const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<HomeCubit>()),
        BlocProvider(create: (context) => locator<ModulAssetCubit>()),
        BlocProvider(create: (context) => locator<ReprintBloc>()),
        BlocProvider(create: (context) => locator<PrinterBloc>()),
        BlocProvider(create: (context) => locator<AssetCountBloc>()),
        BlocProvider(create: (context) => locator<AssetCountDetailBloc>()),
        BlocProvider(create: (context) => locator<AssetMasterBloc>()),
        BlocProvider(create: (context) => locator<AssetPreparationBloc>()),
        BlocProvider(
          create: (context) => locator<AssetPreparationDetailBloc>(),
        ),
        BlocProvider(create: (context) => locator<UserBloc>()),
        BlocProvider(create: (context) => locator<AssetTypeBloc>()),
        BlocProvider(create: (context) => locator<AssetCategoryBloc>()),
        BlocProvider(create: (context) => locator<AssetBrandBloc>()),
        BlocProvider(create: (context) => locator<AssetModelBloc>()),
        BlocProvider(create: (context) => locator<AssetMasterNewCubit>()),
        BlocProvider(create: (context) => locator<AssetRegistrationBloc>()),
        BlocProvider(create: (context) => locator<LocationBloc>()),
        BlocProvider(create: (context) => locator<AssetTransferBloc>()),
      ],
      child: MaterialApp(
        locale: Locale('id', 'ID'),
        title: 'Asset Management',
        debugShowCheckedModeBanner: false,
        home: SplashView(),
        theme: ThemeData(
          fontFamily: 'Poppins',
          drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.teal,
              fontSize: 20,
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
    );
  }
}
