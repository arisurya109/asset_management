// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable

import '../../domain/entities/asset_entity.dart';
import 'package:equatable/equatable.dart';

class AssetsModel extends Equatable {
  int? id;
  String? serialNumber;
  String? assetCode;
  String? status;
  String? conditions;
  int? quantity;
  int? uom;
  String? model;
  String? category;
  String? brand;
  String? types;
  String? color;
  String? location;
  String? purchaseOrder;
  String? remarks;

  AssetsModel({
    this.id,
    this.serialNumber,
    this.assetCode,
    this.status,
    this.conditions,
    this.quantity,
    this.uom,
    this.model,
    this.category,
    this.brand,
    this.types,
    this.color,
    this.location,
    this.purchaseOrder,
    this.remarks,
  });

  @override
  List<Object?> get props {
    return [
      id,
      serialNumber,
      assetCode,
      status,
      conditions,
      quantity,
      uom,
      model,
      category,
      brand,
      types,
      color,
      location,
      purchaseOrder,
      remarks,
    ];
  }

  factory AssetsModel.fromMap(Map<String, dynamic> map) {
    return AssetsModel(
      id: map['id'] != null ? map['id'] as int : null,
      serialNumber: map['serial_number'] != null
          ? map['serial_number'] as String
          : null,
      assetCode: map['asset_code'] != null ? map['asset_code'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      conditions: map['conditions'] != null
          ? map['conditions'] as String
          : null,
      quantity: map['quantity'] != null ? map['quantity'] as int : null,
      uom: map['uom'] != null ? map['uom'] as int : null,
      model: map['model'] != null ? map['model'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
      brand: map['brand'] != null ? map['brand'] as String : null,
      types: map['types'] != null ? map['types'] as String : null,
      color: map['color'] != null ? map['color'] as String : null,
      location: map['location'] != null ? map['location'] as String : null,
      purchaseOrder: map['purchase_order'] != null
          ? map['purchase_order'] as String
          : null,
      remarks: map['remarks'] != null ? map['remarks'] as String : null,
    );
  }

  AssetsEntity toEntity() {
    return AssetsEntity(
      id: id,
      assetCode: assetCode,
      brand: brand,
      category: category,
      color: color,
      conditions: conditions,
      location: location,
      model: model,
      purchaseOrder: purchaseOrder,
      quantity: quantity,
      remarks: remarks,
      serialNumber: serialNumber,
      status: status,
      types: types,
      uom: uom,
    );
  }
}
