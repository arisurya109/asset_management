import 'package:asset_management/features/user/domain/entities/user.dart';
import 'package:asset_management/features/user/domain/usecases/auto_login_use_case.dart';
import 'package:asset_management/features/user/domain/usecases/login_use_case.dart';
import 'package:asset_management/features/user/domain/usecases/logout_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final LoginUseCase _loginUseCase;
  final AutoLoginUseCase _autoLoginUseCase;
  final LogoutUseCase _logoutUseCase;

  UserBloc(this._loginUseCase, this._autoLoginUseCase, this._logoutUseCase)
    : super(UserState()) {
    on<OnLoginUser>((event, emit) async {
      emit(state.copyWith(status: StatusUser.loading));

      await Future.delayed(Duration(seconds: 5));

      final response = await _loginUseCase(event.username, event.password);

      return response.fold(
        (l) =>
            emit(state.copyWith(status: StatusUser.failed, message: l.message)),
        (r) => emit(state.copyWith(status: StatusUser.success, user: r)),
      );
    });

    on<OnAutoLoginUser>((event, emit) async {
      emit(state.copyWith(status: StatusUser.loading));

      final response = await _autoLoginUseCase();

      return response.fold(
        (l) =>
            emit(state.copyWith(status: StatusUser.failed, message: l.message)),
        (r) => emit(state.copyWith(status: StatusUser.success, user: r)),
      );
    });

    on<OnLogoutUser>((event, emit) async {
      emit(state.copyWith(status: StatusUser.loading));

      await Future.delayed(Duration(seconds: 5));

      final response = await _logoutUseCase();

      return response.fold(
        (l) =>
            emit(state.copyWith(status: StatusUser.failed, message: l.message)),
        (r) => emit(
          state.copyWith(
            status: StatusUser.success,
            resetUser: true,
            message: 'Successfully Logout',
          ),
        ),
      );
    });
  }
}
