// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  int? id;
  String? username;
  String? password;
  String? name;
  int? isActive;
  DateTime? createdAt;
  String? createdBy;
  List<dynamic>? modules;

  User({
    this.id,
    this.username,
    this.password,
    this.name,
    this.isActive,
    this.createdAt,
    this.createdBy,
    this.modules,
  });

  @override
  List<Object?> get props {
    return [
      id,
      username,
      password,
      name,
      isActive,
      createdAt,
      createdBy,
      modules,
    ];
  }
}
