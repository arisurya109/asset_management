import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'core/utils/colors.dart';
import 'injection.dart';
import 'view/splash_view.dart';
import 'bloc/printer/printer_bloc.dart';
import 'bloc/reprint/reprint_bloc.dart';

import 'features/asset_master/presentation/bloc/asset_master/asset_master_bloc.dart';
import 'features/asset_preparation/asset_preparation.dart';
import 'features/home/presentation/cubit/home/home_cubit.dart';
import 'features/asset_count/presentation/bloc/asset_count/asset_count_bloc.dart';
import 'features/asset_count/presentation/bloc/asset_count_detail/asset_count_detail_bloc.dart';

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
        BlocProvider(create: (context) => locator<HomeCubit>()..loadItems()),
        BlocProvider(create: (context) => locator<ReprintBloc>()),
        BlocProvider(create: (context) => locator<PrinterBloc>()),
        BlocProvider(create: (context) => locator<AssetCountBloc>()),
        BlocProvider(create: (context) => locator<AssetCountDetailBloc>()),
        BlocProvider(create: (context) => locator<AssetMasterBloc>()),
        BlocProvider(create: (context) => locator<AssetPreparationBloc>()),
        BlocProvider(
          create: (context) => locator<AssetPreparationDetailBloc>(),
        ),
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
