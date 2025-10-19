// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Location extends Equatable {
  int? id;
  String? name;
  String? locationType;
  String? boxType;
  String? code;
  String? init;
  int? parentId;
  String? parentName;

  Location({
    this.id,
    this.name,
    this.locationType,
    this.boxType,
    this.code,
    this.init,
    this.parentId,
    this.parentName,
  });

  @override
  List<Object?> get props {
    return [id, name, locationType, boxType, code, init, parentId, parentName];
  }
}
