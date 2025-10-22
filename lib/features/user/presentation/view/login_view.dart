import 'package:asset_management/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../modules/home/view/home_view.dart';
import '../../user_export.dart';

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
      context.read<UserBloc>().add(OnLoginUser(username, password));
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
          Expanded(
            flex: 1,
            child: Column(
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
                BlocConsumer<UserBloc, UserState>(
                  listener: (context, state) {
                    if (state.status == StatusUser.failed) {
                      context.showSnackbar(
                        state.message!,
                        backgroundColor: AppColors.kRed,
                      );
                    }
                    if (state.status == StatusUser.success) {
                      context.pushReplacment(HomeView());
                    }
                  },
                  builder: (context, state) {
                    return AppButton(
                      title: state.status == StatusUser.loading
                          ? 'Loading...'
                          : 'Login',
                      width: double.maxFinite,
                      onPressed: state.status == StatusUser.loading
                          ? null
                          : loginSubmit,
                    );
                  },
                ),
                AppSpace.vertical(24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
