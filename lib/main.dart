import 'package:asset_management/presentation/bloc/asset/asset_bloc.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/bloc/master/master_bloc.dart';
import 'package:asset_management/presentation/bloc/permissions/permissions_bloc.dart';
import 'package:asset_management/presentation/bloc/printer/printer_bloc.dart';
import 'package:asset_management/presentation/view/authentication/splash_view.dart';

import 'main_export.dart';
import 'presentation/bloc/user/user_bloc.dart';

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
        BlocProvider(
          create: (context) =>
              locator<MasterBloc>()..add(OnInitializeMasterEvent()),
        ),
        BlocProvider(
          create: (context) => locator<AssetBloc>()..add(OnFindAllAssetEvent()),
        ),
        BlocProvider(create: (context) => locator<UserBloc>()),
        BlocProvider(create: (context) => locator<AuthenticationBloc>()),
        BlocProvider(create: (context) => locator<PermissionsBloc>()),
        BlocProvider(create: (context) => locator<PrinterBloc>()),
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
            surfaceTintColor: AppColors.kWhite,
            backgroundColor: AppColors.kBackground,
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
