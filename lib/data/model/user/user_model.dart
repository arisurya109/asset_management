// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import '../../../domain/entities/user/user.dart';

// ignore: must_be_immutable
class UserModel extends Equatable {
  int? id;
  String? username;
  String? name;
  int? isActive;
  List<dynamic>? modules;

  UserModel({this.id, this.username, this.name, this.isActive, this.modules});

  @override
  List<Object?> get props {
    return [id, isActive, username, name, modules];
  }

  User toEntity() {
    return User(
      id: id,
      username: username,
      name: name,
      isActive: isActive,
      modules: modules,
    );
  }

  factory UserModel.fromEntity(User params) {
    return UserModel(
      id: params.id,
      username: params.username,
      name: params.name,
      isActive: params.isActive,
      modules: params.modules,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] != null ? map['id'] as int : null,
      username: map['username'] != null ? map['username'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      isActive: map['is_active'] != null ? map['is_active'] as int : null,
      modules: map['modules'] != null ? map['modules'] as List<dynamic> : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'is_active': isActive,
      'modules': modules,
    };
  }
}
