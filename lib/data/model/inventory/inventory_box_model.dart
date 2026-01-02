// ignore_for_file: public_member_api_docs, must_be_immutable, sort_constructors_first

import 'package:asset_management/domain/entities/inventory/inventory_box.dart';
import 'package:equatable/equatable.dart';

class InventoryBoxModel extends Equatable {
  InventoryBoxModel({this.id, this.name, this.quantityAsset, this.boxType});

  int? id;
  String? name;
  int? quantityAsset;
  String? boxType;

  factory InventoryBoxModel.fromJson(Map<String, dynamic> map) {
    return InventoryBoxModel(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      quantityAsset: map['quantity'] != null ? map['quantity'] as int : null,
      boxType: map['type'] != null ? map['type'] as String : null,
    );
  }

  InventoryBox toEntity() {
    return InventoryBox(
      id: id,
      name: name,
      boxType: boxType,
      quantityAsset: quantityAsset,
    );
  }

  @override
  List<Object?> get props => [id, name, quantityAsset, boxType];
}
