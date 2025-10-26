// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Permissions extends Equatable {
  int? id;
  String? module;
  String? permission;

  Permissions({this.id, this.module, this.permission});

  @override
  List<Object?> get props => [id, module, permission];
}
