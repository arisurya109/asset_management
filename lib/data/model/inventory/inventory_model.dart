// ignore_for_file:  sort_constructors_first
// ignore_for_file: public_member_api_docs, must_be_immutable

import 'package:equatable/equatable.dart';

import 'package:asset_management/data/model/inventory/inventory_box_model.dart';
import 'package:asset_management/domain/entities/inventory/inventory.dart';

class InventoryModel extends Equatable {
  int? totalBox;
  List<InventoryBoxModel>? boxs;

  InventoryModel({this.totalBox, this.boxs});

  Inventory toEntity() {
    return Inventory(
      totalBox: totalBox,
      boxs: boxs?.map((e) => e.toEntity()).toList(),
    );
  }

  @override
  List<Object?> get props => [totalBox, boxs];

  factory InventoryModel.fromJson(Map<String, dynamic> map) {
    return InventoryModel(
      totalBox: map['total_box'] != null ? map['total_box'] as int : null,
      boxs: map['box'] != null
          ? List<InventoryBoxModel>.from(
              (map['box'] as List).map<InventoryBoxModel?>(
                (x) => InventoryBoxModel.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }
}
