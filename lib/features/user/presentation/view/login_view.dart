import 'package:asset_management/features/user/domain/entities/user.dart';
import 'package:asset_management/features/user/presentation/bloc/user/user_bloc.dart';
import 'package:asset_management/view/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late TextEditingController usernameC;
  late TextEditingController passwordC;

  @override
  void dispose() {
    usernameC.dispose();
    passwordC.dispose();
    super.dispose();
  }

  @override
  void initState() {
    usernameC = TextEditingController();
    passwordC = TextEditingController();
    super.initState();
  }

  loginSubmit() {
    final username = usernameC.value.text.trim();
    final password = passwordC.value.text.trim();

    if (!username.isFilled()) {
      context.showSnackbar('Username cannot be empty');
    } else if (!password.isFilled()) {
      context.showSnackbar('Password cannot be empty');
    } else {
      context.read<UserBloc>().add(
        OnLoginUser(User(username: username, password: password)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: 240,
                  width: 240,
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
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
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
              AppSpace.vertical(32),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state.status == StatusUser.failed) {
                    context.showSnackbar(
                      state.message!,
                      backgroundColor: AppColors.kRed,
                    );
                  }
                  if (state.status == StatusUser.success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeView()),
                    );
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
            ],
          ),
        ),
      ),
    );
  }
}
