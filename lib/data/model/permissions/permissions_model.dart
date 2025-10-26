// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:asset_management/domain/entities/permissions/permissions.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class PermissionsModel extends Equatable {
  int? id;
  String? module;
  String? permission;

  PermissionsModel({this.id, this.module, this.permission});

  @override
  List<Object?> get props => [id, module, permission];

  factory PermissionsModel.fromJson(Map<String, dynamic> map) {
    return PermissionsModel(
      id: map['id'] != null ? map['id'] as int : null,
      module: map['module_permission_name'] != null
          ? map['module_permission_name'] as String
          : null,
      permission: map['module_permission_label'] != null
          ? map['module_permission_label'] as String
          : null,
    );
  }

  Permissions toEntity() {
    return Permissions(id: id, module: module, permission: permission);
  }
}
