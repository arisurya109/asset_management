import 'package:asset_management/domain/entities/user/user.dart';
import 'package:asset_management/domain/usecases/user/create_user_use_case.dart';
import 'package:asset_management/domain/usecases/user/delete_user_use_case.dart';
import 'package:asset_management/domain/usecases/user/find_all_user_use_case.dart';
import 'package:asset_management/domain/usecases/user/find_user_by_id_use_case.dart';
import 'package:asset_management/domain/usecases/user/update_user_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final FindAllUserUseCase _findAllUserUseCase;
  final FindUserByIdUseCase _findUserByIdUseCase;
  final UpdateUserUseCase _updateUserUseCase;
  final DeleteUserUseCase _deleteUserUseCase;
  final CreateUserUseCase _createUserUseCase;

  UserBloc(
    this._findAllUserUseCase,
    this._findUserByIdUseCase,
    this._updateUserUseCase,
    this._deleteUserUseCase,
    this._createUserUseCase,
  ) : super(UserState()) {
    on<OnFindAllUserEvent>((event, emit) async {
      emit(state.copyWith(status: StatusUser.loading));

      final failureOrUsers = await _findAllUserUseCase();

      return failureOrUsers.fold(
        (failure) => emit(
          state.copyWith(status: StatusUser.failed, message: failure.message),
        ),
        (users) =>
            emit(state.copyWith(status: StatusUser.success, users: users)),
      );
    });

    on<OnFindUserByIdEvent>((event, emit) async {
      emit(state.copyWith(status: StatusUser.loading));

      final failureOrUsers = await _findUserByIdUseCase(event.params);

      return failureOrUsers.fold(
        (failure) => emit(
          state.copyWith(status: StatusUser.failed, message: failure.message),
        ),
        (user) => emit(state.copyWith(status: StatusUser.success, user: user)),
      );
    });

    on<OnDeleteUserEvent>((event, emit) async {
      emit(state.copyWith(status: StatusUser.loading));

      final failureOrUsers = await _deleteUserUseCase(event.params);

      return failureOrUsers.fold(
        (failure) => emit(
          state.copyWith(status: StatusUser.failed, message: failure.message),
        ),
        (message) => emit(
          state.copyWith(
            status: StatusUser.success,
            message: message,
            users: state.users
              ?..removeWhere((element) => element.id == event.params),
          ),
        ),
      );
    });

    on<OnUpdateUserEvent>((event, emit) async {
      emit(state.copyWith(status: StatusUser.loading));

      final failureOrUsers = await _updateUserUseCase(event.params);

      return failureOrUsers.fold(
        (failure) => emit(
          state.copyWith(status: StatusUser.failed, message: failure.message),
        ),
        (user) => emit(
          state.copyWith(
            status: StatusUser.success,
            users: state.users
              ?..removeWhere((element) => element.id == event.params.id)
              ..add(user),
          ),
        ),
      );
    });

    on<OnCreateUserEvent>((event, emit) async {
      emit(state.copyWith(status: StatusUser.loading));

      final failureOrUsers = await _createUserUseCase(event.params);

      return failureOrUsers.fold(
        (failure) => emit(
          state.copyWith(status: StatusUser.failed, message: failure.message),
        ),
        (user) => emit(
          state.copyWith(
            status: StatusUser.success,
            users: state.users?..add(user),
          ),
        ),
      );
    });
  }
}
