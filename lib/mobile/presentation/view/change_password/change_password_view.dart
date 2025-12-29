import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/authentication/authentication.dart';
import 'package:asset_management/mobile/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication/authentication_bloc.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late TextEditingController passwordC;
  late TextEditingController newPasswordC;
  late TextEditingController confirmPasswordC;

  @override
  void initState() {
    passwordC = TextEditingController();
    newPasswordC = TextEditingController();
    confirmPasswordC = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileLScaffold: _mobileChangePassword(),
      mobileMScaffold: _mobileChangePassword(isLarge: false),
    );
  }

  Widget _mobileChangePassword({bool isLarge = true}) {
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          AppSpace.vertical(12),
          AppTextField(
            title: 'Password',
            fontSize: isLarge ? 14 : 12,
            controller: passwordC,
            hintText: 'Password',
            obscureText: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          AppSpace.vertical(16),
          AppTextField(
            title: 'New Password',
            fontSize: isLarge ? 14 : 12,
            controller: newPasswordC,
            hintText: 'New Password',
            obscureText: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          AppSpace.vertical(16),
          AppTextField(
            title: 'Confirm Password',
            fontSize: isLarge ? 14 : 12,
            controller: confirmPasswordC,
            hintText: 'Confirm Password',
            obscureText: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => _update(isLarge),
          ),
          AppSpace.vertical(32),
          BlocConsumer<AuthenticationBloc, AuthenticationState>(
            listener: (context, state) {
              passwordC.clear();
              newPasswordC.clear();
              confirmPasswordC.clear();
              if (state.status == StatusAuthentication.failed) {
                context.showSnackbar(
                  state.message ?? '',
                  backgroundColor: AppColors.kRed,
                  fontSize: isLarge ? 14 : 12,
                );
              }

              if (state.status == StatusAuthentication.success) {
                context.showSnackbar(
                  state.message ?? 'Successfully change password',
                  fontSize: isLarge ? 14 : 12,
                );
              }
            },
            builder: (context, state) {
              return AppButton(
                title: state.status == StatusAuthentication.loading
                    ? 'Loading...'
                    : 'Update',
                fontSize: isLarge ? 16 : 14,
                onPressed: state.status == StatusAuthentication.loading
                    ? null
                    : () => _update(isLarge),
              );
            },
          ),
        ],
      ),
    );
  }

  _update(bool isLarge) {
    final password = passwordC.value.text.trim();
    final newPassword = newPasswordC.value.text.trim();
    final confirmPassword = confirmPasswordC.value.text.trim();

    if (!password.isFilled()) {
      context.showSnackbar(
        'Password is empty',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else if (!newPassword.isFilled()) {
      context.showSnackbar(
        'New Password is empty',
        fontSize: isLarge ? 14 : 12,
        backgroundColor: AppColors.kRed,
      );
    } else if (!confirmPassword.isFilled()) {
      context.showSnackbar(
        'Confirm Password is empty',
        fontSize: isLarge ? 14 : 12,
        backgroundColor: AppColors.kRed,
      );
    } else if (confirmPassword != newPassword) {
      context.showSnackbar(
        'Confirm password is not valid',
        backgroundColor: AppColors.kRed,
        fontSize: isLarge ? 14 : 12,
      );
    } else {
      context.showDialogConfirm(
        title: 'Change Password',
        fontSize: isLarge ? 14 : 12,
        content: 'Are you sure change password ?',
        onCancel: () => context.popExt(),
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onConfirm: () {
          context.read<AuthenticationBloc>().add(
            OnChangePasswordEvent(
              Authentication(
                username: context
                    .read<AuthenticationBloc>()
                    .state
                    .user!
                    .username!,
                password: password,
                newPassword: newPassword,
              ),
            ),
          );
          context.popExt();
        },
      );
    }
  }
}
