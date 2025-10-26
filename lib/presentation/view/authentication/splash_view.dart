import 'package:asset_management/core/core.dart';
import 'package:asset_management/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:asset_management/presentation/view/authentication/login_view.dart';
import 'package:asset_management/presentation/view/home/home_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationBloc>().add(OnAutoLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == StatusAuthentication.failed) {
          context.pushReplacment(LoginView());
        }
        if (state.status == StatusAuthentication.success) {
          context.pushReplacment(HomeView());
        }
      },
      child: Scaffold(
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
      ),
    );
  }
}
