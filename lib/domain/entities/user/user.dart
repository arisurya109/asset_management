// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  int? id;
  String? username;
  String? name;
  int? isActive;
  List<Map<String, dynamic>>? modules;

  User({this.id, this.username, this.name, this.isActive, this.modules});

  @override
  List<Object?> get props {
    return [id, isActive, username, name, modules];
  }
}
