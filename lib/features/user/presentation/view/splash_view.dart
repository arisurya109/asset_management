import 'package:asset_management/core/core.dart';
import 'package:asset_management/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:asset_management/features/user/presentation/view/login_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../modules/home/view/home_view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(OnAutoLoginUser());
    Future.delayed(const Duration(seconds: 10), () async {
      final status = context.read<UserBloc>().state.status;
      context.pushReplacment(
        status == StatusUser.success ? HomeView() : LoginView(),
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
