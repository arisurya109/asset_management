import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../domain/entities/authentication/authentication.dart';
import '../../bloc/authentication/authentication_bloc.dart';
import '../home/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController usernameC;
  late TextEditingController passwordC;

  @override
  void initState() {
    usernameC = TextEditingController();
    passwordC = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  loginSubmit() {
    final username = usernameC.value.text.trim();
    final password = passwordC.value.text.trim();

    if (!username.isFilled()) {
      context.showSnackbar('Username cannot be empty');
    } else if (!password.isFilled()) {
      context.showSnackbar('Password cannot be empty');
    } else {
      context.read<AuthenticationBloc>().add(
        OnLoginEvent(Authentication(username: username, password: password)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Center(
            child: Container(
              height: context.deviceHeight * 0.25,
              width: context.deviceHeight * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(Assets.iLogoWs)),
              ),
            ),
          ),
          Text(
            'Login',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w600,
              color: AppColors.kBase,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpace.vertical(2),
              Text(
                'Please Sign in to continue',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kBase,
                ),
              ),
              AppSpace.vertical(32),
              AppTextField(
                title: 'Username',
                controller: usernameC,
                hintText: 'Username',
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              AppSpace.vertical(24),
              AppTextField(
                title: 'Password',
                controller: passwordC,
                obscureText: true,
                hintText: 'Password',
                onSubmitted: (_) => loginSubmit(),
                textInputAction: TextInputAction.go,
                keyboardType: TextInputType.text,
              ),
              AppSpace.vertical(48),
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state.status == StatusAuthentication.failed) {
                    context.showSnackbar(
                      state.message!,
                      backgroundColor: AppColors.kRed,
                    );
                  }
                  if (state.status == StatusAuthentication.success) {
                    context.pushReplacment(HomeView());
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    title: state.status == StatusAuthentication.loading
                        ? 'Loading...'
                        : 'Login',
                    width: double.maxFinite,
                    onPressed: state.status == StatusAuthentication.loading
                        ? null
                        : loginSubmit,
                  );
                },
              ),
              AppSpace.vertical(24),
            ],
          ),
        ],
      ),
    );
  }
}
