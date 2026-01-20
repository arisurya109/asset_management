import 'package:asset_management/core/core.dart';
import 'package:asset_management/domain/entities/authentication/authentication.dart';
import 'package:asset_management/domain/usecases/authentication/change_password_use_case.dart';
import 'package:asset_management/domain/usecases/authentication/login_use_case.dart';
import 'package:asset_management/domain/usecases/authentication/logout_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entities/user/user.dart';

part 'authentication_desktop_event.dart';
part 'authentication_desktop_state.dart';

class AuthenticationDesktopBloc
    extends Bloc<AuthenticationDesktopEvent, AuthenticationDesktopState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;

  AuthenticationDesktopBloc(
    this._loginUseCase,
    this._logoutUseCase,
    this._changePasswordUseCase,
  ) : super(AuthenticationDesktopState()) {
    on<OnLoginEvent>((event, emit) async {
      final username = event.params.username;
      final password = event.params.password;

      emit(state.copyWith(status: StatusAuthenticationDesktop.loading));

      await Future.delayed(Duration(seconds: 5));

      if (!username.isFilled()) {
        emit(
          state.copyWith(
            status: StatusAuthenticationDesktop.failure,
            message: 'Username cannot be empty',
          ),
        );
      } else if (!password.isFilled()) {
        emit(
          state.copyWith(
            status: StatusAuthenticationDesktop.failure,
            message: 'Password cannot be empty',
          ),
        );
      } else {
        final failureOrUser = await _loginUseCase(
          Authentication(username: username, password: password),
        );

        return failureOrUser.fold(
          (failure) => emit(
            state.copyWith(
              status: StatusAuthenticationDesktop.failure,
              message: failure.message,
            ),
          ),
          (user) => emit(
            state.copyWith(
              status: StatusAuthenticationDesktop.success,
              user: user,
            ),
          ),
        );
      }
    });
    on<OnLogoutEvent>((event, emit) async {
      emit(state.copyWith(status: StatusAuthenticationDesktop.loading));

      await Future.delayed(Duration(seconds: 2));

      final response = await _logoutUseCase();

      return response.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAuthenticationDesktop.failure,
            message: failure.message,
          ),
        ),
        (_) => emit(
          state.copyWith(
            status: StatusAuthenticationDesktop.success,
            resetUser: true,
            message: 'Successfully Logout',
          ),
        ),
      );
    });
    on<OnChangePasswordEvent>((event, emit) async {
      final username = state.user!.username;
      final password = event.params.password;
      final newPassword = event.params.newPassword;
      final conNewPassword = event.conNewPassword;

      if (!password.isFilled()) {
        emit(
          state.copyWith(
            status: StatusAuthenticationDesktop.failure,
            message: 'Password cannot be empty',
          ),
        );
      } else if (!newPassword.isFilled()) {
        emit(
          state.copyWith(
            status: StatusAuthenticationDesktop.failure,
            message: 'New Password cannot be empty',
          ),
        );
      } else if (!conNewPassword.isFilled()) {
        emit(
          state.copyWith(
            status: StatusAuthenticationDesktop.failure,
            message: 'Confirm Password cannot be empty',
          ),
        );
      } else if (conNewPassword != newPassword) {
        emit(
          state.copyWith(
            status: StatusAuthenticationDesktop.failure,
            message: 'Password confirmation does not match',
          ),
        );
      } else {
        emit(state.copyWith(status: StatusAuthenticationDesktop.loading));

        final response = await _changePasswordUseCase(
          Authentication(
            username: username!,
            password: password,
            newPassword: newPassword,
          ),
        );

        return response.fold(
          (failure) => emit(
            state.copyWith(
              status: StatusAuthenticationDesktop.failure,
              message: failure.message,
            ),
          ),
          (response) => emit(
            state.copyWith(
              status: StatusAuthenticationDesktop.success,
              message: response,
            ),
          ),
        );
      }
    });
    on<OnResetStateEvent>((event, emit) {
      emit(state.copyWith(status: StatusAuthenticationDesktop.initial));
    });
  }
}
