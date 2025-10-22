// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Vendor extends Equatable {
  int? id;
  String? name;
  String? init;
  String? phone;
  String? description;

  Vendor({this.id, this.name, this.init, this.phone, this.description});

  @override
  List<Object?> get props {
    return [id, name, init, phone, description];
  }
}
