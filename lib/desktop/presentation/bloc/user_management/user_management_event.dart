part of 'user_management_bloc.dart';

class UserManagementEvent extends Equatable {
  const UserManagementEvent();

  @override
  List<Object> get props => [];
}

class OnFindAllUsers extends UserManagementEvent {}

class OnFindUserByName extends UserManagementEvent {
  final String params;

  const OnFindUserByName(this.params);
}

class OnFindAllPermissions extends UserManagementEvent {}

class OnCreateUser extends UserManagementEvent {
  final User params;

  const OnCreateUser(this.params);
}
