import 'package:asset_management/features/home/presentation/cubit/home_cubit.dart';
import 'package:asset_management/features/home/presentation/home_view.dart';
import 'package:asset_management/features/printer/presentation/cubit/printer_cubit.dart';
import 'package:asset_management/features/reprint/presentation/bloc/reprint_bloc.dart';
import 'package:asset_management/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<HomeCubit>()),
        BlocProvider(create: (_) => locator<PrinterCubit>()),
        BlocProvider(create: (_) => locator<ReprintBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            backgroundColor: Colors.teal,
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: IconThemeData(color: Colors.white),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: HomeView(),
      ),
    );
  }
}
