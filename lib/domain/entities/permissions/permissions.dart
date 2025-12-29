// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// Entity untuk item permission individual (Misal: id: 1, name: 'view')
class PermissionItem extends Equatable {
  final int? id;
  final String? name;

  const PermissionItem({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}

/// Entity utama untuk Permissions (Nested)
class Permissions extends Equatable {
  final String? module;
  final List<PermissionItem>? permissions;

  const Permissions({this.module, this.permissions});

  @override
  List<Object?> get props => [module, permissions];
}
