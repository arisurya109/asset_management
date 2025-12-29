// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_management_bloc.dart';

enum StatusUserManagement { initial, loading, failure, loaded, successAdd }

// ignore: must_be_immutable
class UserManagementState extends Equatable {
  StatusUserManagement? status;
  List<User>? users;
  List<Permissions>? permissions;
  String? message;

  UserManagementState({
    this.status = StatusUserManagement.initial,
    this.users,
    this.permissions,
    this.message,
  });

  @override
  List<Object?> get props => [status, users, message, permissions];

  UserManagementState copyWith({
    StatusUserManagement? status,
    List<User>? users,
    List<Permissions>? permissions,
    String? message,
  }) {
    return UserManagementState(
      status: status ?? this.status,
      users: users ?? this.users,
      permissions: permissions ?? this.permissions,
      message: message ?? this.message,
    );
  }
}
