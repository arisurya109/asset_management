import 'package:asset_management/domain/entities/permissions/permissions.dart';
import 'package:equatable/equatable.dart';

class PermissionItemModel extends Equatable {
  final int? id;
  final String? name;

  const PermissionItemModel({this.id, this.name});

  factory PermissionItemModel.fromJson(Map<String, dynamic> json) {
    return PermissionItemModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  PermissionItem toEntity() {
    return PermissionItem(id: id, name: name);
  }

  @override
  List<Object?> get props => [id, name];
}

class PermissionsModel extends Equatable {
  final String? module;
  final List<PermissionItemModel>? permissions;

  const PermissionsModel({this.module, this.permissions});

  @override
  List<Object?> get props => [module, permissions];

  Permissions toEntity() {
    return Permissions(
      module: module,
      permissions: permissions?.map((p) => p.toEntity()).toList(),
    );
  }

  factory PermissionsModel.fromJson(Map<String, dynamic> map) {
    return PermissionsModel(
      module: map['module'] as String?,
      permissions: map['permissions'] != null
          ? (map['permissions'] as List)
                .map(
                  (p) =>
                      PermissionItemModel.fromJson(p as Map<String, dynamic>),
                )
                .toList()
          : null,
    );
  }
}
