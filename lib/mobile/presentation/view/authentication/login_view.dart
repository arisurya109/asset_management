import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../../../domain/entities/authentication/authentication.dart';
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
  late FocusNode usernameFn;
  late FocusNode passwordFn;

  @override
  void initState() {
    usernameC = TextEditingController();
    passwordC = TextEditingController();
    usernameFn = FocusNode();
    passwordFn = FocusNode();
    usernameFn.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    usernameC.dispose();
    passwordC.dispose();
    usernameFn.dispose();
    passwordFn.dispose();
    FocusManager.instance.primaryFocus?.unfocus();
    super.dispose();
  }

  loginSubmit(bool isLarge) {
    FocusManager.instance.primaryFocus?.unfocus();
    final username = usernameC.value.text.trim();
    final password = passwordC.value.text.trim();

    if (!username.isFilled()) {
      context.showSnackbar(
        'Username cannot be empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (!password.isFilled()) {
      context.showSnackbar(
        'Password cannot be empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else {
      context.read<AuthenticationBloc>().add(
        OnLoginEvent(Authentication(username: username, password: password)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileLogin(context),
      mobileMScaffold: _mobileLogin(context),
    );
  }

  Widget _mobileLogin(BuildContext context, {bool isLarge = true}) {
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
              fontSize: isLarge ? 38 : 24,
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
                  fontSize: isLarge ? 18 : 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.kBase,
                ),
              ),
              AppSpace.vertical(32),
              AppTextField(
                title: 'Username',
                focusNode: usernameFn,
                controller: usernameC,
                hintText: 'Username',
                fontSize: isLarge ? 14 : 12,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              AppSpace.vertical(24),
              AppTextField(
                title: 'Password',
                fontSize: isLarge ? 14 : 12,
                controller: passwordC,
                focusNode: passwordFn,
                obscureText: true,
                hintText: 'Password',
                onSubmitted: (_) => loginSubmit(isLarge),
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
                      fontSize: isLarge ? 14 : 12,
                    );
                  }
                  if (state.status == StatusAuthentication.success) {
                    context.pushReplacmentExt(HomeView());
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    fontSize: isLarge ? 16 : 14,
                    title: state.status == StatusAuthentication.loading
                        ? 'Loading...'
                        : 'Login',
                    width: double.maxFinite,
                    onPressed: state.status == StatusAuthentication.loading
                        ? null
                        : () => loginSubmit(isLarge),
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
