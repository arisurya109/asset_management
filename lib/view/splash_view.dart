import 'package:asset_management/core/utils/assets.dart';

import '../bloc/printer/printer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/home/presentation/view/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<PrinterBloc>().add(OnGetIpPrinter());
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF29A198),
      body: Center(
        child: Container(
          height: 180,
          width: 180,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(Assets.iWatsons)),
          ),
        ),
      ),
    );
  }
}
