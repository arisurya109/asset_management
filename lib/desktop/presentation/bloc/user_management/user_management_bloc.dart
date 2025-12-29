import 'package:asset_management/domain/entities/permissions/permissions.dart';
import 'package:asset_management/domain/entities/user/user.dart';
import 'package:asset_management/domain/usecases/permissions/find_all_permissions_use_case.dart';
import 'package:asset_management/domain/usecases/user/create_user_use_case.dart';
import 'package:asset_management/domain/usecases/user/find_all_user_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_management_event.dart';
part 'user_management_state.dart';

class UserManagementBloc
    extends Bloc<UserManagementEvent, UserManagementState> {
  final FindAllUserUseCase _findAllUserUseCase;
  final FindAllPermissionsUseCase _findAllPermissionsUseCase;
  final CreateUserUseCase _createUserUseCase;

  UserManagementBloc(
    this._findAllUserUseCase,
    this._findAllPermissionsUseCase,
    this._createUserUseCase,
  ) : super(UserManagementState()) {
    on<OnFindAllUsers>((event, emit) async {
      final failureOrUsers = await _findAllUserUseCase();

      return failureOrUsers.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusUserManagement.failure,
            message: failure.message,
          ),
        ),
        (users) => emit(
          state.copyWith(status: StatusUserManagement.loaded, users: users),
        ),
      );
    });
    on<OnFindUserByName>((event, emit) async {});

    on<OnCreateUser>((event, emit) async {
      emit(state.copyWith(status: StatusUserManagement.loading));

      await Future.delayed(Duration(seconds: 5));

      final failureOrUser = await _createUserUseCase(event.params);

      return failureOrUser.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusUserManagement.failure,
            message: failure.message,
          ),
        ),
        (user) => emit(
          state.copyWith(
            status: StatusUserManagement.successAdd,
            message: 'Successfully add new user',
            users: [...?state.users, user],
          ),
        ),
      );
    });

    on<OnFindAllPermissions>((event, emit) async {
      final failureOrPermissions = await _findAllPermissionsUseCase();

      return failureOrPermissions.fold(
        (failure) => emit(
          state.copyWith(
            status: StatusUserManagement.failure,
            message: failure.message,
          ),
        ),
        (permissions) => emit(
          state.copyWith(
            status: StatusUserManagement.loaded,
            permissions: permissions,
          ),
        ),
      );
    });
  }
}
