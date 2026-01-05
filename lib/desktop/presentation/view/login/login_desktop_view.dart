import 'package:asset_management/core/core.dart';
import 'package:asset_management/core/widgets/app_toast.dart';
import 'package:asset_management/desktop/presentation/cubit/home/home_cubit.dart';
import 'package:asset_management/domain/entities/authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/authentication_desktop/authentication_desktop_bloc.dart';

class LoginDesktopView extends StatefulWidget {
  const LoginDesktopView({super.key});

  @override
  State<LoginDesktopView> createState() => _LoginDesktopViewState();
}

class _LoginDesktopViewState extends State<LoginDesktopView> {
  late FocusNode usernameFn;
  late FocusNode passwordFn;
  late TextEditingController usernameC;
  late TextEditingController passwordC;

  @override
  void initState() {
    usernameC = TextEditingController();
    passwordC = TextEditingController();
    usernameFn = FocusNode();
    passwordFn = FocusNode();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      usernameFn.requestFocus();
    });
  }

  @override
  void dispose() {
    usernameC.dispose();
    passwordC.dispose();
    usernameFn.dispose();
    passwordFn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBackground,
      body: Center(
        child: Container(
          width: 320,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: AppColors.kWhite,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 14,
                spreadRadius: 2,
                offset: const Offset(0, 6),
              ),
            ],
            borderRadius: BorderRadius.circular(6),
          ),
          child:
              BlocConsumer<
                AuthenticationDesktopBloc,
                AuthenticationDesktopState
              >(
                listener: (context, state) {
                  if (state.status == StatusAuthenticationDesktop.loading) {
                    context.dialogLoadingDesktop();
                  }
                  if (state.status == StatusAuthenticationDesktop.failure) {
                    context.popExt();
                    AppToast.show(
                      context: context,
                      type: ToastType.error,
                      message: state.message!,
                    );
                    context.read<AuthenticationDesktopBloc>().add(
                      OnResetStateEvent(),
                    );
                  }
                  if (state.status == StatusAuthenticationDesktop.success) {
                    final permissions =
                        state.user?.modules
                            ?.map((e) => e['name'] as String)
                            .toList() ??
                        [];
                    context.read<HomeCubit>().setUserPermissions(permissions);
                    context.popExt();
                    context.go('/');
                  }
                },
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Asset Management',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.kBase,
                        ),
                      ),
                      AppSpace.vertical(36),
                      AppTextField(
                        controller: usernameC,
                        fontSize: 12,
                        hintText: 'Username',
                        noTitle: true,
                        onSubmitted: (_) => context.requestFocus(passwordFn),
                        textInputAction: TextInputAction.next,
                      ),
                      AppSpace.vertical(24),
                      AppTextField(
                        controller: passwordC,
                        fontSize: 12,
                        hintText: 'Password',
                        noTitle: true,
                        obscureText: true,
                        onSubmitted: (_) =>
                            context.read<AuthenticationDesktopBloc>().add(
                              OnLoginEvent(
                                params: Authentication(
                                  username: usernameC.value.text,
                                  password: passwordC.value.text,
                                ),
                              ),
                            ),
                        textInputAction: TextInputAction.go,
                      ),
                      AppSpace.vertical(36),
                      AppButton(
                        title:
                            state.status == StatusAuthenticationDesktop.loading
                            ? 'Loading...'
                            : 'Login',
                        fontSize: 12,
                        height: 35,
                        onPressed:
                            state.status == StatusAuthenticationDesktop.loading
                            ? null
                            : () =>
                                  context.read<AuthenticationDesktopBloc>().add(
                                    OnLoginEvent(
                                      params: Authentication(
                                        username: usernameC.value.text,
                                        password: passwordC.value.text,
                                      ),
                                    ),
                                  ),
                        width: context.deviceWidth,
                      ),
                      AppSpace.vertical(8),
                    ],
                  );
                },
              ),
        ),
      ),
    );
  }
}
