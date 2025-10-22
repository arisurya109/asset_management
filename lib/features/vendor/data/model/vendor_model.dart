// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import '../../domain/entities/vendor.dart';

// ignore: must_be_immutable
class VendorModel extends Equatable {
  int? id;
  String? name;
  String? init;
  String? phone;
  String? description;

  VendorModel({this.id, this.name, this.init, this.phone, this.description});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'init': init,
      'phone': phone,
      'description': description,
    };
  }

  factory VendorModel.fromJson(Map<String, dynamic> map) {
    return VendorModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      init: map['init'] != null ? map['init'] as String : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      description: map['description'] != null
          ? map['description'] as String
          : null,
    );
  }

  factory VendorModel.fromEntity(Vendor params) {
    return VendorModel(
      id: params.id,
      name: params.name,
      init: params.init,
      phone: params.phone,
      description: params.description,
    );
  }

  Vendor toEntity() {
    return Vendor(
      id: id,
      name: name,
      init: init,
      phone: phone,
      description: description,
    );
  }

  @override
  List<Object?> get props {
    return [id, name, init, phone, description];
  }
}
