// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class AssetsEntity extends Equatable {
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

  AssetsEntity({
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
}
