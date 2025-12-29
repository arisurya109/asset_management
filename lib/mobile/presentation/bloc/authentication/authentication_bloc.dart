import 'package:asset_management/domain/entities/authentication/authentication.dart';
import 'package:asset_management/domain/entities/user/user.dart';
import 'package:asset_management/domain/usecases/authentication/auto_login_use_case.dart';
import 'package:asset_management/domain/usecases/authentication/change_password_use_case.dart';
import 'package:asset_management/domain/usecases/authentication/login_use_case.dart';
import 'package:asset_management/domain/usecases/authentication/logout_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final AutoLoginUseCase _autoLoginUseCase;
  final ChangePasswordUseCase _changePasswordUseCase;

  AuthenticationBloc(
    this._loginUseCase,
    this._logoutUseCase,
    this._autoLoginUseCase,
    this._changePasswordUseCase,
  ) : super(AuthenticationState()) {
    on<OnLoginEvent>((event, emit) async {
      emit(state.copyWith(status: StatusAuthentication.loading));

      final failureOrUser = await _loginUseCase(event.params);

      return failureOrUser.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAuthentication.failed,
            message: failure.message,
          ),
        ),
        (user) => emit(
          state.copyWith(status: StatusAuthentication.success, user: user),
        ),
      );
    });

    on<OnLogoutEvent>((event, emit) async {
      emit(state.copyWith(status: StatusAuthentication.loading));

      await Future.delayed(Duration(seconds: 5));

      final response = await _logoutUseCase();

      return response.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAuthentication.failed,
            message: failure.message,
          ),
        ),
        (_) => emit(
          state.copyWith(
            status: StatusAuthentication.success,
            resetUser: true,
            message: 'Successfully Logout',
          ),
        ),
      );
    });

    on<OnAutoLoginEvent>((event, emit) async {
      emit(state.copyWith(status: StatusAuthentication.loading));

      final response = await _autoLoginUseCase();

      return response.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAuthentication.failed,
            message: failure.message,
          ),
        ),
        (user) => emit(
          state.copyWith(status: StatusAuthentication.success, user: user),
        ),
      );
    });

    on<OnChangePasswordEvent>((event, emit) async {
      emit(state.copyWith(status: StatusAuthentication.loading));

      final response = await _changePasswordUseCase(event.params);

      return response.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusAuthentication.failed,
            message: failure.message,
          ),
        ),
        (response) => emit(
          state.copyWith(
            status: StatusAuthentication.success,
            message: response,
          ),
        ),
      );
    });
  }
}
