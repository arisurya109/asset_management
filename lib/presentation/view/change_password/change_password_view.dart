import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/authentication/authentication.dart';
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
    return Scaffold(
      appBar: AppBar(title: Text('Change Password')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        children: [
          AppSpace.vertical(12),
          AppTextField(
            title: 'Password',
            controller: passwordC,
            hintText: 'Password',
            obscureText: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          AppSpace.vertical(16),
          AppTextField(
            title: 'New Password',
            controller: newPasswordC,
            hintText: 'New Password',
            obscureText: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
          ),
          AppSpace.vertical(16),
          AppTextField(
            title: 'Confirm Password',
            controller: confirmPasswordC,
            hintText: 'Confirm Password',
            obscureText: true,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.go,
            onSubmitted: (_) => _update(),
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
                );
              }

              if (state.status == StatusAuthentication.success) {
                context.showSnackbar(
                  state.message ?? 'Successfully change password',
                );
              }
            },
            builder: (context, state) {
              return AppButton(
                title: state.status == StatusAuthentication.loading
                    ? 'Loading...'
                    : 'Update',
                onPressed: state.status == StatusAuthentication.loading
                    ? null
                    : _update,
              );
            },
          ),
        ],
      ),
    );
  }

  _update() {
    final password = passwordC.value.text.trim();
    final newPassword = newPasswordC.value.text.trim();
    final confirmPassword = confirmPasswordC.value.text.trim();

    if (!password.isFilled()) {
      context.showSnackbar(
        'Password is empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (!newPassword.isFilled()) {
      context.showSnackbar(
        'New Password is empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (!confirmPassword.isFilled()) {
      context.showSnackbar(
        'Confirm Password is empty',
        backgroundColor: AppColors.kRed,
      );
    } else if (confirmPassword != newPassword) {
      context.showSnackbar(
        'Confirm password is not valid',
        backgroundColor: AppColors.kRed,
      );
    } else {
      context.showDialogConfirm(
        title: 'Change Password',
        content: 'Are you sure change password ?',
        onCancel: () => context.pop(),
        onCancelText: 'No',
        onConfirmText: 'Yes',
        onConfirm: () {
          context.read<AuthenticationBloc>().add(
            OnChangePasswordEvent(
              Authentication(
                username: context
                    .read<AuthenticationBloc>()
                    .state
                    .user
                    ?.username,
                password: password,
                newPassword: newPassword,
              ),
            ),
          );
          context.pop();
        },
      );
    }
  }
}
