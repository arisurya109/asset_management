// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'permissions_bloc.dart';

enum StatusPermissions { initial, loading, failed, success }

// ignore: must_be_immutable
class PermissionsState extends Equatable {
  StatusPermissions? status;
  List<Permissions>? permissions;
  String? message;

  PermissionsState({
    this.status = StatusPermissions.initial,
    this.permissions,
    this.message,
  });

  @override
  List<Object?> get props => [status, permissions, message];

  PermissionsState copyWith({
    StatusPermissions? status,
    List<Permissions>? permissions,
    String? message,
  }) {
    return PermissionsState(
      status: status ?? this.status,
      permissions: permissions ?? this.permissions,
      message: message ?? this.message,
    );
  }
}
