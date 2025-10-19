import 'package:asset_management/features/asset_brand/asset_brand_export.dart';
import 'package:asset_management/features/asset_category/asset_category_export.dart';
import 'package:asset_management/features/asset_model/asset_model_export.dart';
import 'package:asset_management/features/asset_type/asset_type_export.dart';
import 'package:asset_management/features/assets/assets_export.dart';
import 'package:asset_management/features/location/location_export.dart';
import 'package:asset_management/features/migration/migration_export.dart';
import 'package:asset_management/features/printer/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/features/registration/registration_export.dart';
import 'package:asset_management/features/transfer/transfer_export.dart';
import 'package:asset_management/features/user/presentation/view/splash_view.dart';

import 'features/user/user_export.dart';
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
        BlocProvider(create: (context) => locator<UserBloc>()),
        BlocProvider(create: (context) => locator<AssetTypeBloc>()),
        BlocProvider(create: (context) => locator<AssetBrandBloc>()),
        BlocProvider(create: (context) => locator<AssetCategoryBloc>()),
        BlocProvider(create: (context) => locator<AssetModelBloc>()),
        BlocProvider(create: (context) => locator<LocationBloc>()),
        BlocProvider(create: (context) => locator<AssetsBloc>()),
        BlocProvider(create: (context) => locator<AssetDetailBloc>()),
        BlocProvider(create: (context) => locator<PrinterBloc>()),
        BlocProvider(create: (context) => locator<RegistrationBloc>()),
        BlocProvider(create: (context) => locator<MigrationBloc>()),
        BlocProvider(create: (context) => locator<TransferBloc>()),
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
          scaffoldBackgroundColor: AppColors.kWhite,
        ),
      ),
    );
  }
}
